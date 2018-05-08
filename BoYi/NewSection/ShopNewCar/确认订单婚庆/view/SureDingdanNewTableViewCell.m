//
//  SureDingdanNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "SureDingdanNewTableViewCell.h"

@implementation SureDingdanNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Goodssure *)model {
    _model = model;
    [self.goodsImage sd_setImageWithUrl:model.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.baojia_name;
    self.time.text = model.specification;
    //    self.isMoneyType.text = [NSString stringWithFormat:@"成交 %ld",model.user.num];
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",model.yuandingjin];
    self.number.text = [NSString stringWithFormat:@"x %ld",model.quantity];
    self.isMoneyType.text = model.paytype == 1 ? @"全款" :@"定金";
}


@end
