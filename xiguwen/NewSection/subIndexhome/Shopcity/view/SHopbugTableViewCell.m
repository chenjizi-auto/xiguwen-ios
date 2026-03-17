//
//  SHopbugTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SHopbugTableViewCell.h"

@implementation SHopbugTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

- (IBAction)actionall:(UIButton *)sender {
    [self.gotoNextVc sendNext:@(sender.tag)];
}

- (void)setModel:(ShopcityModel *)model {
    _model = model;
    [self.image1 sd_setImageWithUrl:(model.youhaohuo.wapimg)];
    [self.image2 sd_setImageWithUrl:(model.bimai.rmhd1.wapimg)];
    [self.image3 sd_setImageWithUrl:(model.bimai.rmhd2.wapimg)];
    [self.image4 sd_setImageWithUrl:(model.bimai.rmhd3.wapimg)];
    [self.iamge5 sd_setImageWithUrl:(model.bimai.rmhd4.wapimg)];
    [self.image6 sd_setImageWithUrl:(model.bimai.rmhd5.wapimg)];
    
}
@end
