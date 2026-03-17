//
//  FuWuCityMyTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/20.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "FuWuCityMyTableViewCell.h"

@implementation FuWuCityMyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(FuWuCityMyModel *)model {
    _model = model;
	[self.titleLabel setText:[NSString stringWithFormat:@"%@-%@",model.province,model.city]];
}
@end
