//
//  LookWuliuTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "LookWuliuTableViewCell.h"

@implementation LookWuliuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Traces *)model{
    _model = model;
    self.ri.text = [model.AcceptTime substringWithRange:NSMakeRange(5, 5)];
    self.shi.text = [model.AcceptTime substringWithRange:NSMakeRange(11, 5)];
    self.content.text = model.AcceptStation;
}

@end
