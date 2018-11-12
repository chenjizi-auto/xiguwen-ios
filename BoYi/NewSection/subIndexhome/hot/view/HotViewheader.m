//
//  HotViewheader.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HotViewheader.h"

@implementation HotViewheader

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
- (IBAction)action:(UIButton *)sender {
    [self.gotoNextVc sendNext:@(sender.tag)];
    
}
@end
