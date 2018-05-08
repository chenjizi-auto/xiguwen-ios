//
//  HunqinNineTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/29.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinNineTableViewCell.h"

@implementation HunqinNineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.btmView bottomMargin:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Youlike *)model{
    _model = model;
    [self.bigImage sd_setImageWithUrl:model.shopimg placeHolder:[UIImage imageNamed:@"占位图片"]];
    [self.headrImage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    if (model.follow == 1) {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
    }else {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];
        
    }
    self.qianming.text = model.title;
    self.price.text = [NSString stringWithFormat:@"¥%@",model.price];

    self.liulanNumber.text = [NSString stringWithFormat:@"%ld",model.followed];
    self.guanzhuNumber.text = [NSString stringWithFormat:@"%ld",model.clicked];
    self.pinglunNumber.text = [NSString stringWithFormat:@"%ld",model.pinluns];
    self.occupationid.text = model.occupationid;
}
@end
