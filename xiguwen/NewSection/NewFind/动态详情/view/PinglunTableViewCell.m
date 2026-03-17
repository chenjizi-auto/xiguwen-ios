//
//  PinglunTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "PinglunTableViewCell.h"

@implementation PinglunTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.jianjie bottomMargin:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(CommentlistDongtai *)model{
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    self.time.text = model.create_ti;
    self.jianjie.text = model.comm;
    
}
@end
