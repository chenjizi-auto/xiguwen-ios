//
//  MyBanksTableViewCell.m
//  BoYi
//
//  Created by Chen on 2017/9/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyBanksTableViewCell.h"

@implementation MyBanksTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GetMoneyModel *)model {
    _model = model;
    self.name.text = model.cardname;
    self.bankNo.text = model.cardnumber;
}
@end
