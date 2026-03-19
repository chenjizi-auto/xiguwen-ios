//
//  DiPuRequestCityViewModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/24/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DiPuRequestCityViewModel.h"
#import "CwApiCacheStore.h"
#import "CwCacheableRequestHelper.h"

static NSString * const CwRegionAPIPath = @"appapi/System/huoqudiqu";
static NSString * const CwRegionCacheKey = @"appapi/System/huoqudiqu_global";
static const NSTimeInterval CwRegionCacheTTL = 7 * 24 * 60 * 60;

@implementation DiPuRequestCityViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
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
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                __block BOOL hasFallbackData = NO;
                NSArray *regionTree = [[CwApiCacheStore sharedStore] cachedRegionTree];
                if (regionTree.count > 0) {
                    hasFallbackData = YES;
                    [subscriber sendNext:regionTree];
                } else {
                    id cachedObject = [[CwApiCacheStore sharedStore] cachedJSONObjectForKey:CwRegionCacheKey allowExpired:YES];
                    if ([cachedObject isKindOfClass:[NSArray class]] && [cachedObject count] > 0) {
                        hasFallbackData = YES;
                        [subscriber sendNext:cachedObject];
                    }
                }

                RACSignal *networkSignal = [CwCacheableRequestHelper signalWithURL:[HOMEURL stringByAppendingString:CwRegionAPIPath]
                                                                             method:POST
                                                                            loading:@"请求中..."
                                                                             params:input
                                                                                ttl:CwRegionCacheTTL
                                                                       cacheEnabled:NO
                                                                        errorDomain:@"com.xiguwen.cache.region"
                                                                       errorMessage:@"地区数据加载失败"];
                RACDisposable *networkDisposable = [networkSignal subscribeNext:^(id  _Nullable x) {
                    if ([x isKindOfClass:[NSArray class]] && [x count] > 0) {
                        [[CwApiCacheStore sharedStore] saveJSONObject:x
                                                           forAPIPath:CwRegionAPIPath
                                                             cacheKey:CwRegionCacheKey
                                                               params:input
                                                               userId:nil
                                                                  ttl:CwRegionCacheTTL];
                        [[CwApiCacheStore sharedStore] replaceRegionsWithJSONArray:x];
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
    return _DataCommand;
}

@end
