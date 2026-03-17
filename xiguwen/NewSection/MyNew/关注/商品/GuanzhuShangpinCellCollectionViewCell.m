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
    // Initialization code
}
- (void)setModel:(ShangpingGuanzhuModel *)model{
    _model = model;
    [self.imagew sd_setImageWithUrl:model.shopimg[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    self.price.text = [NSString stringWithFormat:@"%@起",model.price];
    self.yishounumber.text = [NSString stringWithFormat:@"已售 %ld",model.num];
}
@end
