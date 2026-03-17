//
//  HunliLiuchengTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunliLiuchengTableViewCell.h"
@interface HunliLiuchengTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *ShiJianL;
@property (weak, nonatomic) IBOutlet UILabel *TimeTitleL;

@end
@implementation HunliLiuchengTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(LiuChengArray *)model {
    _model = model;
	self.title.text = model.title;
	self.timeLabel.text = model.shijian;
	self.todoLabel.text = model.shixiang;
	self.personnelLabel.text = model.renyuan;
    self.ShiJianL.text = @"事件";
    self.TimeTitleL.text = @"时间";
}
@end
