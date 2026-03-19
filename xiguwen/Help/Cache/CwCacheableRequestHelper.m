#import "CwCacheableRequestHelper.h"
#import "CwApiCacheStore.h"

@implementation CwCacheableRequestHelper

+ (RACSignal *)signalWithURL:(NSString *)url
                      method:(RequestMethod)method
                     loading:(NSString *)loading
                      params:(NSDictionary *)params
                         ttl:(NSTimeInterval)ttl
                cacheEnabled:(BOOL)cacheEnabled
                 errorDomain:(NSString *)errorDomain
                errorMessage:(NSString *)errorMessage {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *userId = @"";
        if ([UserData UserLoginState]) {
            userId = [NSString stringWithFormat:@"%ld", (long)[UserData sharedManager].userInfoModel.id];
        }

        NSString *cacheKey = nil;
        __block BOOL hasFallbackData = NO;
        if (cacheEnabled) {
            cacheKey = [[CwApiCacheStore sharedStore] cacheKeyForAPIPath:url params:params userId:userId];
            id cachedObject = [[CwApiCacheStore sharedStore] cachedJSONObjectForKey:cacheKey allowExpired:YES];
            if (cachedObject) {
                hasFallbackData = YES;
                [subscriber sendNext:cachedObject];
            }
        }

        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:method
                                                                         loding:loading
                                                                            dic:params
                                                                       progress:nil
                                                                        success:^(NSURLSessionDataTask *task, id response) {
                                                                            id normalizedResponse = response;
                                                                            if ([response isKindOfClass:[NSDictionary class]]) {
                                                                                NSDictionary *responseDictionary = (NSDictionary *)response;
                                                                                NSInteger code = [responseDictionary[@"code"] respondsToSelector:@selector(integerValue)] ? [responseDictionary[@"code"] integerValue] : 0;
                                                                                if (responseDictionary[@"data"]) {
                                                                                    normalizedResponse = responseDictionary[@"data"];
                                                                                }
                                                                                if (code != 0) {
                                                                                    NSError *businessError = [NSError errorWithDomain:errorDomain
                                                                                                                                 code:code
                                                                                                                             userInfo:@{NSLocalizedDescriptionKey : responseDictionary[@"message"] ?: errorMessage ?: @"加载失败"}];
                                                                                    if (hasFallbackData) {
                                                                                        [subscriber sendCompleted];
                                                                                    } else {
                                                                                        [subscriber sendError:businessError];
                                                                                    }
                                                                                    return;
                                                                                }
                                                                            }

                                                                            if (cacheEnabled && normalizedResponse) {
                                                                                [[CwApiCacheStore sharedStore] saveJSONObject:normalizedResponse
                                                                                                                   forAPIPath:url
                                                                                                                     cacheKey:cacheKey
                                                                                                                       params:params
                                                                                                                       userId:userId
                                                                                                                          ttl:ttl];
                                                                            }
                                                                            [subscriber sendNext:normalizedResponse];
                                                                            [subscriber sendCompleted];
                                                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                            if (hasFallbackData) {
                                                                                [subscriber sendCompleted];
                                                                                return;
                                                                            }
                                                                            NSError *safeError = error ?: [NSError errorWithDomain:errorDomain
                                                                                                                               code:-1
                                                                                                                           userInfo:@{NSLocalizedDescriptionKey : errorMessage ?: @"加载失败"}];
                                                                            [subscriber sendError:safeError];
                                                                        }];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return signal;
}

@end
