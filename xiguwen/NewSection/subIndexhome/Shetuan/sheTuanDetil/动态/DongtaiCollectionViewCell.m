//
//  DongtaiCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/15.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "DongtaiCollectionViewCell.h"

@implementation DongtaiCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.image.layer.cornerRadius = 6.0;
    self.image.layer.masksToBounds = YES;
    self.image.contentMode = UIViewContentModeScaleAspectFill;
}

@end
