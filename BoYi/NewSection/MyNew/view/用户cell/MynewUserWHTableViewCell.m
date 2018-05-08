//
//  MynewUserWHTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MynewUserWHTableViewCell.h"

@implementation MynewUserWHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)action:(UIButton *)sender {
    [self.gotoNextVc sendNext:@(sender.tag)];
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
