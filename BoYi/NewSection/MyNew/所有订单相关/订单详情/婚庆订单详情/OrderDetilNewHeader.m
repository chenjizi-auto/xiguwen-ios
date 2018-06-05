//
//  OrderDetilNewHeader.m
//  BoYi
//
//  Created by heng on 2018/1/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OrderDetilNewHeader.h"

@implementation OrderDetilNewHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (IBAction)allaction:(UIButton *)sender {
    [self.selectItemSubject sendNext:@(sender.tag)];
}

- (void)setTimeshengyunumber:(NSString *)timeshengyunumber{
    _timeshengyunumber = timeshengyunumber;
    self.timeShengyu.text = timeshengyunumber;
}
- (void)setModel:(OrderDetilModelNew *)model{
    _model = model;
    //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 71：已服务（未付尾款） 79：已服务 ：80：待评价（交易成功） 90 已评价
    
    if (model.data.status == 10) {
    
        self.titleState.text = @"待支付";
        self.yifuzonge.text = @"¥ 0.00";
    }else if (model.data.status == 20) {
 
        self.titleState.text = @"交易关闭";
        self.yifuzonge.text = @"¥ 0.00";
    }else if (model.data.status == 60) {
  
        self.titleState.text = @"待接单";
        
        self.yifuzonge.text = model.data.dingjin;
    }else if (model.data.status == 70) {
   
        self.titleState.text = @"待服务";
        self.timeShengyu.text = @"";
        self.yifuzonge.text = model.data.dingjin;
    }else if (model.data.status == 71) {
    
        self.titleState.text = @"已服务";
        self.timeShengyu.text = @"";
        self.yifuzonge.text = model.data.dingjin;
    }else if (model.data.status == 79) {
        self.titleState.text = @"已服务";
        self.timeShengyu.text = @"";
        self.yifuzonge.text = model.data.dingjin;
    }else if (model.data.status == 80) {
        self.titleState.text = @"待评价";
        self.timeShengyu.text = @"";
        self.yifuzonge.text = [NSString stringWithFormat:@"%.2f",[model.data.dingjin floatValue] + [model.data.goods_amount floatValue]];
    }else { //90
        self.titleState.text = @"已完成";
        self.timeShengyu.text = @"";
        self.yifuzonge.text = [NSString stringWithFormat:@"%.2f",[model.data.dingjin floatValue] + [model.data.goods_amount floatValue]];
    }
    
    self.shangjianame.text = model.data.snickname;
    [self.goodsImage sd_setImageWithUrl:model.data.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.data.baojia_name;
    self.time.text = model.data.specification;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.data.price];
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",model.data.yuandingjin];
    self.number.text = [NSString stringWithFormat:@"x %ld",model.data.quantity];
    if (model.data.paytype == 1) {
        self.isMoneyType.text = @"全款";
    }else if (model.data.paytype == 2) {
        self.isMoneyType.text = @"定金+尾款";
    }else {
        self.isMoneyType.text = @"定金+线下";
    }
    self.zongjia.text = [NSString stringWithFormat:@"¥ %@",model.data.shangpingjongjia];
    self.dikou.text = [NSString stringWithFormat:@"¥ %@",model.data.dikouzongge];
    self.dingjin.text = [NSString stringWithFormat:@"¥ %@",model.data.dindanzongge];
    self.fanxiandikou.text = [NSString stringWithFormat:@"%@",model.data.fanjifen];
    
    self.yinfuzonge.text = [NSString stringWithFormat:@"¥ %@",model.data.yingfuzonge];
    self.yinfujine.text = [NSString stringWithFormat:@"¥ %@",model.data.yingfujine];
    self.yifuzonge.text = [NSString stringWithFormat:@"¥ %@",model.data.yifuzonge];
    
    self.bianhao.text = [NSString stringWithFormat:@"订单编号：%@",model.data.order_sn];
    self.xiadantime.text = [NSString stringWithFormat:@"下单时间：%@",model.data.published];
    self.chucifukuantime.text = [NSString stringWithFormat:@"初次付款时间：%@",model.data.pay_time];
    self.weikuantime.text = [NSString stringWithFormat:@"尾款付款时间：%@",model.data.wkpay_time];
    self.wanchengtime.text = [NSString stringWithFormat:@"完成时间：%@",model.data.sureok_time];
    
}

@end
