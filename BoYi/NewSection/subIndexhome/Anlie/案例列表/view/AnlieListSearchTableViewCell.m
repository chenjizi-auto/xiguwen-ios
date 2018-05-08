//
//  AnlieListSearchTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/27.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieListSearchTableViewCell.h"

@implementation AnlieListSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   // [self setupAutoHeightWithBottomView:self.btoView bottomMargin:0];
}
- (void)setModel:(Anlielistsearcharray *)model {
    _model = model;
    [self.bigImage sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
    [self.headrImage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    if (model.follow == 1) {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
    }else {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];
        
    }
    self.qianming.text = model.title;
    self.price.text = [NSString stringWithFormat:@"¥%ld",model.weddingexpenses];
    self.jianjie.text = model.weddingdescribe;
    self.liulanNumber.text = [NSString stringWithFormat:@"%ld",model.followed];
    self.guanzhuNumber.text = [NSString stringWithFormat:@"%ld",model.clicked];
    self.pinglunNumber.text = [NSString stringWithFormat:@"%ld",model.commented];
}
@end
