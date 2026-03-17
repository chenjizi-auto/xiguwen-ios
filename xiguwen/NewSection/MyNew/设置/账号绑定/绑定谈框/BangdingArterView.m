//
//  BangdingArterView.m
//  BoYi
//
//  Created by heng on 2018/1/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "BangdingArterView.h"

@implementation BangdingArterView

+ (BangdingArterView *)showInView:(UIView *)view title:(NSString *)title message:(NSString *)message {
    BangdingArterView *alert = [[[NSBundle mainBundle]loadNibNamed:@"BangdingArterView" owner:self options:nil]lastObject];

    alert.frame = view.frame;
    if (title) {
        alert.title.text = title;
    }
    if (message) {
        alert.message.text = message;
    }
    
    [alert showOnView:view];
    return alert;
}
- (IBAction)cancle:(id)sender {
    if (self.block) {
        self.block();
    }
    [self hidden];
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
        weakSelf.bgView.alpha = 1;
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

- (void)dealloc{
    
}
@end
