//
//  LianxiThreeTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "LianxiThreeTableViewCell.h"

@implementation LianxiThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ChengyuanLianxi *)model{
    _model = model;
    self.name.text = model.nickname;
    self.iphone.text = model.mobile;
}
@end
