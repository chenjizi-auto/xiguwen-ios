//
//  ShetuanDetilTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShetuanDetilTableViewCell.h"

@implementation ShetuanDetilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ShetuanDetilModel *)model {
    _model = model;
    [self.beijingimage sd_setImageWithUrl:model.info.appphotourl placeHolder:[UIImage imageNamed:@"占位图片"]];
    [self.headerimage sd_setImageWithUrl:model.info.logourl placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [NSString stringWithFormat:@"%@",model.info.name];
    self.address.text = [NSString stringWithFormat:@"%@",model.info.address];
    self.liulanNUmber.text = [NSString stringWithFormat:@"浏览 %ld",model.info.clicked];
}
@end
