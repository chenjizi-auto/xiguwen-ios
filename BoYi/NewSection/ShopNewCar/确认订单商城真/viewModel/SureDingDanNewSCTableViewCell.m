//
//  SureDingDanNewSCTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SureDingDanNewSCTableViewCell.h"

@implementation SureDingDanNewSCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModelsc:(GoodsSC *)modelsc{
    _modelsc = modelsc;
    [self.goodsImage sd_setImageWithUrl:modelsc.goods_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = modelsc.goods_name;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",modelsc.price];
    self.number.text = [NSString stringWithFormat:@"x %ld",modelsc.quantity];
}
@end
