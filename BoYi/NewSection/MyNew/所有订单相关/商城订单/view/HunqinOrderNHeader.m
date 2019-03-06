//
//  HunqinOrderNHeader.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinOrderNHeader.h"

@implementation HunqinOrderNHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setModel:(DataShangcheng *)model{
    _model = model;
    //不传为全部，10：待支付 20：已取消 60：已付款 70：已发货 ：80：已收货 90：已完成
    if (model.status == 10) {
        self.typeImage.image = [UIImage imageNamed:@"待付款1"];
    }else if (model.status == 20) {
        self.typeImage.image = [UIImage imageNamed:@"交易关闭"];
    }else if (model.status == 60) {
        self.typeImage.image = [UIImage imageNamed:@"待发货"];
    }else if (model.status == 70) {
        self.typeImage.image = [UIImage imageNamed:@"待收货"];
    }else if (model.status == 80) {
        self.typeImage.image = [UIImage imageNamed:@"交易成功"];
    }else { //90 已评价
        self.typeImage.image = [UIImage imageNamed:@"交易成功"];
    }
    self.shangjiaName.text = model.seller_name;
}

@end
