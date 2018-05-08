//
//  HunQinOrderSmallTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunQinOrderSmallTableViewCell.h"
@implementation HunQinOrderSmallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Hunqinordernew *)model {
    _model = model;
    //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 71：已服务（未付尾款） 79：已服务 ：80：待评价（交易成功） 90 已评价
    if (model.status == 20) {
        self.typeImage.image = [UIImage imageNamed:@"交易关闭"];
        self.shifukuan.text = @"¥ 0.00";
        
    }else if (model.status == 60){

        self.typeImage.image = [UIImage imageNamed:@"待接单"];
        self.shifukuan.text = [NSString stringWithFormat:@"¥ %@",model.shifukuan];
    }else { //90 已评价
        self.shifukuan.text = [NSString stringWithFormat:@"¥ %@",model.shifukuan];
        self.typeImage.image = [UIImage imageNamed:@"已完成1"];
    }
    //shangjia
    self.shangjiaName.text = model.seller_info.nickname;
    //shangpin
    [self.goodsImage sd_setImageWithUrl:model.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.baojia_name;
    self.time.text = model.specification;
    //    self.isMoneyType.text = [NSString stringWithFormat:@"成交 %ld",model.user.num];
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
