//
//  MyCertificationAlertView.m
//  BoYi
//
//  Created by Niklaus on 2018/4/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyCertificationAlertView.h"

@interface MyCertificationAlertView () {
	UIButton *markBtn;
	NSInteger selectedId;
}

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation MyCertificationAlertView

- (NSArray *)dataArray {
	if (!_dataArray) {
		_dataArray = [[NSArray alloc] init];
	}
	return _dataArray;
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setText:@"认证费用:"];
		[_titleLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _titleLabel;
}

- (UIButton *)cancelBtn {
	if (!_cancelBtn) {
		_cancelBtn = [[UIButton alloc] init];
		[_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
		[_cancelBtn setTitleColor:UIColorFromRGB(0x0A60FF) forState:(UIControlStateNormal)];
		[_cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _cancelBtn;
}

- (UIButton *)sureBtn {
	if (!_sureBtn) {
		_sureBtn = [[UIButton alloc] init];
		[_sureBtn setTitle:@"去缴费" forState:(UIControlStateNormal)];
		[_sureBtn setTitleColor:UIColorFromRGB(0x0A60FF) forState:(UIControlStateNormal)];
		[_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _sureBtn;
}

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
		[_mainView.layer setCornerRadius:13.0f];
		[_mainView.layer setMasksToBounds: YES];
	}
	return _mainView;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setBackgroundColor:[UIColor clearColor]];
		// mask
		[self addSubview: self.maskView];
		self.maskView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f));
	}
	return self;
}
//不勾选原图 勾选商品

- (void)showWithArray:(NSArray *)array {
	
	// mainView
	[self addSubview: self.mainView];
	self.mainView.sd_layout
	.centerXEqualToView(self)
	.centerYEqualToView(self)
	.widthIs(ScreenWidth/3*2)
	.heightIs(100+30*array.count);
	
	// titleLabel
	[self.mainView addSubview: self.titleLabel];
	self.titleLabel.sd_layout
	.topSpaceToView(self.mainView, 10.0f)
	.leftSpaceToView(self.mainView, 0.0f)
	.rightSpaceToView(self.mainView, 0.0f)
	.heightIs(30.0f);
	
	// cancelBtn
	[self.mainView addSubview: self.cancelBtn];
	self.cancelBtn.sd_layout
	.bottomSpaceToView(self.mainView, 0.0f)
	.leftSpaceToView(self.mainView, 0)
	.widthIs(self.mainView.width/2)
	.heightIs(45.0f);
	
	// confirmBtn
	[self.mainView addSubview: self.sureBtn];
	self.sureBtn.sd_layout
	.bottomSpaceToView(self.mainView, 0.0f)
	.rightSpaceToView(self.mainView, 0.0f)
	.widthIs(self.mainView.width/2)
	.heightIs(45.0f);
	
	
	for (NSInteger index = 0; index < array.count; index ++) {
		
		UILabel *label = [[UILabel alloc] init];
		[label setText:[NSString stringWithFormat:@"¥%@",[array[index] objectForKey:@"parameter2"]]];
		[label setTextAlignment:NSTextAlignmentCenter];
		[self.mainView addSubview: label];
		label.sd_layout
		.topSpaceToView(self.titleLabel, 30*index)
		.centerXEqualToView(self.mainView)
		.heightIs(40.0f);
		[label setSingleLineAutoResizeWithMaxWidth:ScreenWidth/2];
		
		UIButton *selectedBtn = [[UIButton alloc] init];
		selectedBtn.tag = index;
		[selectedBtn setImage:[UIImage imageNamed:@"不勾选原图"] forState:(UIControlStateNormal)];
		[selectedBtn setImage:[UIImage imageNamed:@"勾选商品"] forState:(UIControlStateSelected)];
		[selectedBtn addTarget:self action:@selector(selectedPrice:) forControlEvents:(UIControlEventTouchUpInside)];
		[self.mainView addSubview: selectedBtn];
		selectedBtn.sd_layout
		.centerYEqualToView(label)
		.rightSpaceToView(label, 5.0f)
		.widthIs(20.0f)
		.heightEqualToWidth();
		
	}
	
	[[[UIApplication sharedApplication] keyWindow] addSubview: self];
	self.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f));
	[self setHidden: NO];
	
	WeakSelf(self);
	[UIView animateWithDuration: 0.5f animations:^{
		[weakSelf.maskView setAlpha: 1.0f];
	}];
	
	[UIView animateWithDuration: 0.5f animations:^{
		[weakSelf.mainView setCenter:self.center];
	}];
}

- (void)dismiss {
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

- (void)selectedPrice:(UIButton *)sender {
	[markBtn setSelected:NO];
	markBtn = sender;
	[markBtn setSelected: YES];
	selectedId = sender.tag;
}


- (void)cancelButtonClick {
	[self dismiss];
}

- (void)sureBtnClick {
	// 将所选数据传递给控制器
	self.onConfirmClick(selectedId);
}


@end
