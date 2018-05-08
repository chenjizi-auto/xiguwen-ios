//
//  KaiTongVIPView.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "KaiTongVIPView.h"

@implementation KaiTongVIPView {
    NSInteger selectTag;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

+ (KaiTongVIPView *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block{
    KaiTongVIPView *alert = [[[NSBundle mainBundle]loadNibNamed:@"KaiTongVIPView" owner:self options:nil]lastObject];
    alert.dicData = [[NSMutableDictionary alloc] init];
    //侧栏手势
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    return alert;
    
}
- (void)setDicData:(NSDictionary *)dicData {
    _dicData = dicData;
    
    [self allAction:(UIButton *)[[self viewWithTag:200] viewWithTag:100]];
}
- (void)showInfo {
    
}
- (IBAction)allAction:(UIButton *)sender {
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[sender.superview viewWithTag:100 + i];
        if (sender.tag != 100 + i) {
            btn.layer.borderColor = [UIColor whiteColor].CGColor;
        } else {
            btn.layer.borderColor = MAINCOLOR.CGColor;
        }
        
        
    }
    //显示价格
    [self showPrice:sender.tag - 100];
}

- (void)showPrice:(NSInteger)tag {
    if (!self.dicData) {
        return;
    }
    switch (tag) {
        case 0:
            self.priceLabel.text = [NSString stringWithFormat:@"%@",self.dicData[@"vipsmoney12"]];
            selectTag = 12;
            break;
        case 1:
            self.priceLabel.text = [NSString stringWithFormat:@"%@",self.dicData[@"vipsmoney24"]];
            selectTag = 24;
            break;
            
        default:
            self.priceLabel.text = [NSString stringWithFormat:@"%@",self.dicData[@"vipsmoney36"]];
            selectTag = 36;
            break;
    }
    
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        [self hiddenView];
    }else {
        if (self.block) {
            
            NSString *money = self.dicData[[NSString stringWithFormat:@"vipsmoney%ld",selectTag]];
            NSDictionary *info = @{@"shopivipstat":@(selectTag),
                                   @"money":money};
            self.block(info);
        }
        [self hiddenView];
    }
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

@end
