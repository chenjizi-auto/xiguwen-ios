//
//  TuijianTuanduiMyTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "TuijianTuanduiMyTableViewCell.h"

@implementation TuijianTuanduiMyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(TuijianTuanduiMyModel *)model {
    _model = model;
	[self.serialLabel setText: model.shopcode];
	[self.nameLabel setText: model.nickname];
	[self.weightLabel setText:[NSString stringWithFormat: @"%ld",model.weight]];
}
@end
