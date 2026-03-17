//
//  ZLStaticPage.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/8/17.
//  Copyright © 2018年   . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLStaticPage : UIView

///提示语
@property (nonatomic,strong) NSMutableAttributedString *title;
///按钮标题
@property (nonatomic,strong) NSString *buttonTitle;
///图标名称
@property (nonatomic,strong) NSString *iconName;
///子控件距离本类顶部的高度
@property (nonatomic,unsafe_unretained) CGFloat topInset;
///按钮事件
@property (nonatomic,copy) void (^gotoAction)(void);

@end
