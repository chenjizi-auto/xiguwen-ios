//
//  MyNewshangjiaCellTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/4/25.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewshangjiaCellTwoTableViewCell.h"

@implementation MyNewshangjiaCellTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)alletion:(UIButton *)sender {
    
    [self.gotoNextVc sendNext:@(sender.tag)];
    
    
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

@end
