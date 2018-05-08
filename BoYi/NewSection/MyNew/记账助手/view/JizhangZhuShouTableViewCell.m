//
//  JizhangZhuShouTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "JizhangZhuShouTableViewCell.h"

@implementation JizhangZhuShouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Tianjizhang *)model {
    _model = model;
    self.imagew.image = [UIImage imageNamed:model.type == 1 ? @"支出":@"收入"];
    self.name.text = model.remarks;
    if (model.type == 1) {
        self.mingxi.text = [NSString stringWithFormat:@"-%ld",model.aftermoney];
    }else {
        self.mingxi.text = [NSString stringWithFormat:@"%ld",model.aftermoney];
    }
    
}
@end
