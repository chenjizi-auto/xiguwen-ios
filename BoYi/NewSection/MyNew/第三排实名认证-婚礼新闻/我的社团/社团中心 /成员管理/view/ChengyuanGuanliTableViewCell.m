//
//  ChengyuanGuanliTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChengyuanGuanliTableViewCell.h"

@implementation ChengyuanGuanliTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	[self.roleBtn.layer setCornerRadius:2.0f];
	[self.roleBtn.layer setMasksToBounds:YES];
	[self.roleBtn.layer setBorderColor:UIColorFromRGB(0xFF7299).CGColor];
	[self.roleBtn.layer setBorderWidth:0.5f];
}
- (void)setModel:(ChengyuanGuanliModel *)model {
    _model = model;
	[self.coverImg sd_setImageWithUrl:model.head];
	[self.nameLabel setText:model.nickname];
	[self.typeLabel setText:model.occupationid];
	[self.addressLabel setText:model.dizhi];
	// 设置角色按钮
	if (model.jiaose == 1) {
		[self.roleBtn setHidden: YES];
	} else if (model.jiaose == 2) {
		[self.roleBtn setTitle:@"取消管理员" forState:(UIControlStateNormal)];
		[self.roleBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
		[self.roleBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
	} else {
		[self.roleBtn setTitle:@"设为管理员" forState:(UIControlStateNormal)];
		[self.roleBtn setTitleColor:UIColorFromRGB(0xFF7299) forState:(UIControlStateNormal)];
		[self.roleBtn setBackgroundColor:[UIColor whiteColor]];
	}
}

- (IBAction)setStatus:(UIButton *)sender {
	self.onDidSetStatus();
}


@end
