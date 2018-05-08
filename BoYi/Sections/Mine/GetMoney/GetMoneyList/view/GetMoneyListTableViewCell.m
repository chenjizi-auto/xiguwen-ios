//
//  GetMoneyListTableViewCell.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "GetMoneyListTableViewCell.h"

@implementation GetMoneyListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GetMoneyListModel *)model {
    _model = model;
    self.name.text = @" ";
    self.money.text = [NSString stringWithFormat:@"￥%@",model.money];
    self.date.text = model.createtime;
    
    switch (model.status.integerValue) {
        case 1:
            self.status.text = @"提现成功";
            break;
        case 2:
            self.status.text = @"处理中";
            break;
            
        default:
            self.status.text = @"不同意";
            break;
    }
    
}
@end
