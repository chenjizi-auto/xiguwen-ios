//
//  DipuDataModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DipuDataModel.h"
#import "CwApiCacheStore.h"
#import "CwCacheableRequestHelper.h"

static NSString * const CwOccupationAPIPath = @"appapi/Home/Classificationlist";
static NSString * const CwOccupationCacheKey = @"appapi/Home/Classificationlist_global";
static const NSTimeInterval CwOccupationCacheTTL = 7 * 24 * 60 * 60;

@implementation DipuDataModel
- (instancetype)init{
    self = [super init];
    if(self){
        @weakify(self);
        //处理正在请求状态
        [[self.DataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {

            @strongify(self);
        }];
        //请求成功
        [self.DataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {

            @strongify(self);
            [self.Subject sendNext:x];
        }];
        
        
        
        //处理正在请求状态
        [[self.DataIficationlistCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.DataIficationlistCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.DataIficationlistSubject sendNext:x];
        }];
        
        
        //处理正在请求状态
        [[self.UpDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.UpDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.UpDataSubject sendNext:x];
        }];
    }
    return self;
}
- (RACSubject *)Subject{
    if (!_Subject) _Subject = [RACSubject subject];
    return _Subject;
}

/**
 * appapi/Home/Classificationlist //职业类型
 * appapi/Myhome/storeinformation xi
 */
- (RACCommand *)DataCommand
{
    if (!_DataCommand) {
        @weakify(self);
        _DataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Myhome/storeinformation"]
                                                          method:POST
                                                          loding:@"请求中..."
                                                             dic:input];
        }];
    }
    return _DataCommand;
}

- (RACCommand *)DataIficationlistCommand{
    if (!_DataIficationlistCommand) {
        _DataIficationlistCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                __block BOOL hasFallbackData = NO;
                id cachedObject = [[CwApiCacheStore sharedStore] cachedJSONObjectForKey:CwOccupationCacheKey allowExpired:YES];
                if ([cachedObject isKindOfClass:[NSArray class]] && [cachedObject count] > 0) {
                    hasFallbackData = YES;
                    [subscriber sendNext:cachedObject];
                }

                RACSignal *networkSignal = [CwCacheableRequestHelper signalWithURL:[HOMEURL stringByAppendingString:CwOccupationAPIPath]
                                                                             method:POST
                                                                            loading:@"请求中..."
                                                                             params:input
                                                                                ttl:CwOccupationCacheTTL
                                                                       cacheEnabled:NO
                                                                        errorDomain:@"com.xiguwen.cache.occupation"
                                                                       errorMessage:@"职业分类加载失败"];
                RACDisposable *networkDisposable = [networkSignal subscribeNext:^(id  _Nullable x) {
                    if ([x isKindOfClass:[NSArray class]] && [x count] > 0) {
                        [[CwApiCacheStore sharedStore] saveJSONObject:x
                                                           forAPIPath:CwOccupationAPIPath
                                                             cacheKey:CwOccupationCacheKey
                                                               params:input
                                                               userId:nil
                                                                  ttl:CwOccupationCacheTTL];
                    }
                    [subscriber sendNext:x];
                    [subscriber sendCompleted];
                } error:^(NSError * _Nullable error) {
                    if (hasFallbackData) {
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:error];
                    }
                }];

                return [RACDisposable disposableWithBlock:^{
                    [networkDisposable dispose];
                }];
            }];
        }];
    }
    return _DataIficationlistCommand;
}

- (RACCommand *)UpDataCommand{
    if (!_UpDataCommand) {
        _UpDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Myhome/storeinformationedit"]
                                                          method:POST
                                                          loding:@"请求中..."
                                                             dic:input];
        }];
    }
    return _UpDataCommand;
}
- (RACSubject *)UpDataSubject
{
    if (!_UpDataSubject) {
        _UpDataSubject = [RACSubject subject];
    }
    return _UpDataSubject;
}

- (RACSubject *)DataIficationlistSubject{
    if (!_DataIficationlistSubject) {
        _DataIficationlistSubject = [RACSubject subject];
    }
    return _DataIficationlistSubject;
}


/**
 * 上传图片
 */
-(void)UpImage:(NSData*)ImageData indext:(NSInteger)indext{
    NSString *base64String = [ImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    AFHTTPSessionManager * mager = [AFHTTPSessionManager manager];
    mager.requestSerializer.timeoutInterval = 30;
    mager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];
    [mager POST:@"https://www.xiguwen520.com/appapi/System/uploadimgqiniu" parameters:@{@"img":[@"data:image/jpg;base64," stringByAppendingString:base64String],@"type":@"1"} progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"UpImage message is  %@",responseObject[@"message"]);
        if ([responseObject[@"code"] intValue]==0) {
            NSLog(@"UpImage success image is  %@",responseObject[@"data"]);
            self.ImageBlock(responseObject[@"data"],indext);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error.userInfo);
    }];
}

@end
