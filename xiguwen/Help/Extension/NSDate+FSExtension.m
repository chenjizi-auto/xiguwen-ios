//
//  NSDate+FSExtension.m
//  Pods
//
//  Created by Wenchao Ding on 29/1/15.
//
//

#import "NSDate+FSExtension.h"

@implementation NSDate (FSExtension)

- (NSString *)fs_constellation {
    
    NSArray *arr = @[@20, @19, @21, @20, @21, @22, @23, @23, @23, @24, @23, @22];
    NSArray *starArray = @[@"摩羯座", @"水瓶座", @"双鱼座", @"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座", @"射手座", @"摩羯座"];
    
    
    return self.fs_day < [arr[self.fs_month - 1] integerValue] ? starArray[self.fs_month - 1] : starArray[self.fs_month];
}

- (NSInteger)fs_year
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:self];
    return component.year;
}

- (NSInteger)fs_month
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMonth
                                              fromDate:self];
    return component.month;
}

- (NSInteger)fs_day
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitDay
                                              fromDate:self];
    return component.day;
}

- (NSInteger)fs_weekday
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return component.weekday;
}
- (NSString *)fs_weekdayString {
    NSArray *array = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    return array[self.fs_weekday - 1];
}

- (NSInteger)fs_weekOfYear
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekOfYear fromDate:self];
    return component.weekOfYear;
}

- (NSInteger)fs_hour
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitHour
                                              fromDate:self];
    return component.hour;
}

- (NSInteger)fs_minute
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMinute
                                              fromDate:self];
    return component.minute;
}

- (NSInteger)fs_second
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitSecond
                                              fromDate:self];
    return component.second;
}
- (NSTimeInterval )fs_TimeInterval
{
    return [self timeIntervalSince1970];
}
- (NSDate *)fs_dateByIgnoringTimeComponents
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)fs_firstDayOfMonth
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth| NSCalendarUnitDay fromDate:self];
    components.day = 1;
    return [calendar dateFromComponents:components];
}

- (NSDate *)fs_lastDayOfMonth
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.month++;
    components.day = 0;
    return [calendar dateFromComponents:components];
}

- (NSDate *)fs_firstDayOfWeek
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    componentsToSubtract.day = - (weekdayComponents.weekday - calendar.firstWeekday);
    NSDate *beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    NSDateComponents *components = [calendar components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                               fromDate: beginningOfWeek];
    beginningOfWeek = [calendar dateFromComponents: components];
    return beginningOfWeek;
}

- (NSDate *)fs_tomorrow
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.day++;
    return [calendar dateFromComponents:components];
}

- (NSDate *)fs_yesterday
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.day--;
    return [calendar dateFromComponents:components];
}

- (NSInteger)fs_numberOfDaysInMonth
{
    NSCalendar *c = [NSCalendar fs_sharedCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:self];
    return days.length;
}

+ (instancetype)fs_dateFromString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

+ (instancetype)fs_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    return [calendar dateFromComponents:components];
}

- (NSDate *)fs_dateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = years;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)fs_dateBySubtractingYears:(NSInteger)years
{
    return [self fs_dateByAddingYears:-years];
}

- (NSDate *)fs_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = months;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)fs_dateBySubtractingMonths:(NSInteger)months
{
    return [self fs_dateByAddingMonths:-months];
}

- (NSDate *)fs_dateByAddingWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.weekOfYear = weeks;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

-(NSDate *)fs_dateBySubtractingWeeks:(NSInteger)weeks
{
    return [self fs_dateByAddingWeeks:-weeks];
}

- (NSDate *)fs_dateByAddingDays:(NSInteger)days
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)fs_dateBySubtractingDays:(NSInteger)days
{
    return [self fs_dateByAddingDays:-days];
}

- (NSInteger)fs_yearsFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.year;
}

- (NSInteger)fs_monthsFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.month;
}

- (NSInteger)fs_weeksFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.weekOfYear;
}

- (NSInteger)fs_daysFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar fs_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.day;
}

- (NSString *)fs_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)fs_string
{
    return [self fs_stringWithFormat:@"yyyy-MM-dd"];
}
- (NSInteger )fs_age
{
    NSInteger currentYear = [NSDate date].fs_year;
    return currentYear - self.fs_year;
}

- (BOOL)fs_isEqualToDateForMonth:(NSDate *)date
{
    return self.fs_year == date.fs_year && self.fs_month == date.fs_month;
}

- (BOOL)fs_isEqualToDateForWeek:(NSDate *)date
{
    return self.fs_year == date.fs_year && self.fs_weekOfYear == date.fs_weekOfYear;
}

- (BOOL)fs_isEqualToDateForDay:(NSDate *)date
{
    return self.fs_year == date.fs_year && self.fs_month == date.fs_month && self.fs_day == date.fs_day;
}


///**
// *  是否为今天
// */
//- (BOOL)isToday
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
//
//    // 1.获得当前时间的年月日
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//
//    // 2.获得self的年月日
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//    return
//    (selfCmps.year == nowCmps.year) &&
//    (selfCmps.month == nowCmps.month) &&
//    (selfCmps.day == nowCmps.day);
//}
//
///**
// *  是否为昨天
// */
//- (BOOL)isYesterday
//{
//    // 2014-05-01
//    NSDate *nowDate = [[NSDate date] dateWithYMD];
//
//    // 2014-04-30
//    NSDate *selfDate = [self dateWithYMD];
//
//    // 获得nowDate和selfDate的差距
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
//    return cmps.day == 1;
//}
//
//- (NSDate *)dateWithYMD
//{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd";
//    NSString *selfStr = [fmt stringFromDate:self];
//    return [fmt dateFromString:selfStr];
//}
//
///**
// *  是否为今年
// */
//- (BOOL)isThisYear
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    int unit = NSCalendarUnitYear;
//
//    // 1.获得当前时间的年月日
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//
//    // 2.获得self的年月日
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//
//    return nowCmps.year == selfCmps.year;
//}
//
//- (NSDateComponents *)deltaWithNow
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
//}
////使用：使用方法,在给模型设置数据的时候,在模型里重写get方法， self.timeLabel.text = status.created_at;
//- (NSString *)created_at
//{
//    // _created_at == Fri May 09 16:30:34 +0800 2014
//    // 1.获得微博的发送时间
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
//#warning 真机调试下, 必须加上这段
//    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    NSDate *createdDate = [fmt dateFromString:_created_at];
//
//    // 2..判断微博发送时间 和 现在时间 的差距
//    if (createdDate.isToday) { // 今天
//        if (createdDate.deltaWithNow.hour >= 1) {
//            return [NSString stringWithFormat:@"%ld小时前", createdDate.deltaWithNow.hour];
//        } else if (createdDate.deltaWithNow.minute >= 1) {
//            return [NSString stringWithFormat:@"%ld分钟前", createdDate.deltaWithNow.minute];
//        } else {
//            return @"刚刚";
//        }
//    } else if (createdDate.isYesterday) { // 昨天
//        fmt.dateFormat = @"昨天 HH:mm";
//        return [fmt stringFromDate:createdDate];
//    } else if (createdDate.isThisYear) { // 今年(至少是前天)
//        fmt.dateFormat = @"MM-dd HH:mm";
//        return [fmt stringFromDate:createdDate];
//    } else { // 非今年
//        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
//        return [fmt stringFromDate:createdDate];
//    }
//}
@end


@implementation NSCalendar (FSExtension)

+ (instancetype)fs_sharedCalendar
{
    static id instance;
    static dispatch_once_t fs_sharedCalendar_onceToken;
    dispatch_once(&fs_sharedCalendar_onceToken, ^{
        instance = [NSCalendar currentCalendar];
    });
    return instance;
}

@end

