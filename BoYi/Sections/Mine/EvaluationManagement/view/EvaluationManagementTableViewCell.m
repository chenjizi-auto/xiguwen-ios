//
//  EvaluationManagementTableViewCell.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "EvaluationManagementTableViewCell.h"

@implementation EvaluationManagementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(EvaluationManagementModel *)model {
    _model = model;
    
    
    [self.header sd_setImageWithUrl:ImageAppendURL(model.bizCover)];
    self.name.text = model.businessName;
    self.date.text = [NSDate dateWithTimeIntervalSince1970:model.evaluationTime.millis/1000].fs_string;
    self.content.text = model.customCommont;
    self.starValue.text = [NSString stringWithFormat:@"%ld分",model.customStar];
    self.starView.value = model.customStar;
    
}
@end
