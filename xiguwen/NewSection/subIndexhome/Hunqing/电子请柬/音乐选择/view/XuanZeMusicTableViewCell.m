//
//  XuanZeMusicTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/31.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "XuanZeMusicTableViewCell.h"

@implementation XuanZeMusicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(MusicModel *)model {
    _model = model;
    self.name.text = model.titile;
    self.gouImage.hidden = model.isSele ? NO : YES;
}
@end
