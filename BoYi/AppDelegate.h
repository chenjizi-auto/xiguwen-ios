//
//  AppDelegate.h
//  ZeroRead_OC
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)ConfirmRootViewController;
//
@end

