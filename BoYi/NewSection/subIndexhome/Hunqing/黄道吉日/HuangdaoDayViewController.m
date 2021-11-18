//
//  HuangdaoDayViewController.m
//  BoYi
//
//  Created by heng on 2017/12/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "HuangdaoDayViewController.h"
#import <FSCalendar.h>
#import "LunarFormatter.h"

@interface HuangdaoDayViewController ()<FSCalendarDataSource,FSCalendarDelegate>
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (strong, nonatomic) LunarFormatter *lunarFormatter;
@property (weak, nonatomic) IBOutlet UILabel *suit;
@property (weak, nonatomic) IBOutlet UILabel *avoid;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *nongliTime;

@end

@implementation HuangdaoDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"黄道吉日";
    [self addPopBackBtn];
    
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    self.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    _lunarFormatter = [[LunarFormatter alloc] init];
    self.calendar.dataSource = self;
    self.calendar.delegate   = self;
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 84;
    }
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-M-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.time.text = dateString;
	[self loadData];
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    
    return [self.lunarFormatter stringFromDate:date];
    
}

- (void)loadData {
    //传入参数 进行刷新
    NSString *date = self.calendar.selectedDate ? [self.calendar.selectedDate fs_stringWithFormat:@"yyyy-M-d"] : [self.calendar.today fs_stringWithFormat:@"yyyy-M-d"];
    
    [[RequestManager sharedManager] requestUrl:@"http://v.juhe.cn/calendar/day"
                                        method:POST
                                        loding:@""
                                           dic:@{@"key":@"0a164998cb748dd67a0609e4ff29ab60",
                                                 @"date":date}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           self.suit.text = response[@"result"][@"data"][@"suit"];
                                           self.avoid.text = response[@"result"][@"data"][@"avoid"];
                                           self.nongliTime.text = response[@"result"][@"data"][@"lunarYear"];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {

                                       }];
    
}
#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{

    NSString *timewu = [self.calendar.selectedDate fs_stringWithFormat:@"yyyy-M-d"];
    self.time.text = timewu;
    
    [self loadData];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    //切换月份的时候调用
    
//    [self loadSchedule];
    
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
//    NSInteger eventCount = 0;
//    for (ScheduleModel *model in self.ScheduleArray) {
//
//        //判断是不是选择的一天
//        if ([[NSDate dateWithTimeIntervalSince1970:model.scheduleDate.millis / 1000] fs_isEqualToDateForDay:date]) {
//            //午宴
//            if (model.scheduleType == 1 && model.status == 1) {
//                eventCount ++;
//                //            } else if (model.scheduleType == 2 && model.status == 1) {
//                //
//                //                eventCount ++;
//            }
//        }
//
//    }
//    if (eventCount == 1) {
//        return RGBA(20, 188, 159, 1);
//    }
    
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
