//
//  MyConcernTableViewCell.m
//  BoYi
//
//  Created by Chen on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyConcernTableViewCell.h"

@implementation MyConcernTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MyConcernModel *)model {
    _model = model;
    [self.cover sd_setImageWithUrl:ImageAppendURL(model.img)];
    self.name.text = model.name;
    self.price.text = [NSString stringWithFormat:@"￥%@",model.price];
    
}

@end
