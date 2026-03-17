//
//  MyYaoQingTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyYaoQingTableViewCell.h"

@implementation MyYaoQingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(InvitationArray *)model {
	_model = model;
	self.phoneLabel.text = [NSString stringWithFormat: @"%ld",[model.mobile integerValue]];
	self.timeLabel.text = model.created_at;
}

@end
