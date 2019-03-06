//
//  ZLPayPriceView.m
//  BoYi
//
//  Created by 赵磊 on 2019/3/6.
//  Copyright © 2019 hengwu. All rights reserved.
//

#import "ZLPayPriceView.h"

@implementation ZLPayPriceView

///取消
- (IBAction)cancelAction:(UIButton *)sender {
    [self removeFromSuperview];
}

///支付
- (IBAction)payAction:(UIButton *)sender {
    if (self.payAction) {
        self.payAction();
    }
}

@end
