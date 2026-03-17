//
//  ShopCarlistTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/9/1.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShopCarlistTableViewCell.h"

@implementation ShopCarlistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ShopCarListModel *)model{
    _model = model;
    [self.seleBtn setImage:[UIImage imageNamed:model.isSele ? @"选择1" : @"选择"] forState:UIControlStateNormal];
    [self.header sd_setImageWithUrl:String(ImageHomeURL,model.user.avatar) placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.user.cnName;
    self.xiangmuName.text = model.product.name;
    self.price.text = [NSString stringWithFormat:@"¥ %ld",model.product.currentPrice];
    self.dingjin.text = [NSString stringWithFormat:@"¥ %.2f",(float)model.product.deposit * model.product.currentPrice / 100];
    self.number.text = [NSString stringWithFormat:@"%ld",model.amount];
    
}

@end
