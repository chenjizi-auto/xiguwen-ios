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
    self.number.text = [NSString stringWithFormat:@"x %ld",model.quantity];
    if (model.paytype == 1) {
        self.isMoneyType.text = @"全款";
        self.priceDing.hidden = true;
        self.dingjintitle.hidden = true;
    }else if (model.paytype == 2) {
        self.priceDing.text = [NSString stringWithFormat:@"¥ %@",model.yuandingjin];
        self.isMoneyType.text = @"定金";
        self.priceDing.hidden = false;
        self.dingjintitle.hidden = false;
    }else if (model.paytype == 3) {
        self.isMoneyType.text = @"约定全款";
        self.priceDing.hidden = true;
        self.dingjintitle.hidden = true;
    }else if (model.paytype == 4) {
        self.priceDing.text = [NSString stringWithFormat:@"¥ %@",model.heji];
        self.isMoneyType.text = @"约定定金";
        self.priceDing.hidden = false;
        self.dingjintitle.hidden = false;
    }
    
}


@end
