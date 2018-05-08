//
//  CaiPaiDateSele.m
//  BoYi
//
//  Created by heng on 2018/1/19.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CaiPaiDateSele.h"

@implementation CaiPaiDateSele

+ (CaiPaiDateSele *)showInView:(UIView *)view  block:(void(^)(NSDate *date))block{
    
    CaiPaiDateSele *alert = [[[NSBundle mainBundle]loadNibNamed:@"CaiPaiDateSele" owner:self options:nil]lastObject];
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
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        NSString *currentDateStart = [dateFormat stringFromDate:self.datePiker.date];
        if (![self getDaysNumberStartTime:currentDateStart endTime:currentDateStr]) {
            [NavigateManager showMessage:@"不能选择过去的日期"];
            return;
        }
        self.block(self.datePiker.date);
    }
    [self hidden];
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
@end
