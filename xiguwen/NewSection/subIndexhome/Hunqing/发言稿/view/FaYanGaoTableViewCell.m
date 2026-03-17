//
//  FayangaoTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "FayangaoTableViewCell.h"

@implementation FayangaoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Fayangaoarray *)model {
    _model = model;
    self.title.text = model.title;
//    self.type.text = model.creater;
    self.content.text = model.content;
}
@end
