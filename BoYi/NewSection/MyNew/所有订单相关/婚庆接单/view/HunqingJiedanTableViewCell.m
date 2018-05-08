//
//  HunqingJiedanTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqingJiedanTableViewCell.h"

@implementation HunqingJiedanTableViewCell

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
    Hunqinordernew *model = self.model;
    NSInteger timeInterval;
    NSInteger number;
    number = model.jiedantime;
    //    if (number) {
    //        timeInterval = [kCountDownManager timeIntervalWithIdentifier:[NSString stringWithFormat:@"%ld",number]];
    //    }else {
    //        timeInterval = kCountDownManager.timeInterval;
    //    }
    //    NSInteger countDown = [self.model.count integerValue] - kCountDownManager.timeInterval;
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
- (void)setModel:(Hunqinordernew *)model {
    _model = model;
    //订单状态 10：待支付 20：已关闭 60：待接单 70：待服务 79：已服务 ：80：待评价 90 交易完成 100 代服务 tuikuan  // 10 60 70 100
    //shangjia
    if (model.status == 10) {

        self.typeImage.image = [UIImage imageNamed:@"待付款"];
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        [self.rightBtn setTitle:@"修改价格" forState:UIControlStateNormal];
        
    }else if (model.status == 60) {
 
        self.typeImage.image = [UIImage imageNamed:@"待接单"];
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = NO;
        [self.rightBtn setTitle:@"立即接单" forState:UIControlStateNormal];
        [self.leftBtn setTitle:@"拒绝接单" forState:UIControlStateNormal];
    }else if (model.status == 70) {

        self.typeImage.image = [UIImage imageNamed:@"待服务"];
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"完成订单" forState:UIControlStateNormal];
    }else { //100 已评价

        self.typeImage.image = [UIImage imageNamed:@"待服务"];
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = NO;
        [self.rightBtn setTitle:@"同意退款" forState:UIControlStateNormal];
        [self.leftBtn setTitle:@"拒绝退款" forState:UIControlStateNormal];
    }
    self.shangjiaName.text = model.seller_info.nickname;
    //shangpin
    [self.goodsImage sd_setImageWithUrl:model.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.shopName.text = model.baojia_name;
    self.time.text = model.specification;
    //    self.isMoneyType.text = [NSString stringWithFormat:@"成交 %ld",model.user.num];
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",model.yuandingjin];
    self.number.text = [NSString stringWithFormat:@"x %ld",model.zquantity];
    self.shifukuan.text = [NSString stringWithFormat:@"¥ %@",model.shifukuan];
    
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
    //nstimer
    [self countDownNotification];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
