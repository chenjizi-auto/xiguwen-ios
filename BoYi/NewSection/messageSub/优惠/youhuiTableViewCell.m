//
//  youhuiTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "youhuiTableViewCell.h"

@implementation youhuiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Contyouhui *)model{
    _model = model;

    self.name.text = model.title;
    self.content.text = model.content;
    self.time.text = model.createtime;
    [self.headerimage sd_setImageWithUrl:model.img placeHolder:[UIImage imageNamed:@"占位图片"]];
}
@end
