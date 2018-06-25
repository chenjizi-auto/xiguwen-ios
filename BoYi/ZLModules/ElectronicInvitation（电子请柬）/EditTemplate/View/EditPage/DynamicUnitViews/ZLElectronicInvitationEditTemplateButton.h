//
//  ZLElectronicInvitationEditTemplateButton.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#define bgTag 809

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationEditTemplateButton : UIButton

///索引（section:页码,row:位置）
@property (nonatomic,strong) NSIndexPath *indexPath;
///背景页
@property (nonatomic,unsafe_unretained) BOOL backgroundPage;
///占位/提示图标
@property (nonatomic,weak) UIButton *placeholderImageButton;

@end
