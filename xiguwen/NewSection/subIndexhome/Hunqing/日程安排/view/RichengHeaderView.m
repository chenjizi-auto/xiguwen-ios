//
//  RichengHeaderView.m
//  BoYi
//
//  Created by heng on 2018/1/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "RichengHeaderView.h"

@implementation RichengHeaderView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    self.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    self.calendar.dataSource = self;
    self.calendar.delegate   = self;
}
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    NSString *timewu = [self.calendar.selectedDate fs_stringWithFormat:@"yyyy-MM-dd"];
    [self.selectItemSubject sendNext:timewu];
}


@end
