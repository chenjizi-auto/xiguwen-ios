//
//  FansTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "FansTableViewCell.h"

@implementation FansTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Fansarrayw *)model {
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = model.nickname;
    self.zhiwei.text = model.occupationid;
    self.address.text = model.diqu;
    [self.guanzhuBtn setImage:[UIImage imageNamed:model.follow == 1 ? @"取消关注" :@"加关注"] forState:UIControlStateNormal];
}
@end
