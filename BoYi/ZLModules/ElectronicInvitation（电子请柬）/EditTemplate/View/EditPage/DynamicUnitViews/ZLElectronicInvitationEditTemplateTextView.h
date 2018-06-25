//
//  ZLElectronicInvitationEditTemplateTextView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationEditTemplateTextView : UITextView

///索引（section:页码,row:位置）
@property (nonatomic,strong) NSIndexPath *indexPath;
///占位/提示图标
@property (nonatomic,weak) UIButton *placeholderImageButton;

@end
