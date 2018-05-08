//
//  CwDatePiker.m
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/5/16.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "CwDatePiker.h"

@implementation CwDatePiker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (CwDatePiker *)showInView:(UIView *)view issele:(BOOL)issele block:(void(^)(NSDate *date))block{
    
    CwDatePiker *alert = [[[NSBundle mainBundle]loadNibNamed:@"CwDatePiker" owner:self options:nil]lastObject];
    alert.isSele = issele;
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

- (void)dealloc{
    
}

@end
