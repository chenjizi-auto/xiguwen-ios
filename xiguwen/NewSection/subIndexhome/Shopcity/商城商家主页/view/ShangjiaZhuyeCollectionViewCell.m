//
//  ShangjiaZhuyeCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangjiaZhuyeCollectionViewCell.h"

@implementation ShangjiaZhuyeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Shopshangchengsj *)model{
    _model = model;
    if (model.shopimg.count > 0) {
        [self.imagew sd_setImageWithUrl:model.shopimg[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    }
    
    self.name.text = model.shopname;
    self.price.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.yishou.text = [NSString stringWithFormat:@"已售%ld",model.saled];
}

@end
