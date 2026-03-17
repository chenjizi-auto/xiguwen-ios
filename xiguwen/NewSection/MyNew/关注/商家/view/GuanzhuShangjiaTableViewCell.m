//
//  GuanzhuShangjiaTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanzhuShangjiaTableViewCell.h"

@implementation GuanzhuShangjiaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerimage.layer.masksToBounds = YES;
    self.headerimage.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headerimage.layer.cornerRadius = CGRectGetHeight(self.headerimage.bounds) / 2.0;
}
- (void)setModel:(ShangjiaGuanzhuModel *)model {
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = model.nickname;

    self.zhiwei.text = model.occupationid;
    self.address.text = model.address;

}
@end
