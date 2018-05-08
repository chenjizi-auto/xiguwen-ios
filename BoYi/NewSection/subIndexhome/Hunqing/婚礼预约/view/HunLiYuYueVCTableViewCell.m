//
//  HunLiYuYueVCTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/4.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunLiYuYueVCTableViewCell.h"

@implementation HunLiYuYueVCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.content bottomMargin:10];
}
- (void)setModel:(Guanggaoarray *)model {
    _model = model;
    self.name.text = model.title;
    self.content.text = model.text;
    [self.imagew sd_setImageWithUrl:model.wapimg placeHolder:[UIImage imageNamed:@"占位图片"]];
}
@end
