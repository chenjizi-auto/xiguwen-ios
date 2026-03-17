//
//  ZLElectronicInvitationEditTemplateTailorImage.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/25.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationEditTemplateTailorImage : UIView

///展示裁剪视图
+ (void)showTailorImageViewInSuperView:(UIView *)superView Image:(UIImage *)image Scale:(CGFloat)scale Results:(void (^)(NSData *imageData))complete;

@end
