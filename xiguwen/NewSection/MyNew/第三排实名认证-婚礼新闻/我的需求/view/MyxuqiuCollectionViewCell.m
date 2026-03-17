//
//  MyxuqiuCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyxuqiuCollectionViewCell.h"

@implementation MyxuqiuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(PlayersModel *)model {
	_model = model;
	[self.headerImg sd_setImageWithUrl:model.head];
	if (model.status_j == 1) {
		[self.statusImg setImage:[UIImage imageNamed:@"已中标"]];
		[self.statusImg setHidden:NO];
	} else {
		[self.statusImg setHidden:YES];
	}
//	else if (model.status_j == 2) {
//		[self.statusImg setImage:[UIImage imageNamed:@"未中标"]];
//	} else {
//		[self.statusImg setImage:[UIImage imageNamed:@"进行中"]];
//	}
	[self.nameLabel setText:model.nickname];
	[self.typeLabel setText:model.occupationid];
	[self.priceLabel setText:[NSString stringWithFormat:@"¥%ld起",model.minimumprice]];
	
}

@end
