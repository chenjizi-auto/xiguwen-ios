#import "CwChatUIKitBridge.h"
#import "CwChatManager.h"
#if __has_include("xiguwen-Swift.h")
#import "xiguwen-Swift.h"
#endif

@implementation CwChatUIKitBridge

+ (void)registerBuildersIfNeeded {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([CwChatManager hasRegisteredCustomChatUIKitBridge]) {
            return;
        }
#if __has_include("xiguwen-Swift.h")
        [CwChatUIKitBootstrap registerBuildersIfNeeded];
#endif
    });
}

@end
