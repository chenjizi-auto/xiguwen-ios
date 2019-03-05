//
//  ZLNavBar.h
//  BoYi
//
//  Created by zhaolei on 2018/6/25.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationNavBar : UIView

///返回按钮
@property (nonatomic,weak) UIButton *goBackButton;
///右边按钮
@property (nonatomic,weak) UIButton *rightButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;

///返回事件
@property (nonatomic,copy) void (^goBack)(void);
///右边事件
@property (nonatomic,copy) void (^rightAction)(void);

@end
