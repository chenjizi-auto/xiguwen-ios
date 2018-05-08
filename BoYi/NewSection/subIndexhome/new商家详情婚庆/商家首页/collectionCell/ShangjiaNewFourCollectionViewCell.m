//
//  ShangjiaNewFourCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/22.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaNewFourCollectionViewCell.h"

@implementation ShangjiaNewFourCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Tuijiantd *)model{
    _model = model;
    [self.imagew sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    self.price.text = [NSString stringWithFormat:@" %@起 ",model.zuidijia];
    self.zhiwei.text = model.occupation;
}
@end
