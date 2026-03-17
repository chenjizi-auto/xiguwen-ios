//
//  MyConcernShopTableViewCell.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyConcernShopTableViewCell.h"

@implementation MyConcernShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(MyConcernModel *)model {
    _model = model;
    
    [self.cover sd_setImageWithUrl:ImageAppendURL(model.img)];
    self.name.text = model.name;
    self.zhiwei.text = model.occupation;
    
    self.price.text = [NSString stringWithFormat:@"￥%@",model.price];
//    self.starView.value = 5 * model.star.floatValue / 100;
   
}

@end
