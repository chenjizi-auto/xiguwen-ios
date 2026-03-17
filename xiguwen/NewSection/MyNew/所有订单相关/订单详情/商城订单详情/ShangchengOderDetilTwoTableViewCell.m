//
//  ShangchengOderDetilTwoTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengOderDetilTwoTableViewCell.h"

@implementation ShangchengOderDetilTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(GoodsSCDetil *)model{
    _model = model;
    [self.goodsImage sd_setImageWithUrl:model.goods_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.goods_name;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.number.text = [NSString stringWithFormat:@"x %ld",model.quantity];
    self.yanseChima.text = model.specification;
    NSInteger status = model.status;
    
    //evaluation    10退款 20同意退款 30 拒绝退款 60退货退款 70发货同意 80 发货后同意 90 发货后不同意
}


@end
