//
//  OneTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "OneTableViewCell.h"


@implementation OneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.lookBtn bottomMargin:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(FindXinXiModel *)model{
    _model = model;
    self.content.text = model.caseComment;
    self.piace.text =[NSString stringWithFormat:@"¥  %@", model.caseDetail];
    
    
}


@end
