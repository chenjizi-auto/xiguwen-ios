//
//  Conf.h
//  zhiquan
//
//  Created by huangcan on 15/6/12.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#ifndef zhiquan_Conf_h
#define zhiquan_Conf_h

#pragma mark - 常用  ------------ ------------ ------------ ------------ ------------ ------------
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define ENCODEING   NSUTF8StringEncoding  //系统环境使用的编码

#define  PHONEBOUNDS [UIScreen mainScreen].bounds;

#pragma mark - UserDefaults  ------------ ------------ ------------ ------------ ------------

//用户ID
#define USERID          [UserData keyForUser:@"username"]
//用户名字
#define NICKNAME        [DataDefaults getStringForKey:@"NickName"]
//用户头像
#define HEADPIC         [DataDefaults getStringForKey:@"HeadPic"]

#define IOS11            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0)

#pragma mark - Funtion Method (宏 方法)




// PNG JPG 图片路径
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGkImg(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGkImg(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define kImg(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

#define V_IMAGE(imgName) [UIImage imageNamed:imgName]

#define NSStringFormatter(x) [NSString stringWithFormat:@"%@",x]
#define URL(url) [NSURL URLWithString:url]
#define String(str1,str2) [NSString stringWithFormat:@"%@%@",str1,str2]
#define S_str(str1) [NSString stringWithFormat:@"%@",str1]
#define S_Num(num1) [NSString stringWithFormat:@"%d",num1]
#define S_Integer(num1) [NSString stringWithFormat:@"%ld",num1]
//number转String
#define IntTranslateStr(int_str) [NSString stringWithFormat:@"%d",int_str];
#define FloatTranslateStr(float_str) [NSString stringWithFormat:@"%.2d",float_str];

#pragma mark --- 上传图片  ------------ ------------ ------------ ------------ ------------ ------------

#define URI_UPPIC(url) [UPPiCURL stringByAppendingString:url]
#define URI_UPLOADPIC                               URI_UPPIC(@"Upload/UploadPic")
// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])



#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define RIGHT_URL(url) [url hasPrefix:@"http"] ? url : [NSString stringWithFormat:@"http://oss.40yue.com/%@",url]




#endif
