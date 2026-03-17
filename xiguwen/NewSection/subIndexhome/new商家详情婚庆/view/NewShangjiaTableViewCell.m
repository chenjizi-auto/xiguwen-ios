//
//  NewShangjiaTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/21.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewShangjiaTableViewCell.h"

@implementation NewShangjiaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(NewShangjiaModel *)model {
    _model = model;
//    [self.fengmianImage sd_setImageWithUrl:model.userinfo.background placeHolder:[UIImage imageNamed:@"婚庆商家背景缺省图"]];
    SDWebImageOptions options = 0;
    [self.fengmianImage sd_setImageWithURL:[NSURL URLWithString:model.userinfo.background] placeholderImage:IMAGE_NAME(@"婚庆商家背景缺省图") options:options];
    [self.headerImage sd_setImageWithUrl:model.user.head placeHolder:[UIImage imageNamed:@"头像"]];
    
    
    self.name.text = model.user.nickname;
    if (![NSStringFormatter(model.userinfo.association) isBlankString]) {
        self.ruanduimingcheng.text = model.userinfo.association;
    }else {
        self.ruanduimingcheng.text = @"";
    }
    self.liulanshuliang.text = [NSString stringWithFormat:@"浏览 %ld",model.user.pv];
    self.chengjiaoshuliang.text = [NSString stringWithFormat:@"成交 %ld",model.user.num];
    self.haopinshuliang.text = [NSString stringWithFormat:@"好评 %ld",model.user.score];
    self.fansnumber.text = [NSString stringWithFormat:@"粉丝 %ld",model.user.fans];
    
    self.address.text = model.userinfo.dizhi;
    
    if (model.userinfo.shiming) {
        self.renzhengImage1.hidden = NO;
        self.renzhengImage1.image = [UIImage imageNamed:@"实名认证1"];
    }else {
        self.renzhengImage1.hidden = YES;
    }
    if (model.userinfo.platform == 1) {
        self.renzhengImage2.hidden = NO;
        self.renzhengImage2.image = [UIImage imageNamed:@"平台认证1"];
    }else {
        self.renzhengImage2.hidden = YES;
    }
    if (model.userinfo.sincerity) {
        self.renzhengImage3.hidden = NO;
        self.renzhengImage3.image = [UIImage imageNamed:@"诚信认证1"];
    }else {
        self.renzhengImage3.hidden = YES;
    }
    
    if (model.userinfo.xueyuan == 6) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh6"];
    }else if (model.userinfo.xueyuan == 7) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh7"];
    }else if (model.userinfo.xueyuan == 8) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh8"];
    }else if (model.userinfo.xueyuan == 9) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh9"];
    }else if (model.userinfo.xueyuan == 10) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh10"];
    }else if (model.userinfo.xueyuan == 11) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh11"];
    }else if (model.userinfo.xueyuan == 12) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh12"];
    }else if (model.userinfo.xueyuan == 13) {
        self.renzhengImage4.image = [UIImage imageNamed:@"1星"];
    }else if (model.userinfo.xueyuan == 14) {
        self.renzhengImage4.image = [UIImage imageNamed:@"2星"];
    }else if (model.userinfo.xueyuan == 15) {
        self.renzhengImage4.image = [UIImage imageNamed:@"3星"];
    }else if (model.userinfo.xueyuan == 16) {
        self.renzhengImage4.image = [UIImage imageNamed:@"4星"];
    }else if (model.userinfo.xueyuan == 17) {
        self.renzhengImage4.image = [UIImage imageNamed:@"5星"];
    }else if (model.userinfo.xueyuan == 18) {
        self.renzhengImage4.image = [UIImage imageNamed:@"6星"];
    }else if (model.userinfo.xueyuan == 19) {
        self.renzhengImage4.image = [UIImage imageNamed:@"7星"];
    }else {
        self.renzhengImage4.hidden = YES;
    }
    
    
    //标志
    if ([model.user.xinyu.a isEqualToString:@"q"]) {
        self.huang1.image = [UIImage imageNamed:@"旗子"];
        self.huang2.image = [UIImage imageNamed:@"旗子"];
        self.huang3.image = [UIImage imageNamed:@"旗子"];
        self.huang4.image = [UIImage imageNamed:@"旗子"];
        self.huang5.image = [UIImage imageNamed:@"旗子"];
    }
    if ([model.user.xinyu.a isEqualToString:@"x"]) {
        self.huang1.image = [UIImage imageNamed:@"星"];
        self.huang2.image = [UIImage imageNamed:@"星"];
        self.huang3.image = [UIImage imageNamed:@"星"];
        self.huang4.image = [UIImage imageNamed:@"星"];
        self.huang5.image = [UIImage imageNamed:@"星"];
    }
    if ([model.user.xinyu.a isEqualToString:@"z"]) {
        self.huang1.image = [UIImage imageNamed:@"钻石"];
        self.huang2.image = [UIImage imageNamed:@"钻石"];
        self.huang3.image = [UIImage imageNamed:@"钻石"];
        self.huang4.image = [UIImage imageNamed:@"钻石"];
        self.huang5.image = [UIImage imageNamed:@"钻石"];
    }
    if ([model.user.xinyu.a isEqualToString:@"h"]) {
        self.huang1.image = [UIImage imageNamed:@"皇冠"];
        self.huang2.image = [UIImage imageNamed:@"皇冠"];
        self.huang3.image = [UIImage imageNamed:@"皇冠"];
        self.huang4.image = [UIImage imageNamed:@"皇冠"];
        self.huang5.image = [UIImage imageNamed:@"皇冠"];
    }
    if ([model.user.xinyu.a isEqualToString:@"j"]) {
        self.huang1.image = [UIImage imageNamed:@"至尊"];
        self.huang2.image = [UIImage imageNamed:@"至尊"];
        self.huang3.image = [UIImage imageNamed:@"至尊"];
        self.huang4.image = [UIImage imageNamed:@"至尊"];
        self.huang5.image = [UIImage imageNamed:@"至尊"];
    }
    if ([model.user.xinyu.b integerValue] == 0) {
        self.huang1.hidden = YES;
        self.huang2.hidden = YES;
        self.huang3.hidden = YES;
        self.huang4.hidden = YES;
        self.huang5.hidden = YES;
    }else if ([model.user.xinyu.b integerValue] == 1){
        self.huang1.hidden = NO;
        self.huang2.hidden = YES;
        self.huang3.hidden = YES;
        self.huang4.hidden = YES;
        self.huang5.hidden = YES;
        
    }else if ([model.user.xinyu.b integerValue] == 2){
        self.huang1.hidden = NO;
        self.huang2.hidden = NO;
        self.huang3.hidden = YES;
        self.huang4.hidden = YES;
        self.huang5.hidden = YES;
        self.weiyi.constant = - 15;
    }else if ([model.user.xinyu.b integerValue] == 3){
        self.huang1.hidden = NO;
        self.huang2.hidden = NO;
        self.huang3.hidden = NO;
        self.huang4.hidden = YES;
        self.huang5.hidden = YES;
    }else if ([model.user.xinyu.b integerValue] == 4){
        self.huang1.hidden = NO;
        self.huang2.hidden = NO;
        self.huang3.hidden = NO;
        self.huang4.hidden = NO;
        self.huang5.hidden = YES;
        self.weiyi.constant = - 15;
    }else {
        self.huang1.hidden = NO;
        self.huang2.hidden = NO;
        self.huang3.hidden = NO;
        self.huang4.hidden = NO;
        self.huang5.hidden = NO;
    }
}
@end
