//
//  ShangchengFenleiTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/28.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengFenleiTableViewCell.h"

@implementation ShangchengFenleiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Shangchengfenlei *)model {
    _model = model;
    self.name.text = model.wapname;
    self.red.hidden = model.isselete ? NO : YES;
    self.name.textColor = model.isselete ? MAINCOLOR : RGBA(83, 83, 83, 1);
}
@end
