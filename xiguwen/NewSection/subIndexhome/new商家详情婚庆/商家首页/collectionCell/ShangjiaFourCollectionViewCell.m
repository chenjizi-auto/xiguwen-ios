//
//  ShangjiaFourCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaFourCollectionViewCell.h"

@implementation ShangjiaFourCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(teamWU *)model{
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    self.price.text = [NSString stringWithFormat:@" %ld起  ",model.zuidiqijia];
    self.zhiwei.text = model.occupationid;
}

@end
