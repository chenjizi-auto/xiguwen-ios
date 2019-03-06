//
//  HunqingJiedanSamllTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqingJiedanSamllTableViewCell.h"

@implementation HunqingJiedanSamllTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Hunqinordernew *)model {
    
    //订单状态 10：待支付 20：已关闭 60：待接单 70：待服务 79：已服务 ：80：待评价 90 交易完成 100 代服务 tuikuan  // 20 79 80 90
    
    _model = model;

    if (model.status == 20) {
        self.typeImage.image = [UIImage imageNamed:@"交易关闭"];
    }else if (model.status == 79 || model.status == 71) {
        self.typeImage.image = [UIImage imageNamed:@"已服务"];
    }else if (model.status == 80) {
        self.typeImage.image = [UIImage imageNamed:@"待评价1"];
    }else { //90 已评价
        self.typeImage.image = [UIImage imageNamed:@"交易成功"];
    }
    self.shifukuan.text = [NSString stringWithFormat:@"¥ %@",model.shifukuan];
    //shangjia
    self.shangjiaName.text = model.seller_info.nickname;
    //shangpin
    [self.goodsImage sd_setImageWithUrl:model.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.baojia_name;
    self.time.text = model.specification;

    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",model.yuandingjin];
    self.number.text = [NSString stringWithFormat:@"x %ld",model.zquantity];
    if (model.paytype == 1) {
        self.isMoneyType.text = @"全款";
    }else if (model.paytype == 2) {
        self.isMoneyType.text = @"定金+尾款";
    }else {
        self.isMoneyType.text = @"定金+线下";
    }
    self.gongjiNumber.text = [NSString stringWithFormat:@"共%ld件商品",model.quantity];
    
    self.xiaoji.text = [NSString stringWithFormat:@"¥ %@",model.zongjine];
    self.dikou.text = [NSString stringWithFormat:@"¥ %@",model.deductible];
    
}
@end
