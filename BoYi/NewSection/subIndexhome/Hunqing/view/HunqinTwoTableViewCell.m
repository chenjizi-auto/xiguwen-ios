//
//  HunqinTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/7.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "HunqinTwoTableViewCell.h"

@implementation HunqinTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)action:(UIButton *)sender {
    [self.selectItemSubject sendNext:@(sender.tag)];
}
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
@end
