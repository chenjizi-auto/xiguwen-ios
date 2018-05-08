//
//  GoodsNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "GoodsNewTableViewCell.h"

@implementation GoodsNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Goods *)model {
    _model = model;
    [self.goodsImage sd_setImageWithUrl:model.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.baojia_name;
    self.time.text = model.specification;
    
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.price];
    if (model.paytype == 1) {//全款
        self.priceDing.hidden = YES;
        self.dintitle.hidden = YES;
        self.isMoneyType.text = @"全款";
    }else {//定金
        self.priceDing.hidden = NO;
        self.dintitle.hidden = NO;
        self.priceDing.text = [NSString stringWithFormat:@"¥ %@",model.partprice];
        self.isMoneyType.text = @"定金";
    }
    
    self.number.text = [NSString stringWithFormat:@"%ld",model.quantity];
    self.isGouImage.image = [UIImage imageNamed:model.isSele == YES ? @"勾选商品":@"未勾选商品"];

}
@end
