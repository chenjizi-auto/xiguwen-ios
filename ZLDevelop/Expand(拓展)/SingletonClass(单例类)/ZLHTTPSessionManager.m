//
//  ZLHTTPSessionManager.m
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLHTTPSessionManager.h"
#import <AFNetworking.h>

@implementation ZLFileModel

@end

@interface ZLHTTPSessionManager ()

///请求的管理对象
@property (nonatomic,strong) AFHTTPSessionManager *requestManager;
///当前网络状态
@property (nonatomic,unsafe_unretained) AFNetworkReachabilityStatus networkStatus;

@end

@implementation ZLHTTPSessionManager

+ (instancetype)manager {
    static ZLHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [self new];
        sessionManager.requestManager = [AFHTTPSessionManager manager];
        sessionManager.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/javascript", @"application/json", @"text/plain", nil];
        [sessionManager.requestManager.requestSerializer setTimeoutInterval:30];
        
        //检测网络(持续监测……)
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [reachabilityManager startMonitoring];
        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            sessionManager.networkStatus = status;
            if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
                //同步服务器时间
//                [configManager syncServerTime];
            }
        }];
    });
    return sessionManager;
}

/**POST请求
 *@param path 路径
 *@param dict 参数
 *@param isPost POST/GET
 *@param modelArray 图片数据
 *@param isAddHeader 是否添加Header
 *@param complete 处理结果
 */
+ (void)requestDataWithUrlPath:(NSString *)path Params:(id)dict POST:(BOOL)isPost ModelArray:(NSArray <ZLFileModel *>*)modelArray HttpHeader:(BOOL)isAddHeader Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, id responseObject))complete {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    ZLHTTPSessionManager *manager = [self manager];
    manager.requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *urlPath = [NSString stringWithFormat:@"%@",path];
    NSLog(@"\n\n%@\n%@\n\n.",urlPath,dict ? [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding] : @"");
    if (isAddHeader) {
        NSString *basicString = [NSString stringWithFormat:@"Token %@",[UserData keyForUser:@"token"]];
        [manager.requestManager.requestSerializer setValue:basicString forHTTPHeaderField:@"Authorization"];
        [manager.requestManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        NSLog(@"%@",manager.requestManager.requestSerializer.HTTPRequestHeaders);
    }
    if (isPost) {
        manager.requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestManager POST:urlPath parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (modelArray.count) {
                for (NSInteger a = 0; a < modelArray.count; a++) {
                    ZLFileModel *fileModel = modelArray[a];
                    [formData appendPartWithFileData:fileModel.fileData name:fileModel.fileName fileName:fileModel.filePath mimeType:fileModel.fileType];
                }
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self disposeResponseWithObject:responseObject Results:^(ZLSessionManagerErrorState errorState, id object) {
                if ([object isKindOfClass:[NSDictionary class]]) {
                    object = [self screeningNullWithDictionary:object];
                }else if ([object isKindOfClass:[NSArray class]]) {
                    object = [self screeningNullWithArray:object];
                }
                complete(errorState,object);
                return;
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self disposeErrorWithError:error Results:^(ZLSessionManagerErrorState errorState) {
                complete(errorState,nil);
            }];
        }];
    }else {
        manager.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestManager GET:urlPath parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self disposeResponseWithObject:responseObject Results:^(ZLSessionManagerErrorState errorState, id object) {
                if ([object isKindOfClass:[NSDictionary class]]) {
                    object = [self screeningNullWithDictionary:object];
                }else if ([object isKindOfClass:[NSArray class]]) {
                    object = [self screeningNullWithArray:object];
                }
                complete(errorState,object);
                return;
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self disposeErrorWithError:error Results:^(ZLSessionManagerErrorState errorState) {
                complete(errorState,nil);
            }];
        }];
    }
}

/**处理成功结果
 *@param responseObject 成功返回的信息
 *@param complete 处理结果
 */
+ (void)disposeResponseWithObject:(id)responseObject Results:(void (^)(ZLSessionManagerErrorState errorState, id object))complete {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //将结果转换为字典
    if ([responseObject isKindOfClass:[NSData class]]) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
    }
    //调试打印
    NSLog(@"%@\n--%@",[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding],responseObject[@"message"]);
    //因环境导致的Token不同问题，要让用户重新登录
    if ([responseObject[@"code"] respondsToSelector:@selector(integerValue)]) {
        if ([responseObject[@"code"] integerValue] == 1) {
//            UIViewController *currentRootVc = [UIApplication sharedApplication].delegate.window.rootViewController;
//            if (![currentRootVc isKindOfClass:[ZLLoginViewController class]]) {
//                [userManager exitCurrentAccount];
//                [UIApplication sharedApplication].delegate.window.rootViewController = [ZLLoginViewController new];
//            }
            return ;
        }
    }
    //处理下文
    complete(ZLSessionManagerErrorStateNull, responseObject);
}

/**处理错误
 *@param error 错误信息
 *@param complete 处理结果
 */
+ (void)disposeErrorWithError:(NSError *)error Results:(void (^)(ZLSessionManagerErrorState errorState))complete {
    NSLog(@"\n\n%@\n\n.",error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([error.localizedDescription isEqualToString:@"请求超时"]) {
        //超时
        complete(ZLSessionManagerErrorStateTimeout);
    }else {
        //检测网络
        complete(([ZLHTTPSessionManager manager].networkStatus == AFNetworkReachabilityStatusNotReachable) ? ZLSessionManagerErrorStateNoNetwork : ZLSessionManagerErrorStateServerFailure);
    }
}

#pragma mark - 替换空值
+ (NSMutableDictionary *)screeningNullWithDictionary:(NSDictionary *)dict{
    NSArray *dictArray = dict.allKeys;
    NSInteger count = dictArray.count;
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        NSString *string = dictArray[index];
        NSObject *obj = dict[string];
        if ([obj isKindOfClass:[NSNull class]]) {
            [dictM setObject:@"" forKey:string];
            continue;
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dictM2 = [self screeningNullWithDictionary:(NSDictionary *)obj];
            [dictM setObject:dictM2 forKey:string];
            continue;
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *objArrayM = [self screeningNullWithArray:(NSArray *)obj];
            [dictM setObject:objArrayM forKey:string];
            continue;
        }
        [dictM setObject:obj forKey:string];
    }
    return dictM;
}
+ (NSMutableArray *)screeningNullWithArray:(NSArray *)array{
    NSArray *objArray = (NSArray *)array;
    NSInteger count = objArray.count;
    NSMutableArray *objArrayM = [[NSMutableArray alloc]initWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        NSObject *obj = objArray[index];
        if ([obj isKindOfClass:[NSNull class]]) {
            [objArrayM addObject:@""];
            continue;
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dictM = [self screeningNullWithDictionary:(NSDictionary *)obj];
            [objArrayM addObject:dictM];
            continue;
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *objArrayM2 = [self screeningNullWithArray:(NSArray *)obj];
            [objArrayM addObject:objArrayM2];
            continue;
        }
        [objArrayM addObject:obj];
    }
    return objArrayM;
}

@end
