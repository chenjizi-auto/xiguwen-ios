//
//  AnlieListCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieListCollectionViewCell.h"

@implementation AnlieListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Shangjiatuanduilist *)model {
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = model.nickname;
    self.zhiwei.text = model.occupationid;
    self.price.text = [NSString stringWithFormat:@"¥%ld起",model.zuidijia];
    
    self.pinlunshu.text = [NSString stringWithFormat:@" %ld",model.evaluate];
    self.haopinlv.text = [NSString stringWithFormat:@" %ld%%",model.evaluate];
    self.fensishu.text = [NSString stringWithFormat:@" %ld",model.evaluate];
    if (model.isshopvip == 1) {
        self.isHuiyuan.hidden = NO;
    }else {
        self.isHuiyuan.hidden = YES;
    }
    
    if (model.shiming) {
        self.renzhengImage1.hidden = NO;
        self.renzhengImage1.image = [UIImage imageNamed:@"实名认证1"];
    }else {
        self.renzhengImage1.hidden = YES;
    }
    if (model.platform == 1) {
        self.renzhengImage2.hidden = NO;
        self.renzhengImage2.image = [UIImage imageNamed:@"平台认证1"];
    }else {
        self.renzhengImage2.hidden = YES;
    }
    if (model.sincerity) {
        self.renzhengImage3.hidden = NO;
        self.renzhengImage3.image = [UIImage imageNamed:@"诚信认证1"];
    }else {
        self.renzhengImage3.hidden = YES;
    }
    
    if (model.xueyuan == 6) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh6"];
    }else if (model.xueyuan == 7) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh7"];
    }else if (model.xueyuan == 8) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh8"];
    }else if (model.xueyuan == 9) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh9"];
    }else if (model.xueyuan == 10) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh10"];
    }else if (model.xueyuan == 11) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh11"];
    }else if (model.xueyuan == 12) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh12"];
    }else if (model.xueyuan == 13) {
        self.renzhengImage4.image = [UIImage imageNamed:@"1星"];
    }else if (model.xueyuan == 14) {
        self.renzhengImage4.image = [UIImage imageNamed:@"2星"];
    }else if (model.xueyuan == 15) {
        self.renzhengImage4.image = [UIImage imageNamed:@"3星"];
    }else if (model.xueyuan == 16) {
        self.renzhengImage4.image = [UIImage imageNamed:@"4星"];
    }else if (model.xueyuan == 17) {
        self.renzhengImage4.image = [UIImage imageNamed:@"5星"];
    }else if (model.xueyuan == 18) {
        self.renzhengImage4.image = [UIImage imageNamed:@"6星"];
    }else if (model.xueyuan == 19) {
        self.renzhengImage4.image = [UIImage imageNamed:@"7星"];
    }else {
        self.renzhengImage4.hidden = YES;
    }
}
@end
