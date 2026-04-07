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
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 12.0;
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    self.contentView.layer.masksToBounds = YES;
    self.imagew.layer.cornerRadius = 12.0;
    self.imagew.layer.masksToBounds = YES;
}
- (void)setModel:(Baojiashangjiafen *)model{
    _model = model;
    [self.imagew sd_setImageWithUrl:model.imglist placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.name;
    self.price.text = [NSString stringWithFormat:@"¥%@起",model.price];
    self.yishounumber.text = [NSString stringWithFormat:@"已售 %ld",model.num];
}
@end
