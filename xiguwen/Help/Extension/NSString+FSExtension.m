//
//  NSString+FSExtension.m
//  FSCalendar
//
//  Created by Wenchao Ding on 8/29/15.
//  Copyright (c) 2015 wenchaoios. All rights reserved.
//

#import "NSString+FSExtension.h"

@implementation NSString (FSExtension)

- (NSDate *)fs_dateWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:self];
}

- (NSDate *)fs_date
{
    return [self fs_dateWithFormat:@"yyyy-MM-dd"];
}
+ (NSString*)formartCreateTime:(NSTimeInterval )createTime formatter:(NSString *)formatter {
    NSTimeInterval timestamp = createTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    if (!dateString.length) {
        return @"未知时间";
    }
    return dateString;
}

//剩余时间
+ (NSString *)timeLeave:(NSTimeInterval)time
{
    
    NSInteger days   =  ((NSInteger)time)/(3600 * 24);
    NSInteger hours  = ((NSInteger)time % (3600 * 24)) / 3600;
    NSInteger minute = (((NSInteger)time % (3600 * 24)) % 3600) / 60;
    
    NSString *dateContent = @"";
    
    if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%ld天",days];
    }
//    if(hours!=0){
//        
        dateContent = [NSString stringWithFormat:@"%@%ld小时",dateContent,hours];
//    }
//    if(minute!=0){
//        
        dateContent = [NSString stringWithFormat:@"%@%ld分",dateContent,minute];
//    }
    
    //    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return dateContent;
}

@end
