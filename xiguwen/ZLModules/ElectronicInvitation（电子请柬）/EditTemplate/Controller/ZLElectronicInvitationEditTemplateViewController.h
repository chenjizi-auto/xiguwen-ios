//
//  ZLElectronicInvitationEditTemplateViewController.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationEditTemplateViewController : UIViewController

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///模板id
@property (nonatomic,strong) NSString *keyId;
///预览模板页进入（值不同则返回方式不同）
@property (nonatomic,unsafe_unretained) BOOL isFromPreviewTemplateEnter;

@end
