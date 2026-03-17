//
//  HeaderNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HeaderNewTableViewCell.h"

@implementation HeaderNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerImage.layer.cornerRadius = 30;
    self.headerImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
