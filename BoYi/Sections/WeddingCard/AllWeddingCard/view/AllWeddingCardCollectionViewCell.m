//
//  AllWeddingCardCollectionViewCell.m
//  BoYi
//
//  Created by Chen on 2017/9/3.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AllWeddingCardCollectionViewCell.h"

@implementation AllWeddingCardCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AllWeddingCardModel *)model {
    _model = model;
//    if (model.imgcover) {
//        [self.cover sd_setImageWithUrl:ImageAppendURL(model.imgcover)];
//    }
    
    self.name.text = model.name;
}

@end
