//
//  Util.m
//  Medication
//
//  Created by zhaoxiaoling on 15/7/3.
//  Copyright (c) 2015年 bode. All rights reserved.
//

#import "Util.h"

@implementation Util

+(NSString*)AsciiFromString:(NSString*)string
{
    NSMutableString *str = [NSMutableString new];
    
    const char *ch = [string cStringUsingEncoding:NSASCIIStringEncoding];
    for (int i = 0; i < strlen(ch); i++)
    {
//        printf("%d", [string characterAtIndex:i]);
        
        int code = [string characterAtIndex:i]+10;
        
        NSString *string = [NSString stringWithFormat:@"%c", code];
        
        [str appendString:string];
    }
    return str;
}

+(void)showMessage:(NSString*)string
{
    if (string.length>0)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setNumberOfLines:0];
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        CGSize labelsize = [self returnCGSizeWithString:string];
        [label setFrame:CGRectMake((ScreenWidth-labelsize.width-20)/2, (ScreenHeight-labelsize.height-10)/2, labelsize.width+20, labelsize.height+10)];
        label.text  = string;
        label.backgroundColor  = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.layer.borderWidth   = 1;
        label.layer.cornerRadius  = 5;
        label.layer.masksToBounds = true;
        label.font  = font;
        label.alpha = 0;
        label.textAlignment  = NSTextAlignmentCenter;
        [[[UIApplication sharedApplication] delegate].window addSubview:label];
        [UIView animateWithDuration:0.3 animations:^{
            label.alpha = 1;
        } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:.3 delay:2 options:0 animations:^{
                 label.alpha = 0;
             } completion:^(BOOL finished) {
                 [label removeFromSuperview];
             }];
         }];
    }
}
/**隐藏显示提示标签*/
+(void)timerForLabelHandle:(id)sender
{
    __block  UILabel  *label  = (UILabel*)[sender userInfo];
    [UIView animateWithDuration:0.3 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished)
     {
         [label removeFromSuperview];
     }];
}

+(BOOL)validateRegix:(NSString*)rex withString:(NSString*)string
{
    NSPredicate *regix = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",rex];
    if ([regix evaluateWithObject:string]==YES)
    {
        return YES;
    }
    return NO;
}

+(CGSize)returnCGSizeWithString:(NSString*)string
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

+(CGSize)returnCGSizeWithString:(NSString*)string withFont:(UIFont*)font
{
    if ([string isKindOfClass:[NSNull class]])
    {
        return CGSizeZero;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(NSString *)getUUID
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"uuid"] length]==0)
    {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        //    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"uuid"];
        return result;
    }
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"uuid"];
}

//定位后存放城市Id
+(void)setCityNumber:(NSString*)cityName withCityArray:(NSArray*)array
{
    if (array.count>0)
    {
        BOOL haveTrue = NO;
        for (NSDictionary *obj in array)
        {
            if ([obj[@"cityName"] isEqualToString:cityName])
            {
                haveTrue    = YES;
                [[NSUserDefaults standardUserDefaults]setObject:obj[@"id"] forKey:@"cityNum"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                break;
            }
        }
        if (!haveTrue)
        {
            [[NSUserDefaults standardUserDefaults]setObject:array[0][@"id"] forKey:@"cityNum"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"cityNum"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

//获取城市Id
+(NSString*)getCityNumber
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"cityNum"])
    {
        return [[NSUserDefaults standardUserDefaults]objectForKey:@"cityNum"];
    }
    return @"1";
}

//将时间戳转为标准时间
+(NSString*)dateFromTimeStamp:(NSString*)timeStamp
{
    if ([timeStamp isKindOfClass:[NSNull class]] || timeStamp == nil)
    {
        return @"";
    }
    
    NSTimeInterval timeInterval = [timeStamp doubleValue];
    NSDateFormatter* formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSString *systemTime        = [formatter stringFromDate:date];
    return systemTime;
}

//计算两个日期相差的天数
+(NSInteger)getDaysNumberStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [dateFormatter dateFromString:startTime];
    NSDate *dateToString = [dateFormatter dateFromString:endTime];
    NSTimeInterval timediff = [dateToString timeIntervalSince1970]-[dateFromString timeIntervalSince1970];
    if (timediff > 0 && timediff < 86400) {
        return 1;
    }else if (timediff / 86400 > 1) {
        return timediff / ( 24 * 60 * 60 )+1;
    }else{
        return timediff / ( 24 * 60 * 60 );
    }
}


#pragma mark - 判断一个字符串是否全是汉字
+ (BOOL)isAllChineseCharacters:(NSString *)string
{
    for (int i = 0; i < string.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [string substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) != 3)
        {
            return NO;
        }
        
    }
    
    return YES;
}

#pragma mark - 判断一个字符串是否全是数字
+ (BOOL)isAllNumber:(NSString *)string
{
    for (int i = 0; i < string.length; i++) {
        unichar cString = [string characterAtIndex:i];
        if (!isdigit(cString)) {
            return NO;
        }
    }
    return YES;
}

@end
