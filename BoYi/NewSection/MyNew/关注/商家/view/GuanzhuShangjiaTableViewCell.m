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
    // Initialization code
}
- (void)setModel:(ShangjiaGuanzhuModel *)model {
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;

    self.zhiwei.text = model.occupationid;
    self.address.text = model.address;

}
@end
