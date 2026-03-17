//
//  MyCenterAlertView.m
//  CardioCycle
//
//  Created by bodecn on 16/6/24.
//  Copyright © 2016年 酷蜂ios. All rights reserved.
//

#import "MyCenterAlertView.h"

@implementation MyCenterAlertView {
    
    __weak IBOutlet NSLayoutConstraint *_BgViewHeight;
}

- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"MyCenterAlertView" owner:self options:nil]lastObject];
        self.frame = frame;
        CGFloat height = [contentTitle sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(ScreenWidth - 72, ScreenHeight)].height;
        if (height > 87) {
            _BgViewHeight.constant = height + 51;
        }
        
        self.messageLable.text = contentTitle;
        [self.leftBtn setTitle:leftContent forState:UIControlStateNormal];
//        [self.rightBtn setTitle:rightContent forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 12.0f;
    
}

- (void)showInView:(UIView *)view
{
    //    [[[UIApplication sharedApplication] delegate].window addSubview:self];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [self exChangeOut:self.bgView dur:0.5];
    [view addSubview:self];
    
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

- (IBAction)LeftBtnAction:(UIButton *)sender {

    [self removeFromSuperview];
    
    
}
@end
