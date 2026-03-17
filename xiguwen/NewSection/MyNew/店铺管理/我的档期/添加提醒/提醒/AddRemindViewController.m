//
//  AddRemindViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/1.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddRemindViewController.h"
#import "MyDangQiModel.h"
#import "CaiPaiDateSele.h"

@interface AddRemindViewController ()

@property (nonatomic, strong) UIView *sectionOne;

@property (nonatomic, strong) UILabel *weddingLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *rehearsalLabel;

@property (nonatomic, strong) UIButton *weddingTF;
@property (nonatomic, strong) UITextField *addressTF;
@property (nonatomic, strong) UIButton *rehearsalBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UITextView *remarkTV;

@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UIView *lineThree;

@property (nonatomic, strong) UIView *sectionTwo;

@property (nonatomic, strong) UILabel *remindOneLabel;
@property (nonatomic, strong) UILabel *remindTwolabel;

@property (nonatomic, strong) UIButton *remindOneBtn;
@property (nonatomic, strong) UIButton *remindTwoBtn;

@property (nonatomic, strong) UIView *lineFour;

@property (nonatomic, strong) UISwitch *switchOne;
@property (nonatomic, strong) UISwitch *switchTwo;

@property (nonatomic, strong) UIView *lineFive;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation AddRemindViewController

#pragma mark - Setters and getters

- (UIView *)sectionOne {
	if (!_sectionOne) {
		_sectionOne = [[UIView alloc] init];
		[_sectionOne setBackgroundColor: UIColorFromRGB(0xF0F0F0)];
	}
	return _sectionOne;
}

- (UILabel *)weddingLabel {
	if (!_weddingLabel) {
		_weddingLabel = [[UILabel alloc] init];
		[_weddingLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_weddingLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _weddingLabel;
}

- (UIButton *)weddingTF {
	if (!_weddingTF) {
		_weddingTF = [[UIButton alloc] init];
		[_weddingTF.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_weddingTF setTitleColor:UIColorFromRGB(0xB3B3B3) forState:(UIControlStateNormal)];
		[_weddingTF setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
		[_weddingTF addTarget:self action:@selector(selectedTime:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _weddingTF;
}

- (UIView *)lineOne {
	if (!_lineOne) {
		_lineOne = [[UIView alloc] init];
		[_lineOne setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
	}
	return _lineOne;
}

- (UILabel *)addressLabel {
	if (!_addressLabel) {
		_addressLabel = [[UILabel alloc] init];
		[_addressLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_addressLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _addressLabel;
}

- (UITextField *)addressTF {
	if (!_addressTF) {
		_addressTF = [[UITextField alloc] init];
		[_addressTF setFont:[UIFont systemFontOfSize:16.0f]];
		[_addressTF setTextColor:UIColorFromRGB(0xB3B3B3)];
	}
	return _addressTF;
}

- (UIView *)lineTwo {
	if (!_lineTwo) {
		_lineTwo = [[UIView alloc] init];
		[_lineTwo setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
	}
	return _lineTwo;
}

- (UILabel *)rehearsalLabel {
	if (!_rehearsalLabel) {
		_rehearsalLabel = [[UILabel alloc] init];
		[_rehearsalLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_rehearsalLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _rehearsalLabel;
}

- (UIButton *)rehearsalBtn {
	if (!_rehearsalBtn) {
		_rehearsalBtn = [[UIButton alloc] init];
		[_rehearsalBtn addTarget:self action:@selector(selectedTime:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _rehearsalBtn;
}

- (UILabel *)timeLabel {
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc] init];
		[_timeLabel setTextColor:UIColorFromRGB(0x898989)];
		[_timeLabel setFont: [UIFont systemFontOfSize:15.0f]];
		[_timeLabel setTextAlignment:NSTextAlignmentRight];
	}
	return _timeLabel;
}

- (UIImageView *)arrowImage {
	if (!_arrowImage) {
		_arrowImage = [[UIImageView alloc] init];
		[_arrowImage setImage:[UIImage imageNamed: @"进入 收货地址"]];
	}
	return _arrowImage;
}

- (UIView *)lineThree {
	if (!_lineThree) {
		_lineThree = [[UIView alloc] init];
		[_lineThree setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
	}
	return _lineThree;
}

- (UITextView *)remarkTV {
	if (!_remarkTV) {
		_remarkTV = [[UITextView alloc] init];
		[_remarkTV setTextColor:UIColorFromRGB(0xB3B3B3)];
		[_remarkTV setFont: [UIFont systemFontOfSize:15.0f]];
	}
	return _remarkTV;
}

- (UIView *)sectionTwo {
	if (!_sectionTwo) {
		_sectionTwo = [[UIView alloc] init];
		[_sectionTwo setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
	}
	return _sectionTwo;
}

- (UILabel *)remindOneLabel {
	if (!_remindOneLabel) {
		_remindOneLabel = [[UILabel alloc] init];
		[_remindOneLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_remindOneLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _remindOneLabel;
}

- (UIButton *)remindOneBtn {
	if (!_remindOneBtn) {
		_remindOneBtn = [[UIButton alloc] init];
		[_remindOneBtn setTitleColor:UIColorFromRGB(0xB3B3B3) forState:(UIControlStateNormal)];
		[_remindOneBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_remindOneBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
		[_remindOneBtn addTarget:self action:@selector(selectedTime:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _remindOneBtn;
}

- (UISwitch *)switchOne {
	if (!_switchOne) {
		_switchOne = [[UISwitch alloc] init];
		[_switchOne addTarget:self action:@selector(switchOneClick:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _switchOne;
}

- (UIView *)lineFour {
	if (!_lineFour) {
		_lineFour = [[UIView alloc] init];
		[_lineFour setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
	}
	return _lineFour;
}

- (UILabel *)remindTwolabel {
	if (!_remindTwolabel) {
		_remindTwolabel = [[UILabel alloc] init];
		[_remindTwolabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_remindTwolabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _remindTwolabel;
}

- (UIButton *)remindTwoBtn {
	if (!_remindTwoBtn) {
		_remindTwoBtn = [[UIButton alloc] init];
		[_remindTwoBtn setTitleColor:UIColorFromRGB(0xB3B3B3) forState:(UIControlStateNormal)];
		[_remindTwoBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_remindTwoBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
		[_remindTwoBtn addTarget:self action:@selector(selectedTime:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _remindTwoBtn;
}

- (UISwitch *)switchTwo {
	if (!_switchTwo) {
		_switchTwo = [[UISwitch alloc] init];
		[_switchTwo addTarget:self action:@selector(switchOneClick:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _switchTwo;
}

- (UIView *)lineFive {
	if (!_lineFive) {
		_lineFive = [[UIView alloc] init];
		[_lineFive setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
	}
	return _lineFive;
}

- (UIButton *)saveBtn {
	if (!_saveBtn) {
		_saveBtn = [[UIButton alloc] init];
		[_saveBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
		[_saveBtn.layer setCornerRadius:2.0f];
		[_saveBtn.layer setMasksToBounds: YES];
		[_saveBtn setTitle: @"保存提醒" forState:(UIControlStateNormal)];
		[_saveBtn addTarget: self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _saveBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[self addPopBackBtn];
	[self setMainView];
	
	self.addressTF.delegate = self;
	self.addressTF.inputAccessoryView = [self addToolbar];
	
	self.remarkTV.delegate = self;
	self.remarkTV.inputAccessoryView = [self addToolbar];
}

- (void)setMainView {
	
	[self.view addSubview: self.sectionOne];
	self.sectionOne.sd_layout
	.topSpaceToView(self.view, 64.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(8.0f);
	
	// 婚礼时间
	[self.view addSubview: self.weddingLabel];
	self.weddingLabel.sd_layout
	.topSpaceToView(self.sectionOne, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.widthIs(80.0f)
	.heightIs(50.0f);
	
	[self.view addSubview: self.weddingTF];
	self.weddingTF.sd_layout
	.centerYEqualToView(self.weddingLabel)
	.leftSpaceToView(self.weddingLabel, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(50.0f);
	
	[self.view addSubview: self.lineOne];
	self.lineOne.sd_layout
	.topSpaceToView(self.weddingLabel, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(1.0f);
	
	UIView *container = self.lineOne;
	
	// 针对不同提醒进行判断
	if (self.type == 1 || self.type == 2) {
		// 只有彩排提醒和约见提醒才显示
		
		// 彩排地点
		[self.view addSubview: self.addressLabel];
		self.addressLabel.sd_layout
		.topSpaceToView(self.lineOne, 0.0f)
		.leftSpaceToView(self.view, 0.0f)
		.widthIs(80.0f)
		.heightIs(50.0f);
		
		[self.view addSubview: self.addressTF];
		self.addressTF.sd_layout
		.centerYEqualToView(self.addressLabel)
		.leftSpaceToView(self.addressLabel, 0.0f)
		.rightSpaceToView(self.view, 0.0f)
		.heightIs(50.0f);
		
		[self.view addSubview: self.lineTwo];
		self.lineTwo.sd_layout
		.topSpaceToView(self.addressLabel, 0.0f)
		.leftSpaceToView(self.view, 0.0f)
		.rightSpaceToView(self.view, 0.0f)
		.heightIs(1.0f);
		
		// 彩排时间
		[self.view addSubview: self.rehearsalLabel];
		self.rehearsalLabel.sd_layout
		.topSpaceToView(self.lineTwo, 0.0f)
		.leftSpaceToView(self.view, 0.0f)
		.widthIs(80.0f)
		.heightIs(50.0f);
		
		[self.view addSubview: self.rehearsalBtn];
		self.rehearsalBtn.sd_layout
		.centerYEqualToView(self.rehearsalLabel)
		.leftSpaceToView(self.rehearsalLabel, 0.0f)
		.rightSpaceToView(self.view, 0.0f)
		.heightIs(50.0f);
		
		[self.rehearsalBtn addSubview: self.arrowImage];
		self.arrowImage.sd_layout
		.centerYEqualToView(self.rehearsalBtn)
		.rightSpaceToView(self.rehearsalBtn, 10.0f)
		.widthIs(10.0f)
		.heightIs(15.0f);
		
		[self.rehearsalBtn addSubview: self.timeLabel];
		self.timeLabel.sd_layout
		.centerYEqualToView(self.rehearsalBtn)
		.leftSpaceToView(self.rehearsalBtn, 5.0f)
		.rightSpaceToView(self.arrowImage, 20.0f)
		.heightIs(50.0f);
		
		[self.view addSubview: self.lineThree];
		self.lineThree.sd_layout
		.topSpaceToView(self.rehearsalLabel, 0.0f)
		.leftSpaceToView(self.view, 0.0f)
		.rightSpaceToView(self.view, 0.0f)
		.heightIs(1.0f);

		container = self.lineThree;
	}
	
	// 备注
	[self.view addSubview: self.remarkTV];
	self.remarkTV.sd_layout
	.topSpaceToView(container, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(120.0f);

	[self.view addSubview:self.sectionTwo];
	self.sectionTwo.sd_layout
	.topSpaceToView(self.remarkTV, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(16.0f);

	// 提醒（1）设置
	[self.view addSubview: self.remindOneLabel];
	self.remindOneLabel.sd_layout
	.topSpaceToView(self.sectionTwo, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.widthIs(80.0f)
	.heightIs(50.0f);
	
	[self.view addSubview:self.switchOne];
	self.switchOne.sd_layout
	.centerYEqualToView(self.remindOneLabel)
	.rightSpaceToView(self.view, 10.0f)
	.widthIs(60.0f)
	.heightIs(50.0f);
	
	[self.view addSubview: self.remindOneBtn];
	self.remindOneBtn.sd_layout
	.centerYEqualToView(self.remindOneLabel)
	.leftSpaceToView(self.remindOneLabel, 5.0f)
	.rightSpaceToView(self.switchOne, 5.0f)
	.heightIs(50.0f);
	
	[self.view addSubview: self.lineFour];
	self.lineFour.sd_layout
	.topSpaceToView(self.remindOneLabel, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(1.0f);

	// 提醒（2）设置
	[self.view addSubview: self.remindTwolabel];
	self.remindTwolabel.sd_layout
	.topSpaceToView(self.lineFour, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.widthIs(80.0f)
	.heightIs(50.0f);
	
	[self.view addSubview:self.switchTwo];
	self.switchTwo.sd_layout
	.centerYEqualToView(self.remindTwolabel)
	.rightSpaceToView(self.view, 10.0f)
	.widthIs(60.0f)
	.heightIs(50.0f);
	
	[self.view addSubview: self.remindTwoBtn];
	self.remindTwoBtn.sd_layout
	.centerYEqualToView(self.remindTwolabel)
	.leftSpaceToView(self.remindTwolabel, 5.0f)
	.rightSpaceToView(self.switchTwo, 5.0f)
	.heightIs(50.0f);
	
	[self.view addSubview: self.lineFive];
	self.lineFive.sd_layout
	.topSpaceToView(self.remindTwolabel, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(1.0f);

	// 保存按钮
	[self.view addSubview: self.saveBtn];
	self.saveBtn.sd_layout
	.bottomSpaceToView(self.view, 20.0f)
	.leftSpaceToView(self.view, 16.09f)
	.rightSpaceToView(self.view, 16.0f)
	.heightIs(40.0f);
	
	
	
	/****************进行数据绑定（后期要通过判断来进行调节）*********************/
	
	[self.weddingLabel setText: @"婚礼时间"];
	[self.addressLabel setText: self.type == 2 ? @"约谈地点" : @"彩排地点"];
	[self.rehearsalLabel setText: self.type == 2 ? @"约谈时间" : @"彩排时间"];
	[self.weddingTF setTitle:self.isEdit ? self.model.tixing[self.index].hunlishijian : @"请输入婚礼时间" forState:(UIControlStateNormal)];
	if (self.type == 1) {
		[self.addressTF setPlaceholder:@"请输入彩排地点"];
	} else if (self.type == 2) {
		[self.addressTF setPlaceholder:@"请输入约谈地点"];
	}
	[self.addressTF setText: self.isEdit ? self.model.tixing[self.index].didian : nil];
	[self.timeLabel setText: self.isEdit ? self.model.tixing[self.index].shijian : @"请选择"];
	[self.remarkTV setText: self.isEdit ? self.model.tixing[self.index].beizhu : @"请输入您的备注..."];
	[self.remindOneLabel setText: @"提醒(一)"];
	[self.remindTwolabel setText: @"提醒(二)"];
	// 判断提醒是否开启
	[self.remindOneBtn setTitle: self.isEdit ? self.model.tixing[self.index].tixinshijian1 : @"手机当前时间" forState:(UIControlStateNormal)];
	[self.remindTwoBtn setTitle: self.isEdit ? self.model.tixing[self.index].tixinshijian2 : @"手机当前时间" forState:(UIControlStateNormal)];
	
	if (self.isEdit) {
		[self.switchOne setOn: self.model.tixing[self.index].tixinshijian1 ? YES : NO];
		[self.switchTwo setOn: self.model.tixing[self.index].tixinshijian2 ? YES : NO];
	} else {
		[self.switchOne setOn: NO];
		[self.switchTwo setOn: NO];
	}
	
}

#pragma mark - 选择时间所有
- (void)selectedTime:(UIButton *)sender {
	[CaiPaiDateSele showInView:self.view block:^(NSDate *date) {
		NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd HH:mm"];
		if (sender == self.weddingTF) {
			[self.weddingTF setTitle:dateString forState:(UIControlStateNormal)];
		} else if (sender == self.rehearsalBtn) {
			[self.timeLabel setText: dateString];
		} else if (sender == self.remindOneBtn) {
			[self.remindOneBtn setTitle: dateString forState:(UIControlStateNormal)];
		} else if (sender == self.remindTwoBtn) {
			[self.remindTwoBtn setTitle: dateString forState:(UIControlStateNormal)];
		}
	}];
}

#pragma mark - 切换时间状态
- (void)switchOneClick:(UISwitch *)sender {
	sender.on = !sender.on;
}

#pragma mark - 保存提醒
- (void)saveBtnClick {
	// 判断是否存在
	
	RemindDetailsModel *model = [[RemindDetailsModel alloc] init];
	model.hunlishijian = self.weddingTF.currentTitle;
	model.didian = self.addressTF.text;
	model.beizhu = self.remarkTV.text;
	model.shijian = self.timeLabel.text;
	model.tixinshijian1 = self.switchOne.on ? self.remindOneBtn.currentTitle : nil;
	model.tixinshijian2 = self.switchTwo.on ? self.remindTwoBtn.currentTitle : nil;
	model.type = [NSString stringWithFormat: @"%ld",self.type];
	
	if (model.hunlishijian.length <= 0 || [model.hunlishijian isEqualToString:@"请输入婚礼时间"]) {
		[NavigateManager showMessage: @"请选择婚礼时间"];
		 return;
	}
	
	if (model.didian.length <= 0 && self.type != 3) {
		[NavigateManager showMessage: @"请选择地点"];
		return;
	}
	
	if (model.shijian.length <= 0 && self.type != 3) {
		[NavigateManager showMessage: self.type == 1 ? @"请选择彩排时间" : @"请选择约谈时间"];
		return;
	}
	
	if ([model.shijian isEqualToString:@"请选择"]) {
		[NavigateManager showMessage: self.type == 1 ? @"请选择彩排时间" : @"请选择约谈时间"];
		return;
	}
	
	if (model.beizhu.length <= 0 || [model.beizhu isEqualToString:@"请输入您的备注..."]) {
		[NavigateManager showMessage: @"请填写备注"];
		return;
	}
	
	if (model.tixinshijian1.length <= 0 && self.switchOne.on) {
		[NavigateManager showMessage: @"请选择提醒(一)时间"];
		return;
	}
	
	if (model.tixinshijian2.length <= 0 && self.switchTwo.on) {
		[NavigateManager showMessage: @"请选择提醒(二)时间"];
		return;
	}
	
	
	// 将数据添加到数组里(同时将保存数据传递到上级页面)判断是否编辑状态
	if (self.isEdit) {
		// 编辑状态则替换掉之前的提醒
		[self.model.tixing replaceObjectAtIndex:self.index withObject:model];
	} else {
		// 非编辑状态则新增到数组
		[self.model.tixing addObject:model];
	}
	
	[self popViewConDelay];
	
	self.onComplete(self.model);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

@end
