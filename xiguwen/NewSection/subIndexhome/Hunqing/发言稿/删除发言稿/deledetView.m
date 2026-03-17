//
//  deledetView.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "deledetView.h"

@implementation deledetView

+ (deledetView *)showInView:(UIView *)view block:(void(^)(NSMutableDictionary *dic))block{
    
    deledetView *alert = [[[NSBundle mainBundle]loadNibNamed:@"deledetView" owner:self options:nil]lastObject];
    
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    return alert;
}
- (IBAction)cancle:(id)sender {
    [self hidden];
}
- (IBAction)sure:(id)sender {
    if (self.block) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        self.block(dic);
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

@end
