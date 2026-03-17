//
//  ZuopinNewCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ZuopinNewCollectionViewCell.h"

@implementation ZuopinNewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Chengyuanzuopin *)model{
    _model = model;
    [self.image sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = [NSString stringWithFormat:@"%@",model.title];
    self.content.text = [NSString stringWithFormat:@"%@",model.weddingdescribe];
    self.price.text = [NSString stringWithFormat:@"¥%ld起",model.weddingexpenses];
}
@end
