//
//  StockSettingView.m
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "StockSettingView.h"

@interface StockSettingView () <UITextFieldDelegate>



@end

@implementation StockSettingView
#pragma mark - Setters and getters
- (UIView *)maskView {
	if(!_maskView) {
		_maskView = [[UIView alloc] init];
		[_maskView setBackgroundColor: [[UIColor alloc] initWithWhite: 0.1f alpha: 0.8f]];
		[_maskView setAlpha: 0.0f];
	}
	return _maskView;
}
- (UIView *)mainView{
	if(!_mainView){
		_mainView = [[UIView alloc] init];
		[_mainView setBackgroundColor: [UIColor whiteColor]];
	}
	return _mainView;
}
- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setText: @"添加库存设置"];
		[_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_titleLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _titleLabel;
}
- (UIButton *)cancelBtn {
	if (!_cancelBtn) {
		_cancelBtn = [[UIButton alloc] init];
		[_cancelBtn setImage:[UIImage imageNamed:@"关闭map"] forState:(UIControlStateNormal)];
		[_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _cancelBtn;
}
- (UIButton *)saveBtn {
	if (!_saveBtn) {
		_saveBtn = [[UIButton alloc] init];
		[_saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
		[_saveBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
		[_saveBtn.layer setCornerRadius:2.0f];
		[_saveBtn.layer setMasksToBounds: YES];
		[_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _saveBtn;
}

- (UITextField *)typeOne {
	if (!_typeOne) {
		_typeOne = [[UITextField alloc] init];
		[_typeOne setPlaceholder:@"请输入属性1"];
		[_typeOne setDelegate:self];
		[_typeOne setFont:[UIFont systemFontOfSize:16.0f]];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"属性1";
		[label setFont:[UIFont systemFontOfSize:16.0f]];
		_typeOne.leftView = label;
		_typeOne.leftViewMode = UITextFieldViewModeAlways;
	}
	return _typeOne;
}
- (UITextField *)typeTwo {
	if (!_typeTwo) {
		_typeTwo = [[UITextField alloc] init];
		[_typeTwo setPlaceholder:@"请输入属性2"];
		[_typeTwo setDelegate:self];
		[_typeTwo setFont:[UIFont systemFontOfSize:16.0f]];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"属性2";
		[label setFont:[UIFont systemFontOfSize:16.0f]];
		_typeTwo.leftView = label;
		_typeTwo.leftViewMode = UITextFieldViewModeAlways;
	}
	return _typeTwo;
}
- (UITextField *)priceTF {
	if (!_priceTF) {
		_priceTF = [[UITextField alloc] init];
		[_priceTF setPlaceholder:@"请输入价格"];
		[_priceTF setDelegate:self];
		[_priceTF setFont:[UIFont systemFontOfSize:16.0f]];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"价格";
		[label setFont:[UIFont systemFontOfSize:16.0f]];
		_priceTF.leftView = label;
		_priceTF.leftViewMode = UITextFieldViewModeAlways;
	}
	return _priceTF;
}
- (UITextField *)numberTF {
	if (!_numberTF) {
		_numberTF = [[UITextField alloc] init];
		[_numberTF setPlaceholder:@"请输入库存量"];
		[_numberTF setDelegate:self];
		[_numberTF setFont:[UIFont systemFontOfSize:16.0f]];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"库存";
		[label setFont:[UIFont systemFontOfSize:16.0f]];
		_numberTF.leftView = label;
		_numberTF.leftViewMode = UITextFieldViewModeAlways;
	}
	return _numberTF;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setBackgroundColor:[UIColor clearColor]];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
		[self setUserInteractionEnabled:YES];
		[tap setCancelsTouchesInView:YES];
		[self addGestureRecognizer:tap];
		
		// mask
		[self addSubview: self.maskView];
		self.maskView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f));
		
		// mainView
		[self addSubview: self.mainView];
		[self.mainView setFrame:CGRectMake(0.0f, ScreenHeight, ScreenWidth, 0.0f)];
		
		// titleLabel
		[self.mainView addSubview: self.titleLabel];
		self.titleLabel.sd_layout
		.topSpaceToView(self.mainView, 0.0f)
		.leftSpaceToView(self.mainView, 0.0f)
		.rightSpaceToView(self.mainView, 0.0f)
		.heightIs(50.0f);
		
		// cancelBtn
		[self.mainView addSubview: self.cancelBtn];
		self.cancelBtn.sd_layout
		.centerYEqualToView(self.titleLabel)
		.rightSpaceToView(self.mainView, 10.0f)
		.widthIs(30.0f)
		.heightEqualToWidth();
		
		// 输入模块
		[self.mainView addSubview: self.typeOne];
		self.typeOne.sd_layout
		.topSpaceToView(self.titleLabel, 0.0f)
		.leftSpaceToView(self.mainView, 15.0f)
		.rightSpaceToView(self.mainView, 15.0f)
		.heightIs(50.0f);
		
		[self.mainView addSubview: self.typeTwo];
		self.typeTwo.sd_layout
		.topSpaceToView(self.typeOne, 0.0f)
		.leftSpaceToView(self.mainView, 15.0f)
		.rightSpaceToView(self.mainView, 15.0f)
		.heightIs(50.0f);
		
		[self.mainView addSubview: self.priceTF];
		self.priceTF.sd_layout
		.topSpaceToView(self.typeTwo, 0.0f)
		.leftSpaceToView(self.mainView, 15.0f)
		.rightSpaceToView(self.mainView, 15.0f)
		.heightIs(50.0f);
		
		[self.mainView addSubview: self.numberTF];
		self.numberTF.sd_layout
		.topSpaceToView(self.priceTF, 0.0f)
		.leftSpaceToView(self.mainView, 15.0f)
		.rightSpaceToView(self.mainView, 15.0f)
		.heightIs(50.0f);
		
		// saveBtn
		[self.mainView addSubview: self.saveBtn];
		self.saveBtn.sd_layout
		.bottomSpaceToView(self.mainView, 15.0f)
		.leftSpaceToView(self.mainView, 15.0f)
		.rightSpaceToView(self.mainView, 15.0f)
		.heightIs(40.0f);
		
		for (NSInteger index = 0; index < 5; index ++) {
			UIView *lineView = [[UIView alloc] init];
			[lineView setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
			[self.mainView addSubview:lineView];
			lineView.sd_layout
			.topSpaceToView(self.titleLabel, 50*index)
			.leftSpaceToView(self.mainView, 0.0f)
			.rightSpaceToView(self.mainView, 0.0f)
			.heightIs(1.0f);
		}
		
		[self.mainView setHeight:320.0f];
	}
	return self;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
	if (sender.state == UIGestureRecognizerStateEnded){
		
		CGPoint location = [sender locationInView:nil];
		//获取当前点击点在分享视图的坐标信息
		CGPoint clickPoint = [self.mainView convertPoint: location fromView: self];
		//如果当前点击区域不在分享视图上，就隐藏主视图
		if(![self.mainView pointInside: clickPoint withEvent: nil]){
			[self dismiss];
		}
	}
}

#pragma mark 显示分享视图
- (void)show{
	[[[UIApplication sharedApplication] keyWindow] addSubview: self];
	self.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f));
	[self setHidden: NO];
	
	WeakSelf(self);
	[UIView animateWithDuration: 0.5f animations:^{
		[weakSelf.maskView setAlpha: 1.0f];
	}];
	
	[UIView animateWithDuration: 0.5f animations:^{
		[weakSelf.mainView setTop: ScreenHeight - weakSelf.mainView.height];
	}];
}

#pragma mark 隐藏分享视图
- (void)dismiss{
	WeakSelf(self);
	[UIView animateWithDuration: 0.5f animations:^{
		[weakSelf.maskView setAlpha: 0.0f];
	}];
	
	[UIView animateWithDuration: 0.5f animations:^{
		[weakSelf.mainView setTop: ScreenHeight];
	} completion:^(BOOL finished) {
		[weakSelf setHidden: YES];
	}];
}

- (void)cancelBtnClick {
	// 取消选择点击事件
	[self dismiss];
}

- (void)saveBtnClick {
	// 保存按钮点击事件
	if (self.typeOne.text.length <= 0  && self.typeTwo.text.length <= 0) {
		[NavigateManager showMessage:@"请至少填写一个属性"];
		return;
	}
	
	if (self.priceTF.text <= 0) {
		[NavigateManager showMessage: @"请填写价格"];
		return;
	}
	
	if (self.numberTF.text.length <= 0) {
		[NavigateManager showMessage: @"请填写库存数量"];
		return;
	}
	
	SkuModel *model = [[SkuModel alloc] init];
	model.sku1name = self.typeOne.text;
	model.sku2name = self.typeTwo.text;
	model.prices = self.priceTF.text;
	model.number = self.numberTF.text;
	[self dismiss];
	self.onSaveBlock(model);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	WeakSelf(self);
	[UIView animateWithDuration: 0.5f animations:^{
		[weakSelf.mainView setTop: 20];
	}];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	WeakSelf(self);
	[UIView animateWithDuration: 0.5f animations:^{
		[weakSelf.mainView setTop: ScreenHeight - weakSelf.mainView.height];
	}];
}

@end
