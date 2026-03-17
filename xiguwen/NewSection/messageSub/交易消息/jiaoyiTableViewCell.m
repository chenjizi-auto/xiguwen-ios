//
//  jiaoyiTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "jiaoyiTableViewCell.h"

@implementation jiaoyiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Contjiaoyi *)model{
    _model = model;
    self.state.text = model.title;
    self.type.text = model.cont;
    self.binahao.text = [NSString stringWithFormat:@"订单编号：%@",model.order_sn];
    self.time.text = model.createtime;
    [self.goodsimage sd_setImageWithUrl:model.img placeHolder:[UIImage imageNamed:@"占位图片"]];
}

@end
