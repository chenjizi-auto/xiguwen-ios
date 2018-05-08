//
//  OrderAlertView.m
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "OrderAlertView.h"

@implementation OrderAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectBtnBlock)block
{
    //    [[[UIApplication sharedApplication] delegate].window addSubview:self];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    OrderAlertView *alertView = [[[NSBundle mainBundle]loadNibNamed:@"OrderAlertView" owner:self options:nil] lastObject];
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.block = block;
    alertView.content.text = topContent;
    //    [alertView.leftBtn setTitle:topContent forState:UIControlStateNormal];
    //    [alertView.rightBtn setTitle:bottomContent forState:UIControlStateNormal];
    //    [alertView exChangeOut:alertView.bgView dur:0.5];
    //    [view addSubview:alertView];
    
    
    [[[UIApplication sharedApplication] delegate].window addSubview:alertView];
    
}


- (IBAction)cancle:(id)sender {
    
    [self removeFromSuperview];
}
- (IBAction)sure:(id)sender {
    if (self.block) {
        self.block(1);
    }
    [self removeFromSuperview];

}

@end
