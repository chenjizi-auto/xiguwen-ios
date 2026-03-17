//
//  NewTalkTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewTalkTableViewCell.h"

@implementation NewTalkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.content bottomMargin:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(EvaluationManagementModel *)model{
    _model = model;
    [self.header sd_setImageWithUrl:String(ImageHomeURL,model.bizCover) placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.businessName;
    self.content.text = model.customCommont;
    self.time.text = [NSDate dateWithTimeIntervalSince1970:model.evaluationTime.millis/1000].fs_string;
    self.fenshu.text = [NSString stringWithFormat:@"%ld分",(long)model.customStar];
    self.star.value = model.customStar;
    
}


@end
