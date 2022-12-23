//
//  CwShareManager.h
//  ZeroRead
//
//  Created by Chen on 2017/3/8.
//  Copyright © 2017年 pan wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>
//#import "MyCenterModel.h"

@interface CwShareManager : NSObject

+ (CwShareManager *)sharedManager;

+ (void)shareWebPageToPlatformWithUrl:(NSString *)url
                                image:(id)image
                                title:(NSString *)title
                                descr:(NSString *)descr
                                   vc:(UIViewController *)vc
                           completion:(void (^)(id data, NSError *error))completion;


//+ (void)shareWebPageToPlatformWithData:(Momentslist *)data;

@end
