//
//  ShangjiaoneCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaoneCollectionViewCell.h"

@implementation ShangjiaoneCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Baojiashangjiafen *)model{
    _model = model;
    [self.imagew sd_setImageWithUrl:model.imglist placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.name;
    self.price.text = [NSString stringWithFormat:@"¥%@起",model.price];
    self.yishounumber.text = [NSString stringWithFormat:@"已售 %ld",model.num];
}
@end
