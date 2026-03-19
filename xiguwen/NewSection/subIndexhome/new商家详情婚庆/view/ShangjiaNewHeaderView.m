//
//  ShangjiaNewHeaderView.m
//  BoYi
//
//  Created by heng on 2017/12/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaNewHeaderView.h"

@implementation ShangjiaNewHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    
    for (int i  = 0; i < 7; i++) {
        
        UIView *btnSubView = [self viewWithTag:100 + i];
        btnSubView.userInteractionEnabled = YES;
        UIButton *btn = (UIButton *)[btnSubView viewWithTag:200];
        btn.tag = i;
        btn.userInteractionEnabled = YES;
        btn.exclusiveTouch = YES;
        [btn removeTarget:self action:@selector(tabButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(tabButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)tabButtonAction:(UIButton *)sender {
    [self.gotoNextVc sendNext:@(sender.tag)];
}

- (void)setMarkType:(NSInteger)markType{
    _markType = markType;
    for (int j  = 0; j < 7; j++) {
        
        UIView *btnSubViewwh = [self viewWithTag:100 + j];
        UIView *viewwh = (UIView *)[btnSubViewwh viewWithTag:201];
        UIButton *btnwh = (UIButton *)[btnSubViewwh viewWithTag:200];
        
        
        if (markType == j) {
            [btnwh setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            viewwh.hidden = NO;
            
        }else {
            [btnwh setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            viewwh.hidden = YES;
            
        }
    }
}

- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

@end
