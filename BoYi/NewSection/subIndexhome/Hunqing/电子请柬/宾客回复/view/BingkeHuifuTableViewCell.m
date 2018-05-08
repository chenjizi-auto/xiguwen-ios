//
//  BingkeHuifuTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "BingkeHuifuTableViewCell.h"

@implementation BingkeHuifuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.content bottomMargin:5];
}
- (void)setModel:(Zhufu *)model {
    _model = model;
    self.name.text = model.name;
    self.time.text = model.createti;
    self.content.text = model.zhufu;
}
@end
