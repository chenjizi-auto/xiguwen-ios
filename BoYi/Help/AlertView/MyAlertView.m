//
//  MyAlertView.m
//  CardioCycle
//
//  Created by Apple on 15/12/15.
//  Copyright © 2015年 酷蜂ios. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView

- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent right:(NSString *)rightContent
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"MyAlertView" owner:self options:nil]lastObject];
        self.frame = frame;
        self.messageLable.text = contentTitle;
        [self.leftBtn setTitle:leftContent forState:UIControlStateNormal];
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

- (void)showInView:(UIView *)view block:(SelectBtnBlock)block
{
//    [[[UIApplication sharedApplication] delegate].window addSubview:self];
//    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    self.block = block;
    [self exChangeOut:self.bgView dur:0.5];
    [view addSubview:self];
   
}
+ (void)showInView:(UIView *)view
           message:(NSString *)contentTitle
              left:(NSString *)leftContent
             right:(NSString *)rightContent
             block:(SelectBtnBlock)block {
    
    MyAlertView *alert = [[[NSBundle mainBundle]loadNibNamed:@"MyAlertView" owner:self options:nil]lastObject];
    alert.frame = view.frame;
    alert.messageLable.text = contentTitle;
    [alert.leftBtn setTitle:leftContent forState:UIControlStateNormal];
    [alert.rightBtn setTitle:rightContent forState:UIControlStateNormal];
    [alert.rightBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    alert.block = block;
    [view addSubview:alert];
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

- (IBAction)LeftBtnAction:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(myalertView:customClickFormLeft:)]){
        [self.delegate myalertView:self customClickFormLeft:sender];
    }
    if (self.block) {
        self.block(0);
    }
    [self removeFromSuperview];
    
    
}

- (IBAction)RightBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myalertView:customClickFormRight:)]) {
        [self.delegate myalertView:self customClickFormRight:sender];
    }
    if (self.block) {
        self.block(1);
    }
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
@end
