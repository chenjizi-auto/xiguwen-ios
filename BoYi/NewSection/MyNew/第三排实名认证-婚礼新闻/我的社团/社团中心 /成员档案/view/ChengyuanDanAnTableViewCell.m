//
//  ChengyuanDanAnTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChengyuanDanAnTableViewCell.h"

@implementation ChengyuanDanAnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ChengyuanDanAnModel *)model {
    _model = model;
	
	[self.coverImg sd_setImageWithUrl:model.head];
	[self.nameLabel setText:model.nickname];
	[self.typeLabel setText:model.occupationid];
	[self.priceLabel setText:[NSString stringWithFormat:@"¥%@起",model.zuidijia]];
}
@end
