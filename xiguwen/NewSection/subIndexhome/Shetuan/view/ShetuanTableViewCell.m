//
//  ShetuanTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShetuanTableViewCell.h"

@implementation ShetuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Shetuan *)model {
    _model = model;
    [self.headrimage sd_setImageWithUrl:model.logourl placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [NSString stringWithFormat:@"%@",model.name];
    self.type.text = [NSString stringWithFormat:@"%@",model.type];
    self.price.text = [NSString stringWithFormat:@"¥%@起",model.minimumprice];
    self.chengyuan.text = [NSString stringWithFormat:@"成员人数 %ld",model.membersnum];
    self.address.text = [NSString stringWithFormat:@"%@",model.address];
}
@end
