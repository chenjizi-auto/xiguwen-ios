//
//  ZLPayPriceView.m
//  BoYi
//
//  Created by 赵磊 on 2019/3/6.
//  Copyright © 2019 hengwu. All rights reserved.
//

#import "ZLPayPriceView.h"

@interface ZLPayPriceView ()

///是否已经选择第一步
@property (nonatomic,unsafe_unretained) BOOL didSelected;
///上次点击的按钮
@property (nonatomic,weak) UIButton *lastButton;

@end

@implementation ZLPayPriceView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

#pragma mark - Set
- (void)setAllowShow:(BOOL)allowShow {
    _allowShow = allowShow;
    self.lastButton = self.online;
    if (allowShow) {
        self.topBgView.hidden = NO;
        [self.payButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.priceTf resignFirstResponder];
    }else {
        self.didSelected = YES;
        self.topBgView.hidden = YES;
        [self.payButton setTitle:@"去支付" forState:UIControlStateNormal];
        [self.priceTf becomeFirstResponder];
    }
}

///取消
- (IBAction)cancelAction:(UIButton *)sender {
    [self removeFromSuperview];
}

///支付
- (IBAction)payAction:(UIButton *)sender {
    if (!self.allowShow) {
        if (self.payAction) {
            self.payAction();
        }
        return;
    }
    if (self.lastButton != self.online) {
        if (self.offlinePay) {
            self.offlinePay();
        }
        [self removeFromSuperview];
        return;
    }
    if (!self.didSelected) {
        self.didSelected = YES;
        self.topBgView.hidden = YES;
        [self.payButton setTitle:@"去支付" forState:UIControlStateNormal];
        [self.priceTf becomeFirstResponder];
        return;
    }
    if (self.payAction) {
        self.payAction();
    }
}
- (IBAction)itemAction:(UIButton *)sender {
    if (!self.lastButton) {
        self.lastButton = self.online;
    }
    if (sender != self.lastButton) {
        sender.selected = !sender.selected;
        self.lastButton.selected = !self.lastButton.selected;
        self.lastButton = sender;
    }
}

@end
