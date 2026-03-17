//
//  ShangChengListnCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/28.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangChengListnCollectionViewCell.h"

@implementation ShangChengListnCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(Shopnew *)model{
    _model = model;    
    self.name.text = model.shopname;
    if (model.shopimg.count > 0) {
        [self.imagew sd_setImageWithUrl:model.shopimg[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    }
    self.price.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.yishou.text = [NSString stringWithFormat:@"已售%ld",model.saled];
}
@end
