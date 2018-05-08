//
//  OrderEvaluateView.m
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "OrderEvaluateView.h"

@implementation OrderEvaluateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectSureBlock)block
{
    
    OrderEvaluateView *alertView = [[[NSBundle mainBundle]loadNibNamed:@"OrderEvaluateView" owner:self options:nil] lastObject];
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.block = block;
    alertView.content.text = topContent;
    //    [alertView.leftBtn setTitle:topContent forState:UIControlStateNormal];
    //    [alertView.rightBtn setTitle:bottomContent forState:UIControlStateNormal];
    //    [alertView exChangeOut:alertView.bgView dur:0.5];
//    [view addSubview:alertView];
    
    
//    [RACObserve(alertView.starView, value) subscribeNext:^(id  _Nullable x) {
//        alertView.starValue.text = [NSString stringWithFormat:@"%.1f分",[x floatValue]];
//    }];
    [alertView.starView addObserver:alertView forKeyPath:@"value" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    [[[UIApplication sharedApplication] delegate].window addSubview:alertView];
//    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    self.starValue.text = [NSString stringWithFormat:@"%.1f分",self.starView.value];
}

- (void)dealloc {
    [self.starView removeObserver:self forKeyPath:@"value"];
}

- (IBAction)cancle:(id)sender {
    
    [self removeFromSuperview];
}
- (IBAction)sure:(id)sender {
    if (self.block) {
        self.block(self.textView.text,self.starView.value);
    }
    [self removeFromSuperview];
    
}
@end
