//
//  TypeCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "TypeCollectionViewCell.h"

@implementation TypeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (IS_IPHONE_5) {
        self.weight.constant = 60;
    }
}

@end
