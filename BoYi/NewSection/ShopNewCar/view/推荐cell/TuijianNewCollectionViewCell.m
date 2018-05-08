//
//  TuijianNewCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "TuijianNewCollectionViewCell.h"

@implementation TuijianNewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ShopCarTuiJian *)model {
    _model = model;
    
    [self.cover sd_setImageWithURL:[NSURL URLWithString:model.head]];
    self.name.text = model.nickname;
    self.occupation.text = model.occupationid;
    self.price.text = [NSString stringWithFormat:@"￥%@起",model.zuidijia];
    self.evaluateLabel.text = S_Integer(model.evaluate);
    self.fans.text = S_Integer(model.fans);
    
    
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
