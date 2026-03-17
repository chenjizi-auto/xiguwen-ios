//
//  MyAlertWithTextView.m
//  Base
//
//  Created by byrd-dreamer1 on 16/8/23.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "MyAlertWithTextView.h"

@implementation MyAlertWithTextView

- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent right:(NSString *)rightContent
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"MyAlertWithTextView" owner:self options:nil]lastObject];
        self.frame = frame;
        self.TextView.placeholder = contentTitle;
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

- (void)showInView:(UIView *)view block:(EditTextBlock)block
{
    //    [[[UIApplication sharedApplication] delegate].window addSubview:self];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    
    self.block = block;
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (IBAction)LeftBtnAction:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(MyAlertWithTextView:customClickFormLeft:)]){
        [self.delegate MyAlertWithTextView:self customClickFormLeft:sender];
    }
//    if (self.block) {
//        self.block(nil);
//    }
    [self removeFromSuperview];
    
    
}

- (IBAction)RightBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyAlertWithTextView:customClickFormRight:)]) {
        [self.delegate MyAlertWithTextView:self customClickFormRight:sender];
    }
    if (self.block && ![self.TextView.text isBlankString]) {
        self.block(self.TextView.text);
    }
    [self removeFromSuperview];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length >= 10 && text.length > range.length) {
        return NO;
    }else{
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.markedTextRange == nil && textView.text.length > 10) {
        textView.text = [textView.text substringToIndex:10];
    }
}

@end
