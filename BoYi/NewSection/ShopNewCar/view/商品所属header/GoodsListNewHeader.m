//
//  GoodsListNewHeader.m
//  BoYi
//
//  Created by heng on 2018/1/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "GoodsListNewHeader.h"

@implementation GoodsListNewHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}
- (IBAction)action:(UIButton *)sender {
    [self.gotoNextVc sendNext:nil];
}

@end
