//
//  ZuopinOneTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ZuopinOneTableViewCell.h"

@implementation ZuopinOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Chuangshirenzuopin *)model{
    _model = model;
    [self.image sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = [NSString stringWithFormat:@"%@",model.title];
    self.content.text = [NSString stringWithFormat:@"%@",model.weddingdescribe];
    self.price.text = [NSString stringWithFormat:@"¥%ld起",model.weddingexpenses];
}

@end
