//
//  TalkPJTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "TalkPJTableViewCell.h"

@implementation TalkPJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.content bottomMargin:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(EsarraypjPJ *)model{
    _model = model;
    self.name.text = model.name;
    [[NSString stringWithFormat:@"%@",model.imgUrl] isBlankString] ? @"" : [self.image sd_setImageWithUrl:String(ImageHomeURL,model.imgUrl) placeHolder:[UIImage imageNamed:@"头像"]];
    self.time.text = [NSString stringWithFormat:@"%ld",(long)model.createTime.year];
    self.content.text = model.content;
    self.fenshu.text = [NSString stringWithFormat:@"%ld分",(long)model.score];
    self.star.value = model.score;
}

@end
