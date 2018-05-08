//
//  PIngjiaHuifu.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "PIngjiaHuifu.h"

@implementation PIngjiaHuifu

+ (PIngjiaHuifu *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block{
    PIngjiaHuifu *alert = [[[NSBundle mainBundle]loadNibNamed:@"PIngjiaHuifu" owner:self options:nil]lastObject];
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    return alert;
}
//确定
- (IBAction)sureAC:(UIButton *)sender {

    if (self.block) {
        
        self.block(self.dicData);
    }
    [self hiddenView];
}


- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
    //    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.alpha = 1;
        //        weakSelf.bgView.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}
- (IBAction)cancle:(UIButton *)sender {
    [self hiddenView];
}

- (void)hiddenView{
    
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        
        //        weakSelf.alpha = 0.01;
        //        weakSelf.bgView.alpha = 0.01;
        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self endEditing:YES];
}
@end
