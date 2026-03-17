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
///分享时用到的时间控件
@property (nonatomic,unsafe_unretained) BOOL isShareTime;
///文字的富文本样式
@property (nonatomic,strong) NSDictionary *attributes;

@end
