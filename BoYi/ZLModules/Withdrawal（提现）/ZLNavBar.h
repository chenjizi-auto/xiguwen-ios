//
//  ZLNavBar.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/7/6.
//  Copyright © 2018年   . All rights reserved.
//

#import <UIKit/UIKit.h>

///搜索条边角样式
typedef NS_ENUM (NSInteger , ZLNavigationSearchBarAngleStyle){
    ///方的
    ZLNavigationSearchBarAngleStyleNormal = 0,
    ///少许圆
    ZLNavigationSearchBarAngleStyleLittle ,
    ///圆的
    ZLNavigationSearchBarAngleStyleRound
};

@interface ZLNavBar : UIView

///消息数
@property (nonatomic,unsafe_unretained) NSInteger messageNumber;
///消息提示（小红点）
@property (nonatomic,unsafe_unretained) BOOL showMessagePoint;
///更换返回按钮图标
@property (nonatomic,strong) NSString *goBackImageName;
///尺寸更改
@property (nonatomic,unsafe_unretained) CGSize barChangeSize;
///分割线
@property (nonatomic,unsafe_unretained) BOOL showBottomLine;
///左边按钮点击事件
@property (nonatomic,copy) void (^leftItemAction)(void);
///右边主要按钮的点击事件（主要的、位置最靠右的）
@property (nonatomic,copy) void (^rightItemAction)(void);
///右边并列按钮的点击事件（并列的、靠近主要的）
@property (nonatomic,copy) void (^apposeItemAction)(void);
///搜索事件
@property (nonatomic,copy) void (^searchAction)(NSString *searchString);
///实时搜索
@property (nonatomic,copy) void (^runSearchAction)(NSString *searchString);
///毛玻璃背景的透明度
@property (nonatomic,unsafe_unretained) CGFloat alphaViewAlpha;
///导航栏标题
@property (nonatomic,strong) NSString *title;
///导航栏标题透明度
@property (nonatomic,unsafe_unretained) CGFloat titleAlpha;
///导航栏标题颜色
@property (nonatomic,strong) UIColor *titleColor;
///展示导航栏返回按钮
@property (nonatomic,unsafe_unretained) BOOL showGoBack;
///导航栏左边按钮的图标（当只需显示图标的时候，为此属性赋值）
@property (nonatomic,strong) NSString *leftItemImageName;
///导航栏左边按钮有图标和文字时，此属性是图标的对应值
@property (nonatomic,strong) NSString *leftItemTitleImageName;
///导航栏左边按钮有图标和文字时，此属性是文字的对应值
@property (nonatomic,strong) NSString *leftItemTitle;
///导航栏左边按钮的文字颜色
@property (nonatomic,strong) UIColor *leftItemTitleColor;
///导航栏右边主按钮（最靠右）的图标值
@property (nonatomic,strong) NSString *rightItemImageName;
///导航栏右边主按钮（最靠右）的文字值
@property (nonatomic,strong) NSString *rightItemTitle;
///导航栏右边主按钮（最靠右）的文字颜色值
@property (nonatomic,strong) UIColor *rightItemTitleColor;
///导航栏右边辅助（右边并列按钮时的辅助）按钮图标
@property (nonatomic,strong) NSString *apposeItemImageName;
///导航栏右边辅助（右边并列按钮时的辅助）按钮文字
@property (nonatomic,strong) NSString *apposeItemTitle;
///导航栏右边辅助（右边并列按钮时的辅助）按钮文字颜色
@property (nonatomic,strong) UIColor *apposeItemTitleColor;
///导航栏右边辅助（右边并列按钮时的辅助）按钮隐藏
@property (nonatomic,unsafe_unretained) BOOL apposeItemHidden;
///搜索框占位文字
@property (nonatomic,strong) NSString *searchBarPlaceholder;
///搜索框边角样式
@property (nonatomic,unsafe_unretained) ZLNavigationSearchBarAngleStyle searchBarAngleStyle;
///搜索框预设文字
@property (nonatomic,strong) NSString *searchBarText;
///搜索框位置
@property (nonatomic,unsafe_unretained) CGRect searchBarChangeFrame;
///开启搜索框的点击事件（点击搜索框进入下一个界面用此功能）
@property (nonatomic,unsafe_unretained) BOOL openSearchBarTapFunction;
///让搜索框成为第一响应者
@property (nonatomic,unsafe_unretained) BOOL searchBarBecomeFirstResponder;

@end
