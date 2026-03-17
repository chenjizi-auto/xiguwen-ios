//
//  AnlieHeader.m
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieHeader.h"

@implementation AnlieHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (RACSubject *)gotoNextVc {
    
    if (!_gotoNextVc) _gotoNextVc = [RACSubject subject];
    
    return _gotoNextVc;
}
- (IBAction)actionall:(UIButton *)sender {
    
    [self.gotoNextVc sendNext:@(sender.tag + 1)];
    
    
}


@end
