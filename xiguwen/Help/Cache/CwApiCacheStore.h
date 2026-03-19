#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CwApiCacheStore : NSObject

+ (instancetype)sharedStore;

- (NSString *)cacheKeyForAPIPath:(NSString *)apiPath
                          params:(nullable NSDictionary *)params
                          userId:(nullable NSString *)userId;
- (nullable id)cachedJSONObjectForKey:(NSString *)cacheKey allowExpired:(BOOL)allowExpired;
- (void)saveJSONObject:(id)object
            forAPIPath:(NSString *)apiPath
              cacheKey:(NSString *)cacheKey
                params:(nullable NSDictionary *)params
                userId:(nullable NSString *)userId
                   ttl:(NSTimeInterval)ttl;

- (NSArray *)cachedRegionTree;
- (NSArray *)cachedRegionJSONArray;
- (NSString *)regionDisplayNameForProvinceId:(nullable NSString *)provinceId
                                      cityId:(nullable NSString *)cityId
                                    countyId:(nullable NSString *)countyId;
- (void)replaceRegionsWithJSONArray:(NSArray *)regions;

@end

NS_ASSUME_NONNULL_END
