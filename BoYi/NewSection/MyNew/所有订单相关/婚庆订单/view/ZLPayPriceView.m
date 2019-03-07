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
        self.lastButton = self.online;
    }
    return self;
}

///取消
- (IBAction)cancelAction:(UIButton *)sender {
    [self removeFromSuperview];
}

///支付
- (IBAction)payAction:(UIButton *)sender {
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
