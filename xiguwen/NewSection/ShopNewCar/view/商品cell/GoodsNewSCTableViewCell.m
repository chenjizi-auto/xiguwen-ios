//
//  GoodsNewSCTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/26.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "GoodsNewSCTableViewCell.h"

@implementation GoodsNewSCTableViewCell

static UIEdgeInsets const kGoodsCellInsets = {0.0, 12.0, 0.0, 12.0};

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 12.0;
    self.contentView.layer.masksToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, kGoodsCellInsets);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Goods *)model {
    _model = model;
    [self.goodsImage sd_setImageWithUrl:model.goods_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.goods_name;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.number.text = [NSString stringWithFormat:@"%ld",model.quantity];
    self.isGouImage.image = [UIImage imageNamed:model.isSele == YES ? @"勾选商品":@"未勾选商品"];
    
}
@end
