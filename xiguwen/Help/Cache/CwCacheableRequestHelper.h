#import <Foundation/Foundation.h>
#import "RequestManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CwCacheableRequestHelper : NSObject

+ (RACSignal *)signalWithURL:(NSString *)url
                      method:(RequestMethod)method
                     loading:(nullable NSString *)loading
                       params:(nullable NSDictionary *)params
                         ttl:(NSTimeInterval)ttl
                cacheEnabled:(BOOL)cacheEnabled
                 errorDomain:(NSString *)errorDomain
                errorMessage:(NSString *)errorMessage;

@end

NS_ASSUME_NONNULL_END
