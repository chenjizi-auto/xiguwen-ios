//
//  ZLElectronicInvitationPreviewInvitationViewController.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationPreviewInvitationViewController : UIViewController

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///下文主键
@property (nonatomic,strong) NSString *keyId;
///链接地址
@property (nonatomic,strong) NSString *htmlUrl;
///图片地址（分享时用）
@property (nonatomic,strong) NSString *imageUrl;
///宴请时间（分享时用）
@property (nonatomic,strong) NSString *sharetime;
///编辑页进入（值不同则返回方式不同）
@property (nonatomic,unsafe_unretained) BOOL isFromEditPageEnter;

@end
