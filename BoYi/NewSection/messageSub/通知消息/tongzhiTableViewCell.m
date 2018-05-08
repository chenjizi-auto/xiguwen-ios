//
//  tongzhiTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "tongzhiTableViewCell.h"

@implementation tongzhiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.btmView bottomMargin:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Conttongzhi *)model{
    _model = model;
    self.istype.text = model.titleb;
    self.name.text = model.titlea;
    self.content.text = model.cont;
    self.time.text = model.createtime;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    [self.imagetwo sd_setImageWithUrl:model.img placeHolder:[UIImage imageNamed:@"占位图片"]];
}
@end
