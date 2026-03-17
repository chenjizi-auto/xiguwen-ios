//
//  LookMingxiNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/27.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "LookMingxiNewTableViewCell.h"

@implementation LookMingxiNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Datamingxilook *)model {
    _model = model;
    self.name.text = model.a;
    self.price.text = [NSString stringWithFormat:@"¥%ld",model.b];
}
@end
