//
//  DongtaiDetilTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "DongtaiDetilTableViewCell.h"

@implementation DongtaiDetilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Zanlist *)model {
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
}
@end
