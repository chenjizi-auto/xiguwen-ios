//
//  CwSuccessAlertView.m
//  ZeroRead
//
//  Created by Chen on 2017/3/14.
//  Copyright © 2017年 pan wei. All rights reserved.
//

#import "CwSuccessAlertView.h"
@interface CwSuccessAlertView ()

@property (weak, nonatomic) IBOutlet UIButton *SureButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, copy) void(^(success))(NSInteger index);

@end
@implementation CwSuccessAlertView
- (IBAction)myCode:(UIButton *)sender {
    [self hidden];
    if (self.success) {
        self.success(1);
    }
}

+ (void)showAlertViewWithTitle:(NSString *)title des:(NSString *)des leftBtn:(NSString *)left Success:(void (^)(NSInteger type))success {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    if ([keyWindow viewWithTag:989]) {
        return;
    }
    
    CwSuccessAlertView *goodsView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CwSuccessAlertView class]) owner:nil options:nil] lastObject];
    goodsView.frame = CGRectMake((ScreenWidth - 290) / 2.0, (ScreenHeight - 129) / 2.0, 290,129);
    goodsView.success = success;
    goodsView.layer.cornerRadius = 10;
    goodsView.layer.masksToBounds = YES;
    
    
    goodsView.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    goodsView.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:goodsView action:@selector(hidden)];
    [goodsView.bgView addGestureRecognizer:tap];
    goodsView.tag = 989;
    [keyWindow addSubview:goodsView.bgView];
    
    
    goodsView.titleLabel.text = title;
    goodsView.decLabel.text = des;
    
    [goodsView.SureButton setTitle:left forState:UIControlStateNormal];
    
    
    
    [goodsView showOnView:keyWindow];
    
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
        weakSelf.bgView.alpha = 0.5;
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
