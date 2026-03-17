//
//  ChengyuanThreeTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/15.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ChengyuanThreeTableViewCell.h"

@implementation ChengyuanThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Chengyuan *)model{
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head];
    self.name.text = [NSString stringWithFormat:@"%@",model.nickname];
    self.zhiwei.text = [NSString stringWithFormat:@"%@",model.occupation];
    self.price.text = [NSString stringWithFormat:@"¥%@起",model.zuidijia];
}
@end
