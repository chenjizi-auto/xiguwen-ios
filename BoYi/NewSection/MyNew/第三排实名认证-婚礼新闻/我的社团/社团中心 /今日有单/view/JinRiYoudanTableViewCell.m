//
//  JinRiYoudanTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "JinRiYoudanTableViewCell.h"

@implementation JinRiYoudanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(JinRiYoudanModel *)model {
    _model = model;
	[self.nameLabel setText:model.nickname];
	switch (model.timeslot) {
		case 1:
			[self.timeLabel setText:@"上午"];
			break;
			
		case 2:
			[self.timeLabel setText:@"中午"];
			break;
			
		case 3:
			[self.timeLabel setText:@"下午"];
			break;
			
		case 4:
			[self.timeLabel setText:@"晚上"];
			break;
			
		case 5:
			[self.timeLabel setText:@"全天"];
			break;
			
		case 6:
			[self.timeLabel setText:@"不接单"];
			break;
		default:
			break;
	}
}
@end
