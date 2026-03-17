//
//  ScheduleTableViewCell.m
//  BoYi
//
//  Created by Chen on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ScheduleTableViewCell.h"

@implementation ScheduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ScheduleModelWithDate *)model {
    _model = model;
    
    self.date.text = model.scheduletime;
    self.name.text = model.name;
    self.time.text = model.scheduletab;
    self.phone.text = model.tel;
    self.content.text = model.remark;
}
@end
