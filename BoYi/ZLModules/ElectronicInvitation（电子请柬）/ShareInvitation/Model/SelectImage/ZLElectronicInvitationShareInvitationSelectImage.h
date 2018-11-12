//
//  ZLElectronicInvitationShareInvitationSelectImage.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationShareInvitationSelectImageModel : NSObject

/** 图片*/
@property (nonatomic,strong) UIImage *image;
/** 图片二进制*/
@property (nonatomic,strong) NSData *imageData;
/** 图片沙盒路径*/
@property (nonatomic,strong) NSString *imagePath;
/** 图片类型*/
@property (nonatomic,strong) NSString *imageType;

@end



typedef void(^results)(NSString *imageUrl);

@protocol ZLElectronicInvitationShareInvitationSelectImageDelegate <NSObject>

/** 已经选择的图片信息*/
-(void)didEndSelectedImageWithImage:(ZLElectronicInvitationShareInvitationSelectImageModel *)imageModel;

@end

@interface ZLElectronicInvitationShareInvitationSelectImage : NSObject <UIImagePickerControllerDelegate>

//唤起选择事件
- (void)updateHeadPictureWithDelegate:(id<ZLElectronicInvitationShareInvitationSelectImageDelegate>)delegate;

@end
