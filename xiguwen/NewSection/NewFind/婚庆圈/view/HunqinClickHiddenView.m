//
//  HunqinClickHiddenView.m
//  BoYi
//
//  Created by Chen on 2018/4/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinClickHiddenView.h"

@implementation HunqinClickHiddenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.hidden = YES;
}
@end
