//
//  HunQinThreeTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/7.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "HunQinThreeTableViewCell.h"

@implementation HunQinThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnAction:(UIButton *)sender {
    
    [self.selectItemSubject sendNext:@(sender.tag)];
    
}

@end
