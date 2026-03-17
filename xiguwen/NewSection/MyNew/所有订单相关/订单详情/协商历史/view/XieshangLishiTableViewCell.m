//
//  XieshangLishiTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "XieshangLishiTableViewCell.h"

@implementation XieshangLishiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.btmview bottomMargin:0];
}
- (void)setModel:(Xieshangarray *)model {
    _model = model;
    [self.header sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    self.time.text = model.times;
    self.content.text = model.text;
}
@end
