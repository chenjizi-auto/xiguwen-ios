//
//  RequestManager.m
//  Sahara
//
//  Created by Chen on 15/6/12.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import "RequestManager.h"
#import "NavigateManager.h"

@implementation RequestManager {
    AFNetworkReachabilityManager *afNetworkReachabilityManager;
    AFHTTPSessionManager *manager;
    
    NSInteger _seqCount;
    //
    //    //a标签
    //    NSString *_alias;
}




/**
 通过RAC进行请求
 
 @param url 地址
 @param method 请求类型
 @param loding 加载图
 @param dic 传值
 @return 返回信号
 */
- (RACSignal *)RACRequestUrl:(NSString *)url
                      method:(RequestMethod)method
                      loding:(NSString *)loding
                         dic:(NSDictionary *)dic {
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSURLSessionDataTask *task = [self requestUrl:url
                                               method:method
                                               loding:loding
                                                  dic:dic
                                             progress:^(NSProgress *progress) {
                                                 
//                                                 [subscriber sendNext:progress];
                                             }
                                              success:^(NSURLSessionDataTask *task, id response) {
                                                  
                                                  [NavigateManager hiddenLoadingMessage];
                                                  //请求结束状态栏隐藏网络活动标志：
                                                  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                  //        if (loding) {
                                                  //            [NavigateManager hiddenLoadingMessage];
                                                  //        }
                                                  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                                  
                                                  if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                                      DLog(@"%@",[NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]);
                                                  }
                                                  
                                                  
                                                  //        NSURL *dataUrl = [NSURL URLWithString:conplishURl];
                                                  //        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:dataUrl];//id: NSHTTPCookie
                                                  //        if (cookies.count > 0) {
                                                  //            //NSDictionary *sheaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
                                                  //            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
                                                  //            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"kUserDefaultsCookie"];
                                                  //            [[NSUserDefaults standardUserDefaults] synchronize];
                                                  //        }
                                                  if ([response[@"code"] integerValue] == 0) {
                                                      
                                                      [subscriber sendNext:response[@"data"]];
                                                      
                                                  } else {
                                                      [subscriber sendError:nil];
                                                      [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
//                                                      [NavigateManager showMessage:@"空空如也"];
                                                  }
                                                  
                                                  [subscriber sendCompleted];
                                                  
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            //请求结束状态栏隐藏网络活动标志：
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            DLog(@"失败-------%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                //            if (loding) {
                //                [NavigateManager hiddenLoadingMessage];
                //            }
                
                
                //            [NavigateManager showMessage:error.localizedDescription];
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                
                if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                    DLog(@"%@",[NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]);
                    NSDictionary *info = httpResponse.allHeaderFields;
                    [NavigateManager showMessage:[[NSString stringWithFormat:@"%@",info[@"message"]] replaceUnicode]];
                } else {
                    [NavigateManager showMessage:error.localizedDescription];
                }
            });
            
            [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
            [subscriber sendCompleted];
        }];
        // 在信号量作废时，取消网络请求
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return requestSignal;
}



















- (NSURLSessionDataTask *)requestUrl:(NSString *)url
                              method:(RequestMethod)method
                              loding:(NSString *)loding
                                 dic:(NSDictionary *)dic
                            progress:(void (^)(NSProgress *))progress
                             success:(void (^)(NSURLSessionDataTask *, id))success
                             failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    //加载中
    if (loding) {
//        [NavigateManager showLoadingMessage:loding];
    }
    
    
    if ([UserData keyForUser:@"token"]) {
        
        NSString *tokenString = [NSString stringWithFormat:@"Token %@",[UserData keyForUser:@"token"]];
        [manager.requestSerializer setValue:tokenString forHTTPHeaderField:@"Authorization"];
    }
    
    //
//    if ([UserData sharedManager].userInfoModel.salt) {
//        
//        [manager.requestSerializer setValue:S_Integer(_seqCount++) forHTTPHeaderField:@"Seq"];
//        NSString *sign;
//        if (dic) {
//            sign = [NSString stringWithFormat:@"%ld%@%@",_seqCount,[RequestManager SbJson:dic],[UserData sharedManager].userInfoModel.salt.clientSalt];
//        } else {
//            sign = [NSString stringWithFormat:@"%ld%@",_seqCount,[UserData sharedManager].userInfoModel.salt.clientSalt];
//        }
//        
//        [manager.requestSerializer setValue:[sign md5String] forHTTPHeaderField:@"Sign"];
//    }
    //在向服务端发送请求状态栏显示网络活动标志：
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"kUserDefaultsCookie"];
    //    if([cookiesdata length]) {
    //        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
    //        NSHTTPCookie *cookie; for (cookie in cookies) {
    //            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    //        }
    //    }
    
    DLog(@"%@ ********************* %@ \n请求头数据:%@",url,dic,manager.requestSerializer.HTTPRequestHeaders);
    //    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    switch (method) {
        case POST:
            return [self PostUrl:url
                             dic:dic
                        progress:progress
                         success:success
                         failure:failure];
            break;
        case PUT:
            return [self PUTUrl:url
                            dic:dic
                       progress:progress
                        success:success
                        failure:failure];
            break;
        case DELETE:
            return [self DELETEUrl:url
                               dic:dic
                          progress:progress
                           success:success
                           failure:failure];
            break;
            
        default:
            return [self GETUrl:url
                            dic:dic
                       progress:progress
                        success:success
                        failure:failure];
            break;
    }
}































+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"robby712"
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}

+ (id)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self stutas];
    }
    return self;
}
- (void)stutas {
    /**
     *  @brief  检查是否网络畅通
     */
    afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         
         if (status == AFNetworkReachabilityStatusNotReachable) {
             
             [NavigateManager showMessage:@"无网络连接！"];
             return ;
         }
         
     }];
    //    [afNetworkReachabilityManager stopMonitoring];
    
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //        [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    //    [manager.requestSerializer setValue:@"application/json; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer.timeoutInterval = 20;
//    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil]];
    manager.responseSerializer = responseSerializer;
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"der"];
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    securityPolicy.validatesDomainName = NO;
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];
    [manager setSecurityPolicy:securityPolicy];
    
    __weak typeof(AFHTTPSessionManager)*weakManager = manager;
    
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential = nil;
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) { //如果有受信任的证书,如果是自签名的证书,这里会是NSURLAuthenticationMethodClientCertificate
            if([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if(credential) {
                    disposition =NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            //只有双向认证才会走这里
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"client"ofType:@"p12"];
            NSFileManager *fileManager =[NSFileManager defaultManager];
            if(![fileManager fileExistsAtPath:p12]) {
                NSLog(@"client.p12:not exist");
            }else{
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                if ([RequestManager extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data]) {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void*certs[] = {certificate};
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
    
}


//    //监听用户ID
//    [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"UserId" options:NSKeyValueObservingOptionNew context:NULL];

////是否接收到
//static BOOL isReceviedNotification = NO;
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//
//    if ([keyPath isEqualToString:@"UserId"]) {
//        DLog(@"变化值%@",change);
//        if (change[@"new"]) {
//            _alias = [NSString stringWithFormat:@"%@",change[@"new"]];
//        } else {
//            _alias = [NSString stringWithFormat:@"%@",change[@"old"]];
//        }
//        if (!isReceviedNotification) {
//            [self performSelector:@selector(SetTag) withObject:nil afterDelay:2];
//        }
//        isReceviedNotification = YES;
//    }
//}











//上传请求
- (NSURLSessionDataTask *)PostUrl:(NSString *)url
                              dic:(NSDictionary *)dic
                        progress:(void (^)(NSProgress *))progress
                          success:(void (^)(NSURLSessionDataTask *task, id response))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //请求
   return [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
       if (progress) {
           progress(uploadProgress);
       }
       
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"成功-------%@   %@",responseObject,url);
        
        success(task,responseObject);
        if ([responseObject[@"code"] integerValue] == 0) {
            [NavigateManager hiddenLoadingMessage];
//        } else {
//            [NavigateManager showMessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NavigateManager hiddenLoadingMessage];
        failure(task,error);
    }];
    
}

// 额外添加方法




- (NSURLSessionDataTask *)GETUrl:(NSString *)url
                             dic:(NSDictionary *)dic
                        progress:(void (^)(NSProgress *))progress
                         success:(void (^)(NSURLSessionDataTask *task, id response))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{

    //请求
    return [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"成功-------%@   %@",responseObject,url);
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(task,error);
    }];
    
}
- (NSURLSessionDataTask *)PUTUrl:(NSString *)url
                             dic:(NSDictionary *)dic
                        progress:(void (^)(NSProgress *))progress
                         success:(void (^)(NSURLSessionDataTask *task, id response))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{

    //请求
    return [manager PUT:url
             parameters:dic
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"成功-------%@   %@",responseObject,url);
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(task,error);
    }];
    
}
- (NSURLSessionDataTask *)DELETEUrl:(NSString *)url
                                dic:(NSDictionary *)dic
                           progress:(void (^)(NSProgress *))progress
                            success:(void (^)(NSURLSessionDataTask *task, id response))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //请求
    return [manager DELETE:url
                parameters:dic
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"成功-------%@   %@",responseObject,url);
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
}





//上传图片
-(void)updatePic:(NSData *)data parameters:(id)parameters response:(void (^)(id response))callBack
{
    
    [manager POST:URL_updateUser parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"image.png" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"图片上传结果:%@",responseObject);
        callBack(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"图片上传结果:%@",error);
        callBack(nil);
    }];
}
//上传多张图片
-(NSURLSessionDataTask *)updatePics:(NSArray *)pics url:(NSString *)url parameters:(id)parameters response:(void (^)(id response))callBack {
    
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    return [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0;i < pics.count; i++) {
            UIImage *image = pics[i];
            NSData *data = UIImageJPEGRepresentation(image, 0.6f);
            [formData appendPartWithFileData:data name:@"file" fileName:@"image.png" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBack(nil);
    }];
    
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
//                                    multipartFormRequestWithMethod:@"POST"
//                                    URLString:url
//                                    parameters:parameters
//                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
////                                        [formData appendPartWithHeaders:@{@"Content-Type":@"application/json",
////                                                                          @"Accept":@"*/*"}
////                                                                   body:data];
//                                        for (int i = 0;i < pics.count; i++) {
//                                            UIImage *image = pics[i];
//                                            NSData *data = UIImageJPEGRepresentation(image, 0.3);
//                                            [formData appendPartWithFileData:data name:@"file" fileName:@"file" mimeType:@"image/jpeg"];
//                                        }
//
//                                    }
//                                    error:nil];
//    
//    
////    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
////                                    initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Content-Type"];
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request
//                                                               fromData:nil
//                                                               progress:^(NSProgress * _Nonnull uploadProgress) {
//                                                                   
//                                                               }
//                                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                                                          if (error)
//                                                          {
//                                                              callBack(nil);
//                                                              
//                                                          } else
//                                                          {
//                                                              callBack(responseObject);
//                                                          }
//                                                      }];
//    [uploadTask resume];
//    return uploadTask;
    
}
//上传图片
+(void)AA:(NSData *)data response:(void (^)(id response))callBack
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:@""
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData appendPartWithHeaders:@{@"Content-Type":@"application/json",
                                                                          @"Accept":@"*/*"}
                                                                   body:data];
                                    }
                                    error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request
                                                               fromData:nil
                                                               progress:^(NSProgress * _Nonnull uploadProgress) {
                                                                   
                                                               }
                                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                          if (error)
                                                          {
                                                              callBack(nil);
                                                              
                                                          } else
                                                          {
                                                              callBack(responseObject);
                                                          }
                                                      }];
    [uploadTask resume];
}


//
+ (NSString *)JsonStr:(id)obj
{
    //1）NSJSONReadingMutableContaines ,指定解析返回的是可变的数组或字典 ，这个方法还是比较使用的，因为如果json数据需要改，不用管撒
    
    //2）NSJSONReadingMutableLeaves ，指定叶节点是可变的字符串
    
    //3)   NSJSONReadingAllowFragments , 指定顶级节点可以部署数组或字典
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted// Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        DLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


+ (NSString *)SbJson:(id)obj
{
    SBJson4Writer *jsonParser = [[SBJson4Writer alloc] init];
    return [jsonParser stringWithObject:obj];
}

/*
 + (NSString *)ReWritePostUrl:(NSString *)url obj:(id)obj TheOrder:(NSArray*)order {
 
 if (!obj) {
 return url;
 }
 __block NSString *urlStr = [url stringByAppendingString:@"?"];
 if ([obj isKindOfClass:[NSDictionary class]]) {
 NSDictionary *dic = obj;
 if (order.count > 0) {
 [order enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 NSString * key = obj;
 urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[dic objectForKey:key]]];
 }];
 } else {
 [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
 urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
 }];
 }
 
 urlStr = [urlStr stringByReplacingCharactersInRange:NSMakeRange(urlStr.length - 1, 1) withString:@""];
 urlStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8));
 }
 return urlStr;
 }
 */

/*
 + (NSString *)XMlDictionary:(NSDictionary *)dic {
 __block NSString *string = @"<?xml version='1.0' encoding='UTF-8'?><request>";
 [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
 NSString *str = [NSString stringWithFormat:@"<%@>%@</%@>",key,obj,key];
 string = [string stringByAppendingString:str];
 }];
 string = [string stringByAppendingString:@"</request>"];
 DLog(@"%@",string);
 //    string = [string JSONString];
 //    string = [string dataUsingEncoding:NSUTF8StringEncoding];
 return string;
 }
 */

#pragma mark 获取当前屏幕显示的viewcontroller
+ (UIViewController *)myViewController {
    // 定义一个变量存放当前屏幕显示的viewcontroller
    UIViewController *result = nil;
    // 得到当前应用程序的主要窗口
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    // windowLevel是在 Z轴 方向上的窗口位置，默认值为UIWindowLevelNormal
    if (window.windowLevel != UIWindowLevelNormal)    {
        // 获取应用程序所有的窗口
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)        {
            // 找到程序的默认窗口（正在显示的窗口）
            if (tmpWin.windowLevel == UIWindowLevelNormal)            {
                // 将关键窗口赋值为默认窗口
                window = tmpWin;
                break;
            }
        }
    }
    // 获取窗口的当前显示视图
    UIView *frontView = [[window subviews] objectAtIndex:0];
    // 获取视图的下一个响应者，UIView视图调用这个方法的返回值为UIViewController或它的父视图
    id nextResponder = [frontView nextResponder];
    // 判断显示视图的下一个响应者是否为一个UIViewController的类对象
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
    //    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    //    while (topVC.presentedViewController) {
    //        topVC = topVC.presentedViewController;
    //    }
    //
    //    return topVC;
}

- (void)dealloc {
    [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:@"@UserId"];
}

@end





