//
//  DopTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "DopTableViewCell.h"

@implementation DopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Fenleiarray *)model{
    _model = model;
    self.name.text = model.proname;
    self.gouxuanImage.hidden = model.isSelete ? NO : YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
