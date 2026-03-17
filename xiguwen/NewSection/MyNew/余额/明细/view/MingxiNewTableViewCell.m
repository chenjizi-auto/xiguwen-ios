//
//  MingxiNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MingxiNewTableViewCell.h"

@implementation MingxiNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupAutoHeightWithBottomView:self.dibuView bottomMargin:0];
}
- (void)setModel:(MingxiNewModel *)model {
    _model = model;
	[self.payTypeLabel setText:model.subject];
	[self.balanceLabel setText:[NSString stringWithFormat:@"余额:%@",model.aftermoney]];
	// 时间戳转换
//	NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.created_at];
//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setDateFormat:@"yyyy-MM-dd"];
	[self.timeLabel setText:model.created_at];
	[self.amountLabel setText:[NSString stringWithFormat:@"%@%@",model.trade_type == 1 ? @"+" : @"-",model.trade_type == 1 ? model.inmoney : model.outmoney]];
	
}
@end
