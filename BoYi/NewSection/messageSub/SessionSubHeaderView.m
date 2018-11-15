//
//  SessionSubHeaderView.m
//  BoYi
//
//  Created by 陈伟 on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SessionSubHeaderView.h"

@implementation SessionSubHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)selectBtn:(UIButton *)sender {
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *btn = (UIButton *)[sender.superview viewWithTag:100 + i];
        UILabel *label = (UILabel *)[sender.superview viewWithTag:200 + i];
        if (btn.tag != sender.tag) {
            btn.selected = NO;
            label.textColor = RGBA(83, 83, 83, 1);
        } else {
            btn.selected = YES;
            label.textColor = RGBA(252, 88, 135, 1);
        }
    }
    if (self.block) {
        self.block(sender.tag - 100);
    }
    
}

+ (SessionSubHeaderView *)showInView:(UIView *)view {
    
    SessionSubHeaderView *_header = [[NSBundle mainBundle] loadNibNamed:@"SessionSubHeaderView" owner:nil options:nil].firstObject;
//    CGFloat height = isIPhoneX ? 82 : 64;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _header.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0, ScreenWidth, 80);
    });
    
    [view addSubview:_header];
    [_header selectBtn:(UIButton *)[_header viewWithTag:100]];
    return _header;
}
@end
