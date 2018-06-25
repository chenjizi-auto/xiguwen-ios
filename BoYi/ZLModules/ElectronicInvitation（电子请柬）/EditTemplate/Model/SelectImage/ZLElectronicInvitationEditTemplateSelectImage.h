//
//  ZLElectronicInvitationEditTemplateSelectImage.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLElectronicInvitationEditTemplateSelectImageDelegate <NSObject>

/** 已经选择的图片信息*/
-(void)didEndSelectedImageWithImage:(UIImage *)image;

@end

@interface ZLElectronicInvitationEditTemplateSelectImage : NSObject <UIImagePickerControllerDelegate>

//唤起选择事件
- (void)updateHeadPictureWithDelegate:(id<ZLElectronicInvitationEditTemplateSelectImageDelegate>)delegate;

@end
