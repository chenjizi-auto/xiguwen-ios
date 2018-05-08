//
//  Util.h
//  Medication
//
//  Created by zhaoxiaoling on 15/7/3.
//  Copyright (c) 2015年 bode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

//将字符串转换为ASCII码
+(NSString*)AsciiFromString:(NSString*)string;

+(void)showMessage:(NSString*)string;

//验证正则表达式
+(BOOL)validateRegix:(NSString*)rex withString:(NSString*)string;

+(CGSize)returnCGSizeWithString:(NSString*)string;
+(CGSize)returnCGSizeWithString:(NSString*)string withFont:(UIFont*)font;

//通过颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+(NSString *)getUUID;

//定位后存放城市Id
+(void)setCityNumber:(NSString*)cityName withCityArray:(NSArray*)array;
//获取城市Id
+(NSString*)getCityNumber;

//将时间戳转为标准时间
+(NSString*)dateFromTimeStamp:(NSString*)timeStamp;

//计算两个日期相差的天数
+(NSInteger)getDaysNumberStartTime:(NSString *)startTime endTime:(NSString *)endTime;

//判断一个字符串是否全是汉字
+ (BOOL)isAllChineseCharacters:(NSString *)string;
//判断一个字符串是否全是数字
+ (BOOL)isAllNumber:(NSString *)string;

@end
