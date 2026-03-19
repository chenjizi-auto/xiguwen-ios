#import <Foundation/Foundation.h>

@class FMDatabaseQueue;

NS_ASSUME_NONNULL_BEGIN

@interface CwDBManager : NSObject

@property (nonatomic, strong, readonly) FMDatabaseQueue *dbQueue;

+ (instancetype)sharedManager;

@end

NS_ASSUME_NONNULL_END
