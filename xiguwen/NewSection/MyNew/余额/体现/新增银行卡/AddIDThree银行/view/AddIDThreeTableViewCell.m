//
//  AddIDThreeTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddIDThreeTableViewCell.h"

@implementation AddIDThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(BankCardModel *)model {
    _model = model;
	[self.nameLabel setText:model.name];
}
@end
