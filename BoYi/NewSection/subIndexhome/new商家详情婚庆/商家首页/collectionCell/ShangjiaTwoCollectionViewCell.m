//
//  ShangjiaTwoCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaTwoCollectionViewCell.h"

@implementation ShangjiaTwoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Zuopinnewfen *)model{
    _model = model;
    if ([model.type isEqualToString:@"sp"]) {
        self.bofangImage.hidden = NO;
        [self.imagew sd_setImageWithUrl:model.cover placeHolder:[UIImage imageNamed:@"占位图片"]];
        self.name.text = model.title;
        self.jianjie.text = @"";
    }else if ([model.type isEqualToString:@"al"]) {
        self.bofangImage.hidden = YES;
        [self.imagew sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
        self.name.text = model.title;
        self.jianjie.text = model.weddingdescribe;
    }else {
        self.bofangImage.hidden = YES;
        [self.imagew sd_setImageWithUrl:model.cover placeHolder:[UIImage imageNamed:@"占位图片"]];
        self.name.text = model.name;
        self.jianjie.text = model.synopsis;
    }
    self.price.text = [NSString stringWithFormat:@"¥ %ld",model.weddingexpenses];
    self.yishounumber.text = [NSString stringWithFormat:@"浏览量 %ld",model.clicked];
    
}
@end
