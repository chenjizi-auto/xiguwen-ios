#import "CwApiCacheStore.h"
#import "CwDBManager.h"
#import <fmdb/FMDB.h>

static NSString * const CwAPICacheCreateSQL =
@"CREATE TABLE IF NOT EXISTS api_cache ("
"id INTEGER PRIMARY KEY AUTOINCREMENT,"
"cache_key TEXT NOT NULL UNIQUE,"
"api_path TEXT NOT NULL,"
"params_md5 TEXT NOT NULL,"
"user_id TEXT DEFAULT '',"
"data_json TEXT NOT NULL,"
"data_version INTEGER DEFAULT 1,"
"expired_at INTEGER DEFAULT 0,"
"updated_at INTEGER NOT NULL,"
"created_at INTEGER NOT NULL"
");";

static NSString * const CwRegionCreateSQL =
@"CREATE TABLE IF NOT EXISTS region ("
"region_id TEXT PRIMARY KEY,"
"parent_id TEXT DEFAULT '',"
"region_name TEXT NOT NULL,"
"region_level INTEGER NOT NULL,"
"sort INTEGER DEFAULT 0,"
"initial TEXT DEFAULT '',"
"pinyin TEXT DEFAULT '',"
"status INTEGER DEFAULT 1,"
"is_new INTEGER DEFAULT 0,"
"full_name TEXT DEFAULT '',"
"payload_json TEXT DEFAULT '',"
"updated_at INTEGER NOT NULL"
");";

static NSString * const CwCacheMetaCreateSQL =
@"CREATE TABLE IF NOT EXISTS cache_meta ("
"cache_key TEXT PRIMARY KEY,"
"etag TEXT DEFAULT '',"
"server_version TEXT DEFAULT '',"
"last_sync_at INTEGER DEFAULT 0"
");";

static NSString * const CwRegionCacheLookupKey = @"appapi/System/huoqudiqu_global";

@interface CwApiCacheStore ()

@property (nonatomic, strong, readonly) CwDBManager *dbManager;

@end

@implementation CwApiCacheStore

+ (instancetype)sharedStore {
    static CwApiCacheStore *store;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[self alloc] initPrivate];
    });
    return store;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[CwApiCacheStore sharedStore]"
                                 userInfo:nil];
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _dbManager = [CwDBManager sharedManager];
        [self setupTablesIfNeeded];
    }
    return self;
}

- (void)setupTablesIfNeeded {
    [self.dbManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:CwAPICacheCreateSQL];
        [db executeUpdate:@"CREATE INDEX IF NOT EXISTS idx_api_cache_path_user ON api_cache(api_path, user_id);"];
        [db executeUpdate:CwRegionCreateSQL];
        [db executeUpdate:@"CREATE INDEX IF NOT EXISTS idx_region_parent ON region(parent_id, region_level, sort);"];
        [db executeUpdate:CwCacheMetaCreateSQL];
    }];
}

- (id)cachedJSONObjectForKey:(NSString *)cacheKey allowExpired:(BOOL)allowExpired {
    if (cacheKey.length == 0) {
        return nil;
    }

    __block NSString *jsonString = nil;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    [self.dbManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = allowExpired
        ? @"SELECT data_json FROM api_cache WHERE cache_key = ? ORDER BY updated_at DESC LIMIT 1"
        : @"SELECT data_json FROM api_cache WHERE cache_key = ? AND (expired_at = 0 OR expired_at >= ?) ORDER BY updated_at DESC LIMIT 1";
        FMResultSet *result = allowExpired
        ? [db executeQuery:sql, cacheKey]
        : [db executeQuery:sql, cacheKey, @(now)];
        if ([result next]) {
            jsonString = [result stringForColumn:@"data_json"];
        }
        [result close];
    }];

    if (jsonString.length == 0) {
        return nil;
    }
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

- (NSString *)cacheKeyForAPIPath:(NSString *)apiPath
                          params:(NSDictionary *)params
                          userId:(NSString *)userId {
    NSString *paramsMD5 = [[self canonicalJSONStringFromDictionary:params ?: @{}] md5String];
    NSString *safePath = apiPath ?: @"";
    NSString *safeUserId = userId ?: @"";
    return [NSString stringWithFormat:@"%@_%@_%@", safePath, safeUserId, paramsMD5 ?: @""];
}

- (void)saveJSONObject:(id)object
            forAPIPath:(NSString *)apiPath
              cacheKey:(NSString *)cacheKey
                params:(NSDictionary *)params
                userId:(NSString *)userId
                   ttl:(NSTimeInterval)ttl {
    if (cacheKey.length == 0 || apiPath.length == 0 || !object) {
        return;
    }

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    if (!jsonData) {
        return;
    }

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (jsonString.length == 0) {
        return;
    }

    NSString *paramsMD5 = [[self canonicalJSONStringFromDictionary:params ?: @{}] md5String];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSInteger expiredAt = ttl > 0 ? (NSInteger)(now + ttl) : 0;

    [self.dbManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:@"INSERT OR REPLACE INTO api_cache (cache_key, api_path, params_md5, user_id, data_json, data_version, expired_at, updated_at, created_at) VALUES (?, ?, ?, ?, ?, 1, ?, ?, COALESCE((SELECT created_at FROM api_cache WHERE cache_key = ?), ?))",
         cacheKey,
         apiPath,
         paramsMD5 ?: @"",
         userId ?: @"",
         jsonString,
         @(expiredAt),
         @((NSInteger)now),
         cacheKey,
         @((NSInteger)now)];
        [db executeUpdate:@"INSERT OR REPLACE INTO cache_meta (cache_key, etag, server_version, last_sync_at) VALUES (?, COALESCE((SELECT etag FROM cache_meta WHERE cache_key = ?), ''), COALESCE((SELECT server_version FROM cache_meta WHERE cache_key = ?), ''), ?)",
         cacheKey,
         cacheKey,
         cacheKey,
         @((NSInteger)now)];
    }];
}

- (NSArray *)cachedRegionTree {
    __block NSMutableArray<NSDictionary *> *rows = [NSMutableArray array];
    [self.dbManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:@"SELECT region_id, parent_id, region_name, region_level, sort, initial, pinyin, status, is_new, full_name, payload_json FROM region ORDER BY region_level ASC, parent_id ASC, sort ASC, region_id ASC"];
        while ([result next]) {
            NSMutableDictionary *row = [NSMutableDictionary dictionary];
            row[@"region_id"] = [result stringForColumn:@"region_id"] ?: @"";
            row[@"parent_id"] = [result stringForColumn:@"parent_id"] ?: @"";
            row[@"region_name"] = [result stringForColumn:@"region_name"] ?: @"";
            row[@"region_level"] = @([result intForColumn:@"region_level"]);
            row[@"sort"] = @([result intForColumn:@"sort"]);
            row[@"initial"] = [result stringForColumn:@"initial"] ?: @"";
            row[@"pinyin"] = [result stringForColumn:@"pinyin"] ?: @"";
            row[@"status"] = @([result intForColumn:@"status"]);
            row[@"is_new"] = @([result intForColumn:@"is_new"]);
            row[@"full_name"] = [result stringForColumn:@"full_name"] ?: @"";
            NSString *payload = [result stringForColumn:@"payload_json"];
            if (payload.length > 0) {
                NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *payloadObject = payloadData ? [NSJSONSerialization JSONObjectWithData:payloadData options:NSJSONReadingMutableContainers error:nil] : nil;
                if ([payloadObject isKindOfClass:[NSDictionary class]]) {
                    [row addEntriesFromDictionary:payloadObject];
                }
            }
            [rows addObject:row];
        }
        [result close];
    }];

    if (rows.count == 0) {
        return @[];
    }

    NSMutableDictionary<NSString *, NSMutableDictionary *> *provinceMap = [NSMutableDictionary dictionary];
    NSMutableDictionary<NSString *, NSMutableDictionary *> *cityMap = [NSMutableDictionary dictionary];
    NSMutableArray *provinces = [NSMutableArray array];

    for (NSDictionary *row in rows) {
        NSInteger level = [row[@"region_level"] integerValue];
        NSMutableDictionary *node = [self regionNodeFromRow:row];
        NSString *regionId = [NSString stringWithFormat:@"%@", row[@"region_id"] ?: @""];
        if (level == 1) {
            node[@"city"] = [NSMutableArray array];
            provinceMap[regionId] = node;
            [provinces addObject:node];
        } else if (level == 2) {
            node[@"county"] = [NSMutableArray array];
            cityMap[regionId] = node;
            NSMutableDictionary *parent = provinceMap[[NSString stringWithFormat:@"%@", row[@"parent_id"] ?: @""]];
            if (parent) {
                [parent[@"city"] addObject:node];
            }
        } else {
            NSMutableDictionary *parent = cityMap[[NSString stringWithFormat:@"%@", row[@"parent_id"] ?: @""]];
            if (parent) {
                [parent[@"county"] addObject:node];
            }
        }
    }

    return [provinces copy];
}

- (NSArray *)cachedRegionJSONArray {
    id cachedObject = [self cachedJSONObjectForKey:CwRegionCacheLookupKey allowExpired:YES];
    if (![cachedObject isKindOfClass:[NSArray class]] || [cachedObject count] == 0) {
        cachedObject = [self cachedJSONObjectForKey:@"appapi/system/huoqudiqu_global" allowExpired:YES];
    }
    if ([cachedObject isKindOfClass:[NSArray class]]) {
        return cachedObject;
    }
    return @[];
}

- (NSString *)regionDisplayNameForProvinceId:(NSString *)provinceId
                                      cityId:(NSString *)cityId
                                    countyId:(NSString *)countyId {
    NSArray<NSString *> *regionIds = @[
        [self safeString:provinceId],
        [self safeString:cityId],
        [self safeString:countyId]
    ];
    NSMutableArray<NSString *> *names = [NSMutableArray array];
    for (NSString *regionId in regionIds) {
        if (regionId.length == 0 || [regionId isEqualToString:@"0"]) {
            continue;
        }
        NSString *name = [self regionNameForId:regionId];
        if (name.length > 0) {
            [names addObject:name];
        }
    }
    return [names componentsJoinedByString:@","];
}

- (void)replaceRegionsWithJSONArray:(NSArray *)regions {
    if (![regions isKindOfClass:[NSArray class]] || regions.count == 0) {
        return;
    }

    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    [self.dbManager.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        if (![db executeUpdate:@"DELETE FROM region"]) {
            *rollback = YES;
            return;
        }

        for (NSDictionary *province in regions) {
            if (![self insertRegionNode:province parentId:@"" level:1 updatedAt:(NSInteger)now database:db]) {
                *rollback = YES;
                return;
            }
        }
    }];
}

- (BOOL)insertRegionNode:(NSDictionary *)node
                parentId:(NSString *)parentId
                   level:(NSInteger)level
               updatedAt:(NSInteger)updatedAt
                database:(FMDatabase *)db {
    if (![node isKindOfClass:[NSDictionary class]]) {
        return YES;
    }

    NSString *regionId = [self safeString:node[@"id"]];
    if (regionId.length == 0) {
        return YES;
    }

    NSString *name = [self safeString:node[@"name"]];
    NSString *initial = [self safeString:node[@"initial"]];
    NSString *pinyin = [self safeString:node[@"pinyin"]];
    NSInteger sort = [node[@"weigh"] respondsToSelector:@selector(integerValue)] ? [node[@"weigh"] integerValue] : 0;
    NSInteger status = [node[@"status"] respondsToSelector:@selector(integerValue)] ? [node[@"status"] integerValue] : 1;
    NSInteger isNew = [node[@"isnew"] respondsToSelector:@selector(integerValue)] ? [node[@"isnew"] integerValue] : 0;
    NSString *fullName = [self safeString:node[@"full_name"]];

    NSData *payloadData = [NSJSONSerialization dataWithJSONObject:node options:0 error:nil];
    NSString *payload = payloadData ? [[NSString alloc] initWithData:payloadData encoding:NSUTF8StringEncoding] : @"";

    BOOL success = [db executeUpdate:@"INSERT OR REPLACE INTO region (region_id, parent_id, region_name, region_level, sort, initial, pinyin, status, is_new, full_name, payload_json, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    regionId,
                    parentId ?: @"",
                    name ?: @"",
                    @(level),
                    @(sort),
                    initial ?: @"",
                    pinyin ?: @"",
                    @(status),
                    @(isNew),
                    fullName ?: @"",
                    payload ?: @"",
                    @(updatedAt)];
    if (!success) {
        return NO;
    }

    NSArray *cities = [node[@"city"] isKindOfClass:[NSArray class]] ? node[@"city"] : @[];
    for (NSDictionary *city in cities) {
        if (![self insertRegionNode:city parentId:regionId level:2 updatedAt:updatedAt database:db]) {
            return NO;
        }
    }

    NSArray *counties = [node[@"county"] isKindOfClass:[NSArray class]] ? node[@"county"] : @[];
    for (NSDictionary *county in counties) {
        if (![self insertRegionNode:county parentId:regionId level:3 updatedAt:updatedAt database:db]) {
            return NO;
        }
    }

    return YES;
}

- (NSMutableDictionary *)regionNodeFromRow:(NSDictionary *)row {
    NSMutableDictionary *node = [NSMutableDictionary dictionary];
    node[@"id"] = @([[self safeString:row[@"region_id"]] integerValue]);
    node[@"pid"] = @([[self safeString:row[@"parent_id"]] integerValue]);
    node[@"name"] = [self safeString:row[@"region_name"]];
    node[@"lv"] = row[@"region_level"] ?: @(0);
    node[@"weigh"] = row[@"sort"] ?: @(0);
    node[@"initial"] = [self safeString:row[@"initial"]];
    node[@"pinyin"] = [self safeString:row[@"pinyin"]];
    node[@"status"] = row[@"status"] ?: @(1);
    node[@"isnew"] = row[@"is_new"] ?: @(0);
    return node;
}

- (NSString *)canonicalJSONStringFromDictionary:(NSDictionary *)dictionary {
    if (![dictionary isKindOfClass:[NSDictionary class]] || dictionary.count == 0) {
        return @"{}";
    }
    NSArray<NSString *> *keys = [[dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableDictionary *normalized = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    for (NSString *key in keys) {
        id value = dictionary[key];
        normalized[key] = value ?: @"";
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:normalized options:0 error:nil];
    return data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : @"{}";
}

- (NSString *)safeString:(id)value {
    if (!value || value == [NSNull null]) {
        return @"";
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    return [NSString stringWithFormat:@"%@", value];
}

- (NSString *)regionNameForId:(NSString *)regionId {
    if (regionId.length == 0) {
        return @"";
    }

    __block NSString *regionName = @"";
    [self.dbManager.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:@"SELECT region_name FROM region WHERE region_id = ? LIMIT 1", regionId];
        if ([result next]) {
            regionName = [result stringForColumn:@"region_name"] ?: @"";
        }
        [result close];
    }];
    return regionName;
}

@end
