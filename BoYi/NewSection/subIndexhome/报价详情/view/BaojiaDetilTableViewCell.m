//
//  BaojiaDetilTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/23.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "BaojiaDetilTableViewCell.h"

@implementation BaojiaDetilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(BaojiaDetilModel *)model {
    _model = model;
    if (model.baojia.imglist.count > 0) {
        [self.fengmianImage sd_setImageWithUrl:model.baojia.imglist[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    }
    self.title.text = model.baojia.name;
    self.price.text = [NSString stringWithFormat:@"¥%@",model.baojia.price];
    self.yishou.text = [NSString stringWithFormat:@"已售%ld单",model.baojia.num];
    self.dingjianxiangqing.text = [NSString stringWithFormat:@"定金%@元,用券可抵扣%@元",model.baojia.temporarypay,model.baojia.deductible];
    self.name.text = model.user.nickname;
    self.zhiqwei.text = model.user.occupation;
    self.name.text = model.user.nickname;
    self.name.text = model.user.nickname;
    
    self.address.text = model.user.addr;
    [self.headerImage sd_setImageWithUrl:model.user.head placeHolder:[UIImage imageNamed:@"头像"]];
    
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
    
    self.pinglunshuliang.text = [NSString stringWithFormat:@"%ld",model.user.evaluate];
    self.fensishuliang.text = [NSString stringWithFormat:@"%ld",model.user.fans];
    self.haopinshuliang.text = [NSString stringWithFormat:@"%ld%%",model.user.goodscore];
}
@end
