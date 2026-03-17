//
//  GroupChatDataCell.m
//  兜捞
//
//  Created by doulao ios1 on 14-11-12.
//  Copyright (c) 2014年 doulao ios1. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (ESUN)

- (NSString *)UTCTimeString:(NSString *)formatString;
- (NSDate *)StringToDateWithFormat:(NSString *)format;
- (NSString *)dateString;//获得时间

//获取一段字符串中包含的特定字符的所有range
- (NSArray *)rangesOfSearchString:(NSString *)searchString;

//设置label行间距
- (NSMutableAttributedString *)setParagraphTextWithLineSpacing:(NSInteger)lineSpacing;


/**
 *  @brief  .NET时间戳
 */
- (NSString *)dateStringForNet;
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;//时间搓
+(NSInteger)getNowTimestamp;//现在时间的时间搓
//获取当前时间
- (NSString *)getCurrTime;

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isPhoneNumber;
//与当前时间之差
- (NSString *)timeBetweenNow;

//获取字符串高宽
- (CGSize)sizeWithFont:(UIFont *)font Size:(CGSize)size;
//判断字符串是否为空
- (BOOL)isBlankString;


//根据身份证号获取生日
-(NSString *)birthdayStrFromIdentityCard;
//根据身份证号判断性别
-(NSString *)getIdentityCardSex;
//根据省份证号获取年龄
-(NSString *)getIdentityCardAge;


//判断全汉字(yes表示全是汉字)
- (BOOL)deptNameInputShouldChinese;
//判断全数字
- (BOOL)deptNumInputShouldNumber;
//判断全字母
- (BOOL)deptPassInputShouldAlpha;
//判断仅输入字母或数字
- (BOOL)deptIdInputShouldAlphaNum;

//正则匹配用户身份证号15或18位
- (BOOL)validateIDCardNumber;
//正则验证是否邮政编码
- (BOOL)validatePostalCode;
//银行卡号校验
- (BOOL)checkCardNo:(NSString *)cardNo;
//获取一段字符串中包含的数字的所有range
- (NSArray *)rangesOfNumberString;

- (NSString *)replaceUnicode;
// MD5加密方法
- (NSString *)md5String;
// MD5加密方法 + 盐
- (NSString *)md5StringWithSalt:(NSString *)salt;
@end
