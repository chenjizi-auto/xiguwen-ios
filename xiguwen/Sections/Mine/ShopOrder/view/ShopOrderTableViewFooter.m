//
//  ShopOrderTableViewFooter.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShopOrderTableViewFooter.h"

@implementation ShopOrderTableViewFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setModel:(MyOrderModel *)model {
    _model = model;
    
    self.totalCount.text = [NSString stringWithFormat:@"共计%ld件商品,合计全额:",model.detailInfoBvoList.count];
    
    self.totalPrice.text = [NSString stringWithFormat:@"￥%.1f",model.price];
    self.orderMoney.text = [NSString stringWithFormat:@"￥%.1f",model.deposit];
}

@end
