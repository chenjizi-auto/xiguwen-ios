//
//  DianziQingjianCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "DianziQingjianCollectionViewCell.h"

@implementation DianziQingjianCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.image.layer.cornerRadius = 6.0;
    self.image.layer.masksToBounds = YES;
    self.image.contentMode = UIViewContentModeScaleAspectFill;
}

@end
