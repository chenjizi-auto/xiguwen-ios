//
//  CostTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "CostTableViewCell.h"

@implementation CostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(RowsGB *)model{
    _model = model;
    self.name.text = model.name;
    self.number.text = [NSString stringWithFormat:@"%ld",model.money];
}

@end
