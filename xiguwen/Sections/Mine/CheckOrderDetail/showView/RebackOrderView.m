//
//  RebackOrderView.m
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "RebackOrderView.h"

@implementation RebackOrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectBlock)block
{
    //    [[[UIApplication sharedApplication] delegate].window addSubview:self];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    RebackOrderView *alertView = [[[NSBundle mainBundle]loadNibNamed:@"RebackOrderView" owner:self options:nil] lastObject];
    
//    alertView.content.text = topContent;
    alertView.textView.placeholder = @"请输入退款原因";
    
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.block = block;
    alertView.content.text = topContent;
    
    
    
    [[[UIApplication sharedApplication] delegate].window addSubview:alertView];
    
}


- (IBAction)cancle:(id)sender {
    
    [self removeFromSuperview];
}
- (IBAction)sure:(id)sender {
    if (self.block) {
        self.block(self.textView.text);
    }
    [self removeFromSuperview];
    
}

@end
