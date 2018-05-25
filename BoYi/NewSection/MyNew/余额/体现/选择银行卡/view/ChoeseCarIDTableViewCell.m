//
//  ChoeseCarIDTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChoeseCarIDTableViewCell.h"

@implementation ChoeseCarIDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(BankCardModel *)model {
    _model = model;
	[self.imgView sd_setImageWithUrl:self.model.icon];
	[self.nameLabel setText: self.model.name];
    [self.numberLabel setText:[NSString stringWithFormat:@"尾号%@",[self.model.band_number substringFromIndex:self.model.band_number.length-4]]];
//    [self.numberLabel setText:[NSString stringWithFormat:@"尾号%@%@",[self.model.band_number substringFromIndex:self.model.band_number.length-4],self.model.type]];
	[self.selectedImg setHidden:YES];
}
@end
