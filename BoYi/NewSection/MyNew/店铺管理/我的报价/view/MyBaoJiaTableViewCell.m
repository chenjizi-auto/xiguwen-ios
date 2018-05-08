//
//  MyBaoJiaTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/19.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyBaoJiaTableViewCell.h"

@implementation MyBaoJiaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(MyBaoJiaModel *)model {
    _model = model;
	[self.imgView sd_setImageWithUrl:model.imglist[0]];
	[self.titleLabel setText: model.name];
	[self.priceLabel setText: model.price];
	if (model.state == 1) {
		[self.statusImg setImage:[UIImage imageNamed: @"审核中"]];
	} else if (model.state == 2) {
		if (model.status == 1) {
			[self.statusImg setImage:[UIImage imageNamed: @"已上架"]];
		} else {
			[self.statusImg setImage:[UIImage imageNamed: @"未上架"]];
		}
	} else if (model.state == 3) {
		[self.statusImg setImage:[UIImage imageNamed: @"未通过"]];
	}
	
}
@end
