//
//  AttributeSettingViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AttributeSettingViewController.h"

@interface AttributeSettingViewController ()

@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UITextField *oneTF;
@property (nonatomic, strong) UIView *lineVIew;
@property (nonatomic, strong) UITextField *twoTF;

@end

@implementation AttributeSettingViewController

- (UITextField *)oneTF {
	if (!_oneTF) {
		_oneTF = [[UITextField alloc] init];
		[_oneTF setPlaceholder:@"请输入属性1名称"];
		[_oneTF setTextAlignment:NSTextAlignmentRight];
		[_oneTF setBackgroundColor:[UIColor whiteColor]];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"属性1名称";
		label.font = [UIFont systemFontOfSize:16.0f];
		_oneTF.leftView = label;
		_oneTF.leftViewMode = UITextFieldViewModeAlways;
	}
	return _oneTF;
}

- (UITextField *)twoTF {
	if (!_twoTF) {
		_twoTF = [[UITextField alloc] init];
		[_twoTF setPlaceholder:@"请输入属性1名称"];
		[_twoTF setTextAlignment:NSTextAlignmentRight];
		[_oneTF setBackgroundColor:[UIColor whiteColor]];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"属性2名称";
		label.font = [UIFont systemFontOfSize:16.0f];
		_twoTF.leftView = label;
		_twoTF.leftViewMode = UITextFieldViewModeAlways;
	}
	return _twoTF;
}

- (UIView *)lineVIew {
	if (!_lineVIew) {
		_lineVIew = [[UIView alloc] init];
		[_lineVIew setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _lineVIew;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	self.navigationItem.title = @"属性设置";
	[self addPopBackBtn];
	[self addRightBtnWithTitle:@"保存" image:@""];
	
	[self.view addSubview:self.oneTF];
	self.oneTF.sd_layout
	.topSpaceToView(self.view, 70.0f)
	.leftSpaceToView(self.view, 15.0f)
	.rightSpaceToView(self.view, 15.0f)
	.heightIs(50.0f);
	
	[self.view addSubview: self.lineVIew];
	self.lineVIew.sd_layout
	.topSpaceToView(self.oneTF, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(1.0f);
	
	[self.view addSubview: self.twoTF];
	self.twoTF.sd_layout
	.topSpaceToView(self.lineVIew, 0.0f)
	.leftSpaceToView(self.view, 15.0f)
	.rightSpaceToView(self.view, 15.0f)
	.heightIs(50.0f);
	
	if (self.model) {
		[self.oneTF setText:self.model.sku1];
		[self.twoTF setText:self.model.sku2];
	}
	
	self.oneTF.delegate = self;
	self.oneTF.inputAccessoryView = [self addToolbar];
	
	self.twoTF.delegate = self;
	self.twoTF.inputAccessoryView = [self addToolbar];
}

- (void)respondsToRightBtn {
	// 保存点击事件
	if (self.oneTF.text.length <= 0 && self.twoTF.text.length <= 0) {
		[NavigateManager showMessage: @"请填写至少一个属性"];
		return;
	}
	// 将属性传回上一界面
	
	self.model.sku1 = self.oneTF.text;
	self.model.sku2 = self.twoTF.text;
	
	[self popViewConDelay];
	self.onDidReturn(self.model);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
