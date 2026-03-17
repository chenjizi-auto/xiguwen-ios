//
//  YaoQingNewchengyuanTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "YaoQingNewchengyuanTableViewCell.h"

@implementation YaoQingNewchengyuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
	[self.inviteBtn.layer setCornerRadius:2.0f];
	[self.inviteBtn.layer setMasksToBounds:YES];
	[self.inviteBtn.layer setBorderColor:UIColorFromRGB(0xFF7299).CGColor];
	[self.inviteBtn.layer setBorderWidth:0.5f];
}
- (void)setModel:(YaoQingNewchengyuanModel *)model {
    _model = model;
	[self.headerImg sd_setImageWithUrl:model.head];
	[self.nameLabel setText:model.nickname];
	[self.typeLabel setText:model.occupationid];
//	[self.phoneLabel setText:[model.mobile stringByReplacingOccurrencesOfString:[model.mobile substringWithRange:NSMakeRange(3, 4)] withString:@"****"]];
	[self.phoneLabel setText:model.mobile];
}

- (IBAction)inviteBtnClick:(UIButton *)sender {
	self.onDidinvite();
}


@end
