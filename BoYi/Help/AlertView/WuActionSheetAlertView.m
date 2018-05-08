//
//  WuActionSheetAlertView.m
//  ZeroRead_OC
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "WuActionSheetAlertView.h"

@implementation WuActionSheetAlertView

- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent right:(NSString *)rightContent
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"MyAlertView" owner:self options:nil]lastObject];
        self.frame = frame;
        self.messageLable.text = contentTitle;
//        [self.leftBtn setTitle:leftContent forState:UIControlStateNormal];
        [self.rightBtn setTitle:rightContent forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 2.0f;
    
}

+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectBtnBlock)block
{
    //    [[[UIApplication sharedApplication] delegate].window addSubview:self];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    WuActionSheetAlertView *alertView = [[[NSBundle mainBundle]loadNibNamed:@"WuActionSheetAlertView" owner:self options:nil] lastObject];
    alertView.frame = view.frame;
    alertView.block = block;
//    [alertView.leftBtn setTitle:topContent forState:UIControlStateNormal];
    [alertView.rightBtn setTitle:bottomContent forState:UIControlStateNormal];
    [alertView exChangeOut:alertView.bgView dur:0.5];
    [view addSubview:alertView];
    
}


- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

//- (IBAction)LeftBtnAction:(UIButton *)sender {
//    
//    if (self.block) {
//        self.block(0);
//    }
//    [self removeFromSuperview];
//    
//    
//}

- (IBAction)RightBtnAction:(UIButton *)sender {
    
    if (self.block) {
        self.block(1);
    }
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}


@end
