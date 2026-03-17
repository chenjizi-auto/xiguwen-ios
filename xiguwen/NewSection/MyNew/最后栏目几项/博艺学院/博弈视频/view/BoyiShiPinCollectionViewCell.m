//
//  BoyiShiPinCollectionViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "BoyiShiPinCollectionViewCell.h"

@implementation BoyiShiPinCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)data:(BoyiShiPinModel *)model
{
    [self.BackImage sd_setImageWithUrl:model.cover placeHolder:nil];
    [self.singName setText:model.name];
    [self.comment setText:model.describe];
    self.VipImageView.hidden = model.isvipsee==1?YES:NO;
}
@end
