
//
//  ApayOrYL.m
//  BoYi
//
//  Created by apple on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ApayOrYL.h"

@implementation ApayOrYL

+ (ApayOrYL *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block{
    
    ApayOrYL *alert = [[[NSBundle mainBundle]loadNibNamed:@"ApayOrYL" owner:self options:nil]lastObject];
    
    alert.frame = view.frame;
    alert.block = block;
    alert.type = @"1";
    [alert showOnView:view];
    return alert;
    
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
- (IBAction)payAC:(UIButton *)sender {
    
    if (sender.tag == 10) {
        
        if (self.block) {

            self.block(@{@"type":@"1"});
        }
        [self hidden];
        
    }else if (sender.tag == 11) {
        if (self.block) {
            
            self.block(@{@"type":@"2"});
        }
        [self hidden];
        
    }else{
        [self hidden];
    }
    
}


@end
