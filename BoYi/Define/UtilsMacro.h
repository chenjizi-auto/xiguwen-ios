//
//  UtilsMacro.h
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/5.
//  Copyright © 2017年 fuyou. All rights reserved.
//

    

/**
 *  本类放一些基本方法
 */
#ifndef WeakSelf
#define WeakSelf(self) __weak typeof(self) weakSelf = self;
#endif


#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

/// iPhoneX顶部宏
#define isIPhoneXBarHeight         (ScreenHeight == 812.0 ? 88.0 : 64.0)
/// iPhoneX底部宏
#define isIPhoneXBottomHeight        (ScreenHeight == 812.0 ? 34.0 : 0.0)
///是否是iPhone X
#define isIPhoneX                   (ScreenHeight == 812.0 ? YES : NO)
#define NUMBERS @"0123456789"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define CalculateWidth(width)   ScreenWidth * (width / 375.0)


#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

//主题导航栏颜色（灰白）
#define NavBarCOLOR RGBA(238,239,239,1)
//登录模块导航栏颜色（墨绿）
#define LoginNavBarCOLOR RGBA(32,62,72,1)


//文本框背景颜色（浅绿）
#define FIELD_BACKGROUND_COLOR RGBA(40,91,97,1)
//文本框占位符字体颜色（灰白）
#define FIELD_PLACEHOLDER_COLOR RGBA(209,209,210,1)
//按钮button背景颜色（黄色）
#define BUTTON_BACKGROUND_COLOR RGBA(254,210,10,1)
//文字颜色（深绿）
#define TEXT_COLOR RGBA(62,58,57,1)
//tabbar颜色（深绿）
#define TABBAR_COLOR RGBA(60,197,188,1)
//刷新控件文字颜色
#define REFRESH_COLOR  RGBA(84, 161, 160, 1)

#define MAINCOLOR RGBA(255, 82, 131, 1)
#define BLUECOLOR RGBA(60,197,188,1)

//banner默认占位图
#define BANNERPLACEHOLDERIMAGE [UIImage imageNamed:@"Placeholder-图片"]
//头像默认占位图
#define HEADPICLACEHOLDERIMAGE [UIImage imageNamed:@"Placeholder-头像"]

#define IMAGE_NAME(x) [UIImage imageNamed:x]
#define urlString(x) [NSURL URLWithString:x]

#define VERSION  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
#define CURRENTDEVICE    [[UIDevice currentDevice] systemVersion]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)
#define UICommonTableBkgColor UIColorFromRGB(0xe4e7ec)
#define Message_Font_Size   14        // 普通聊天文字大小
#define Notification_Font_Size   10   // 通知文字大小
#define Chatroom_Message_Font_Size 16 // 聊天室聊天文字大小
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)

#define UISreenWidthScale   ScreenWidth / 320


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/**
 *  object is nil or null
 */
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))


#define TOKEN [UserData UserDefaults:@"Token"]

