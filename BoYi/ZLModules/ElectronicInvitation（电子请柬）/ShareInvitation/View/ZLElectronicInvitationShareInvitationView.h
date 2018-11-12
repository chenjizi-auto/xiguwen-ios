//
//  ZLElectronicInvitationShareInvitationView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationShareInvitationView : UIView

///图片地址（分享时用）
@property (nonatomic,strong) NSString *imageUrl;
///宴请时间（分享时用）
@property (nonatomic,strong) NSString *sharetime;
///图片
@property (nonatomic,strong) UIImage *iconImage;

///消失
@property (nonatomic,copy) void (^dismissPage)(void);
///更改图片
@property (nonatomic,copy) void (^changeImage)(void);
///分享
@property (nonatomic,copy) void (^share)(NSInteger index, NSString *title, NSString *content);

///错误日志
@property (nonatomic,strong) NSString *errorMessage;
///展示遮盖
@property (nonatomic,unsafe_unretained) BOOL showHud;

///展示
- (void)show;
///消失
- (void)dismiss;

@end
