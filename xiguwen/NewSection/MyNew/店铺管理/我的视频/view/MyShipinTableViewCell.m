//
//  MyShipinTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/20.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyShipinTableViewCell.h"

@implementation MyShipinTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(MyShipinModel *)model {
    _model = model;
	[self.imgView sd_setImageWithUrl:model.cover];
	[self.titleLabel setText:model.title];
//	[self.infoLabel setText:model.synopsis];
	if (model.status == 1) {
		[self.statusImgView setImage:[UIImage imageNamed: @"审核中"]];
	} else if (model.status == 2) {
		if (model.putaway == 1) {
			[self.statusImgView setImage:[UIImage imageNamed: @"已上架"]];
		} else {
			[self.statusImgView setImage:[UIImage imageNamed: @"未上架"]];
		}
	} else if (model.status == 3) {
		[self.statusImgView setImage:[UIImage imageNamed: @"未通过"]];
	}
}
@end
