//
//  ShopOrderTableViewCell.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShopOrderTableViewCell.h"

@implementation ShopOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Detailinfobvolist *)model {
    _model = model;
    
    [self.Cover sd_setImageWithUrl:ImageAppendURL(model.bizUser.avatar)];
    self.name.text = model.byUserBizProduct.name;
    self.allPrice.text = [NSString stringWithFormat:@"￥%.1f",model.price];
    self.offerPrice.text = [NSString stringWithFormat:@"￥%.1f",model.deposit];
    self.countLabel.text = [NSString stringWithFormat:@"x%ld",model.amount];
}

@end
