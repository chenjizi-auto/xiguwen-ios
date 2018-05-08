//
//  ScheduleTableViewHeaderFooterView.m
//  BoYi
//
//  Created by Chen on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ScheduleTableViewHeaderFooterView.h"

@implementation ScheduleTableViewHeaderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return self;
}
@end
