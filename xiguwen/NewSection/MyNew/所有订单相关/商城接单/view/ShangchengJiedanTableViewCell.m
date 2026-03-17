//
//  ShangchengJiedanTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengJiedanTableViewCell.h"
@implementation ShangchengJiedanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}
- (void)setModel:(Goodsshangcheng *)model {
    _model = model;
    [self.goodsImage sd_setImageWithUrl:model.goods_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.shopName.text = model.goods_name;
    self.yanseChima.text = [NSString stringWithFormat:@"%@",model.specification];
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.number.text = [NSString stringWithFormat:@"x %ld",model.quantity];
}




@end
