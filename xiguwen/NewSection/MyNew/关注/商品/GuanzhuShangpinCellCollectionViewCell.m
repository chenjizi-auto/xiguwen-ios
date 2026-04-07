//
//  GuanzhuShangpinCellCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanzhuShangpinCellCollectionViewCell.h"

@implementation GuanzhuShangpinCellCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
    self.cardView.layer.cornerRadius = 10.0;
    self.cardView.layer.masksToBounds = YES;
    self.imagew.layer.cornerRadius = 10.0;
    self.imagew.layer.masksToBounds = YES;
}
- (void)setModel:(ShangpingGuanzhuModel *)model{
    _model = model;
    [self.imagew sd_setImageWithUrl:model.shopimg[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    self.price.text = [NSString stringWithFormat:@"%@起",model.price];
    self.yishounumber.text = [NSString stringWithFormat:@"已售 %ld",model.num];
}
@end
