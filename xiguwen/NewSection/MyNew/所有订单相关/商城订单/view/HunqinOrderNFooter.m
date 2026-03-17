//
//  HunqinOrderNFooter.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinOrderNFooter.h"

@implementation HunqinOrderNFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
}
#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    /// 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
    //    if (0) {
    //        return;
    //    }
    /// 计算倒计时
    DataShangcheng *model = self.model;

    NSInteger number;
    number = model.fukuantime;
    NSInteger countDown = number - kCountDownManager.timeInterval;
    
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
        self.shengyuTime.hidden = YES;
        self.timeTitle.hidden = YES;
        // 回调给控制器
        return;
    }
    /// 重新赋值
    self.shengyuTime.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
}
- (void)setModel:(DataShangcheng *)model {
    _model = model;
    //不传为全部，10：待支付 20：已取消 60：已付款 70：已发货 ：80：已收货 90：已完成
    //shangjia //10 70 80 90
    if (model.status == 10) {

        self.shifukuan.text = @"¥ 0.00";
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = NO;
        [self.rightBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        [self.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    }else if (model.status == 70) {//已发货

        self.shifukuan.text = [NSString stringWithFormat:@"¥ %@",model.order_amount];
        self.leftBtn.hidden = NO;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.leftBtn setTitle:@"查看物流" forState:UIControlStateNormal];

    }else if (model.status == 80)  {

        self.shifukuan.text = [NSString stringWithFormat:@"¥ %@",model.order_amount];
        self.leftBtn.hidden = NO;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        [self.leftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    }else {
        self.shifukuan.text = [NSString stringWithFormat:@"¥ %@",model.order_amount];
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"查看物流" forState:UIControlStateNormal];

    }
    
    self.gongjiNumber.text = [NSString stringWithFormat:@"共%ld件商品",model.goods.count ];
    self.xiaoji.text = [NSString stringWithFormat:@"¥ %@",model.order_amount];
    //nstimer
    [self countDownNotification];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
