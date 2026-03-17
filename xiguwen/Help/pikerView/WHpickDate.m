//
//  WHpickDate.m
//  BoYi
//
//  Created by heng on 2018/2/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "WHpickDate.h"

@implementation WHpickDate

+ (WHpickDate *)showInView:(UIView *)view block:(void(^)(NSDate *date))block{
    WHpickDate *alert = [[[NSBundle mainBundle]loadNibNamed:@"WHpickDate" owner:self options:nil]lastObject];
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    return alert;
}
- (IBAction)cancle:(id)sender {
    [self hidden];
}
- (IBAction)sure:(id)sender {
    if (self.block) {
        self.block(self.datePiker.date);
    }
    [self hidden];
}
- (BOOL)getDaysNumberStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
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
@end
