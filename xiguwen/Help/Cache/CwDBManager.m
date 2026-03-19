#import "CwDBManager.h"
#import <fmdb/FMDB.h>

@implementation CwDBManager

+ (instancetype)sharedManager {
    static CwDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initPrivate];
    });
    return manager;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[CwDBManager sharedManager]"
                                 userInfo:nil];
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        NSString *directory = [self.class databaseDirectory];
        [[NSFileManager defaultManager] createDirectoryAtPath:directory
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
        NSString *databasePath = [directory stringByAppendingPathComponent:@"cw_cache.sqlite"];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
        [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            [db executeUpdate:@"PRAGMA journal_mode = WAL;"];
            [db executeUpdate:@"PRAGMA synchronous = NORMAL;"];
        }];
    }
    return self;
}

+ (NSString *)databaseDirectory {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = paths.firstObject ?: NSTemporaryDirectory();
    return [cacheDirectory stringByAppendingPathComponent:@"cw_cache"];
}

@end
