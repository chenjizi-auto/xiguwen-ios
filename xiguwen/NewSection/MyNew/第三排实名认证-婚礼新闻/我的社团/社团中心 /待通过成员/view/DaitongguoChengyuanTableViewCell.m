//
//  DaitongguoChengyuanTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "DaitongguoChengyuanTableViewCell.h"

@implementation DaitongguoChengyuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	[self.agreeBtn.layer setCornerRadius:2.0f];
	[self.agreeBtn.layer setMasksToBounds: YES];
	
	[self.refuseBtn.layer setCornerRadius:2.0f];
	[self.refuseBtn.layer setMasksToBounds: YES];
	[self.refuseBtn.layer setBorderColor:UIColorFromRGB(0xFF7299).CGColor];
	[self.refuseBtn.layer setBorderWidth:0.5f];
	
}
- (void)setModel:(DaitongguoChengyuanModel *)model {
    _model = model;
	
	[self.headerImg sd_setImageWithUrl:model.head];
	[self.nameLabel setText:model.nickname];
	[self.typeLabel setText:model.occupationid];
	[self.addressLabel setText:model.dizhi];
}

- (IBAction)agreeBtnClick:(UIButton *)sender {
	self.onDidAgree(YES);
}
- (IBAction)refuseBtnClick:(UIButton *)sender {
	self.onDidAgree(NO);
}


@end
