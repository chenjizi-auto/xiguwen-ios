//
//  NewOneTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewOneTableViewCell.h"

@implementation NewOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.markView bottomMargin:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(peopleDetailModel *)model{
    _model = model;
    self.shopWords.text = [String(@"",model.user.descn) isBlankString] ? @"暂无介绍" : model.user.descn;
    self.fuwuWords.text = [String(@"",model.user.tagNames) isBlankString] ? @"暂无介绍" : model.user.tagNames;
}

@end
