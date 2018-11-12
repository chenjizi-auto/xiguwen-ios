//
//  AppUpdate.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AppUpdate.h"

@implementation AppUpdate

+ (AppUpdate *)showInView:(UIView *)view content:(NSString *)content block:(void(^)(NSDictionary *dic))block{
    
    AppUpdate *alert = [[[NSBundle mainBundle]loadNibNamed:@"AppUpdate" owner:self options:nil]lastObject];
    alert.frame = view.frame;
    alert.cotent.text = content;
    alert.block = block;
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
//quxiao
- (IBAction)action:(UIButton *)sender {
    [self hidden];
}
- (IBAction)sure:(UIButton *)sender {
    if (self.block) {
        self.block(nil);
    }
//    [self hidden];
}


@end
