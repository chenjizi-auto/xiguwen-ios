//
//  JoinSheTuanTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/16.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "JoinSheTuanTableViewCell.h"

@implementation JoinSheTuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
	[self.joinBtn.layer setCornerRadius:2.0f];
	[self.joinBtn.layer setMasksToBounds:YES];
	[self.joinBtn.layer setBorderColor:UIColorFromRGB(0xFC5887).CGColor];
	[self.joinBtn.layer setBorderWidth:0.5f];
	
	[self.refusedBtn.layer setCornerRadius:2.0f];
	[self.refusedBtn.layer setMasksToBounds:YES];
	[self.refusedBtn.layer setBorderColor:UIColorFromRGB(0xFC5887).CGColor];
	[self.refusedBtn.layer setBorderWidth:0.5f];
}
- (void)setModel:(Shetuan *)model {
    _model = model;
	[self.coverImg sd_setImageWithUrl:model.logourl];
	[self.nameLabel setText:model.name];
	[self.typeLabel setText:model.type];
	[self.memberLabel setText:[NSString stringWithFormat:@"成员  %ld",model.renshu]];
	[self.addressLabel setText:model.addressd];
	
	if (model.status == 0) {
		// 可加入
		[self.joinBtn setTitle:@"申请加入" forState:(UIControlStateNormal)];
		[self.joinBtn setTitleColor:UIColorFromRGB(0xFC5887) forState:(UIControlStateNormal)];
		[self.joinBtn setUserInteractionEnabled:YES];
	} else if (model.status == 1) {
		// 可退出
		[self.joinBtn setTitle:@"退出社团" forState:(UIControlStateNormal)];
		[self.joinBtn setTitleColor:UIColorFromRGB(0xFC5887) forState:(UIControlStateNormal)];
		[self.joinBtn setUserInteractionEnabled:YES];
	} else if (model.status == 3) {
		// 已经同意加入(受到邀请)
		[self.joinBtn setTitle:@"同意加入" forState:(UIControlStateNormal)];
		[self.joinBtn setTitleColor:UIColorFromRGB(0xFC5887) forState:(UIControlStateNormal)];
		[self.joinBtn setUserInteractionEnabled:YES];
	} else if (model.status == 4) {
		// 等待加入
		[self.joinBtn setTitle:@"等待同意" forState:(UIControlStateNormal)];
		[self.joinBtn setTitleColor:UIColorFromRGB(0xFC5887) forState:(UIControlStateNormal)];
		[self.joinBtn setUserInteractionEnabled:NO];
	}
	
	if (model.status == 3) {
		[self.refusedBtn setHidden: NO];
	} else {
		[self.refusedBtn setHidden: YES];
	}
}

- (IBAction)joinBtnClick:(UIButton *)sender {
	self.onDidJoin(self.model);
}
- (IBAction)refusedBtnClick:(UIButton *)sender {
	self.onDidRefused(self.model);
}


@end
