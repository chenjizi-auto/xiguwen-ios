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
    
    for (int i  = 0; i < 7; i++) {
        
        UIView *btnSubView = [self viewWithTag:100 + i];
        UIButton *btn = (UIButton *)[btnSubView viewWithTag:200];
        @weakify(self);
        //点击
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            
            [self.gotoNextVc sendNext:@(i)];
            
        }];
    }
    
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
