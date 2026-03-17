//
//  ZiliaoNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/20.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "ZiliaoNewTableViewCell.h"

@implementation ZiliaoNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(shangjiaZiliaoModel *)model {
    _model = model;
    self.sex.text = model.sex;
    self.iphone.text = model.mobile;
    self.city.text = model.sex;
    self.introLab.text = model.smalltext;
    self.bianhao.text = [NSString stringWithFormat:@"%ld",model.userid];
    
    if (model.age == 0) {
        self.age.text = @"暂无资料";
    }else {
        self.age.text = [NSString stringWithFormat:@"%ld岁",model.age];
    }
    if (model.height == 0) {
        self.height.text = @"暂无资料";
    }else {
        self.height.text = [NSString stringWithFormat:@"%ldcm",model.height];
    }
    if (model.weight == 0) {
        self.weight.text = @"暂无资料";
    }else {
        self.weight.text = [NSString stringWithFormat:@"%ldcm",model.weight];
    }
    
    
    
    
}
@end
