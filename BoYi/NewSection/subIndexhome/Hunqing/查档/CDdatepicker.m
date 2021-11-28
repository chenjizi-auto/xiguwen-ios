//
//  CDdatepicker.m
//  BoYi
//
//  Created by heng on 2017/12/1.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "CDdatepicker.h"

@implementation CDdatepicker

+ (CDdatepicker *)showInView:(UIView *)view issele:(BOOL)issele block:(void(^)(NSMutableDictionary *dic))block {
    return [self showInView:view issele:issele lastDate:nil block:block];
}

+ (CDdatepicker *)showInView:(UIView *)view issele:(BOOL)issele lastDate:(NSString *)lastDate block:(void(^)(NSMutableDictionary *dic))block{
    
    CDdatepicker *alert = [[[NSBundle mainBundle]loadNibNamed:@"CDdatepicker" owner:self options:nil]lastObject];
    alert.picker.delegate         = alert;
    alert.picker.dataSource       = alert;
    if (@available(iOS 14.0, *)) {
        alert.datePiker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    alert.isSele = issele;
    alert.frame = view.frame;
    alert.block = block;
    
    if (lastDate == nil) {
        lastDate = [alert getTomorrowDate];
    }
    if ([lastDate rangeOfString:@" "].location != NSNotFound) {
        NSArray *dates = [lastDate componentsSeparatedByString:@" "];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSDate *date = [dateFormatter dateFromString:dates.firstObject];
        [alert.datePiker setDate:date];
        NSArray *times = @[@"上午",@"中午",@"下午",@"晚上"];
        if ([times containsObject:dates.lastObject]) {
            NSInteger index = [times indexOfObject:dates.lastObject];
            [alert.picker selectRow:index inComponent:0 animated:false];
        }
    }
        
    [alert showOnView:view];
    return alert;
}

- (NSString *)getTomorrowDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] + 60 * 60 * 24;
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSince1970:time];
    return [NSString stringWithFormat: @"%@ 中午", [dateFormatter stringFromDate:tomorrowDate]];
}


- (IBAction)cancle:(id)sender {
    [self hidden];
}
- (IBAction)sure:(id)sender {
    if (self.block) {
        if (self.isSele) {
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
            NSString *currentDateStart = [dateFormat stringFromDate:self.datePiker.date];
            if (![self getDaysNumberStartTime:currentDateStart endTime:currentDateStr]) {
                [NavigateManager showMessage:@"不能选择过去的日期"];
                return;
            }
        }
        NSString *dateString = [self.datePiker.date fs_stringWithFormat:@"yyyy-MM-dd"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"date":dateString,@"time":[self valueForPicker]}];
        self.block(dic);
    }
    [self hidden];
}
-(NSString *)valueForPicker{
    NSArray *array = @[@"上午",@"中午",@"下午",@"晚上"];
    NSInteger row = [_picker selectedRowInComponent:0];
    return array[row];
}

- (BOOL)getDaysNumberStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [dateFormatter dateFromString:startTime];
    NSDate *dateToString = [dateFormatter dateFromString:endTime];
    int i = 0, j = 0;
    i = [[NSString stringWithFormat:@"%f", [dateToString timeIntervalSince1970]] intValue];//9 当前时间
    j = [[NSString stringWithFormat:@"%f", [dateFromString timeIntervalSince1970]] intValue];//7 选择时间
    if (j > i) {
        return YES;
    }
    return NO;
}
- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1;
        weakSelf.bgView.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}

- (void) hidden{
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgView.alpha = 0.01;
        //        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)dealloc{
    
}

#pragma mark - pickerview delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return 4;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    NSArray *array = @[@"上午",@"中午",@"下午",@"晚上"];
    return array[row];;
    
}
@end
