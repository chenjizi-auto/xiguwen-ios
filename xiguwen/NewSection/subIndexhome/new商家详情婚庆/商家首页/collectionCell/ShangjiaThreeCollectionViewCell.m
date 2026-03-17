//
//  ShangjiaThreeCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaThreeCollectionViewCell.h"

@implementation ShangjiaThreeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imagew.layer.cornerRadius = 6.0;
    self.imagew.layer.masksToBounds = YES;
}

@end
