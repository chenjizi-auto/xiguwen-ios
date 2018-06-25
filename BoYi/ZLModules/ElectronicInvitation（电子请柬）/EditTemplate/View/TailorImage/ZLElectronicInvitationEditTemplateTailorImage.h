//
//  ZLElectronicInvitationEditTemplateTailorImage.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/25.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationEditTemplateImageModel : NSObject

/** 图片*/
@property (nonatomic,strong) UIImage *image;
/** 图片二进制*/
@property (nonatomic,strong) NSData *imageData;
/** 图片沙盒路径*/
@property (nonatomic,strong) NSString *imagePath;
/** 图片类型*/
@property (nonatomic,strong) NSString *imageType;

@end

@interface ZLElectronicInvitationEditTemplateTailorImage : UIView

///展示裁剪视图
+ (void)showTailorImageViewInSuperView:(UIView *)superView Image:(UIImage *)image Scale:(CGFloat)scale Results:(void (^)(ZLElectronicInvitationEditTemplateImageModel *imageModel))complete;

@end
