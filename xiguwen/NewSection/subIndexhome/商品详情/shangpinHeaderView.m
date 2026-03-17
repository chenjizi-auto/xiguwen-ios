//
//  shangpinHeaderView.m
//  BoYi
//
//  Created by heng on 2018/4/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "shangpinHeaderView.h"

@implementation shangpinHeaderView
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}

- (IBAction)jin:(IB_DESIGN_Button *)sender {
    [self.selectItemSubject sendNext:nil];
}



- (void)setModel:(shangpinnewModel *)model{
    _model = model;
    
    if (model.shangpin.shopimg.count > 0) {
        [self.bigimage sd_setImageWithUrl:model.shangpin.shopimg[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    }
    
    self.typeName.text = model.shangpin.shopname;
    self.price.text = [NSString stringWithFormat:@"¥%@",model.shangpin.price];
    self.yishou.text =[NSString stringWithFormat:@"一已售%ld",model.shangpin.num];
    self.zhifuqingkuang.text = [NSString stringWithFormat:@"用券可抵扣%@元",model.shangpin.coupons_price];
    //self.dingjianxiangqing.text = [NSString stringWithFormat:@"定金%@元,用券可抵扣%@元",model.baojia.temporarypay,model.baojia.deductible];
    self.name.text = model.user.nickname;
    self.zhiwei.text = nil;// model.user.occupation;
    self.haopinlv.text = [NSString stringWithFormat:@"%ld",model.user.goodscore];
    self.quanbushangshu.text = S_Integer(model.user.allgoods);
    self.fensishu.text = S_Integer(model.user.fans);
    self.address.text = model.user.addr;
    [self.headerimage sd_setImageWithUrl:model.user.head placeHolder:[UIImage imageNamed:@"头像"]];
    
    if (model.user.shiming) {
        self.renzhengImage1.hidden = NO;
        self.renzhengImage1.image = [UIImage imageNamed:@"实名认证1"];
    }else {
        self.renzhengImage1.hidden = YES;
    }
    if (model.user.platform == 1) {
        self.renzhengImage2.hidden = NO;
        self.renzhengImage2.image = [UIImage imageNamed:@"平台认证1"];
    }else {
        self.renzhengImage2.hidden = YES;
    }
    if (model.user.sincerity) {
        self.renzhengImage3.hidden = NO;
        self.renzhengImage3.image = [UIImage imageNamed:@"诚信认证1"];
    }else {
        self.renzhengImage3.hidden = YES;
    }
    
    if (model.user.xueyuan == 6) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh6"];
    }else if (model.user.xueyuan == 7) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh7"];
    }else if (model.user.xueyuan == 8) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh8"];
    }else if (model.user.xueyuan == 9) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh9"];
    }else if (model.user.xueyuan == 10) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh10"];
    }else if (model.user.xueyuan == 11) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh11"];
    }else if (model.user.xueyuan == 12) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh12"];
    }else if (model.user.xueyuan == 13) {
        self.renzhengImage4.image = [UIImage imageNamed:@"1星"];
    }else if (model.user.xueyuan == 14) {
        self.renzhengImage4.image = [UIImage imageNamed:@"2星"];
    }else if (model.user.xueyuan == 15) {
        self.renzhengImage4.image = [UIImage imageNamed:@"3星"];
    }else if (model.user.xueyuan == 16) {
        self.renzhengImage4.image = [UIImage imageNamed:@"4星"];
    }else if (model.user.xueyuan == 17) {
        self.renzhengImage4.image = [UIImage imageNamed:@"5星"];
    }else if (model.user.xueyuan == 18) {
        self.renzhengImage4.image = [UIImage imageNamed:@"6星"];
    }else if (model.user.xueyuan == 19) {
        self.renzhengImage4.image = [UIImage imageNamed:@"7星"];
    }else {
        self.renzhengImage4.hidden = YES;
    }
}

@end
