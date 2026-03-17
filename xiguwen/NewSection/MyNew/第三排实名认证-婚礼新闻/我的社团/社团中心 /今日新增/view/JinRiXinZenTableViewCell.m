//
//  JinRiXinZenTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/16.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "JinRiXinZenTableViewCell.h"

@implementation JinRiXinZenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(JinRiXinZenModel *)model {
    _model = model;
	[self.nameLabel setText:model.nickname];
	[self.beforeTimeLabel setText:[NSString stringWithFormat:@"(%@)",model.create_ti]];
	switch (model.timeslot) {
		case 1:
			[self.timeLabel setText:[NSString stringWithFormat:@"%@ %@",model.date,@"上午"]];
			break;
			
		case 2:
			[self.timeLabel setText:[NSString stringWithFormat:@"%@ %@",model.date,@"中午"]];
			break;
			
		case 3:
			[self.timeLabel setText:[NSString stringWithFormat:@"%@ %@",model.date,@"下午"]];
			break;
			
		case 4:
			[self.timeLabel setText:[NSString stringWithFormat:@"%@ %@",model.date,@"晚上"]];
			break;
			
		case 5:
			[self.timeLabel setText:[NSString stringWithFormat:@"%@ %@",model.date,@"全天"]];
			break;
			
		case 6:
			[self.timeLabel setText:[NSString stringWithFormat:@"%@ %@",model.date,@"不接单"]];
			break;
		default:
			break;
	}
}
@end
