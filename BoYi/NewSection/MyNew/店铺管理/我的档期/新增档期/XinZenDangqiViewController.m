//
//  XinZenDangqiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "XinZenDangqiViewController.h"
#import "AddTixingViewController.h"
#import "RemindShowView.h"
#import "AddRemindViewController.h"
#import "MyDangQiViewController.h"
@interface XinZenDangqiViewController () <UIPickerViewDelegate,UIPickerViewDataSource> {
	NSArray *typeArray;
}

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) NSInteger selectedNum;

@property (weak, nonatomic) IBOutlet UIView *container;
@property (nonatomic, strong) RemindShowView *remindShowView;
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation XinZenDangqiViewController

#pragma mark - setters and getters
- (UIPickerView *)pickerView {
	if (!_pickerView) {
		_pickerView = [[UIPickerView alloc] init];
		_pickerView.delegate = self;
		_pickerView.dataSource = self;
		_pickerView.backgroundColor = [UIColor whiteColor];
	}
	return _pickerView;
}

- (RemindShowView *)remindShowView {
	if (!_remindShowView) {
		_remindShowView = [[RemindShowView alloc] init];
		_remindShowView.tableView.userInteractionEnabled = YES;
		_remindShowView.isDeleteHidden = NO;
		WeakSelf(self);
		[_remindShowView setOnDeleteRemind:^(NSMutableArray *array) {
			// 删除某一个提醒更新视图
			weakSelf.model.tixing = array;
//			[weakSelf deleteRemind:array];
			[weakSelf setMainView];
		}];
		[_remindShowView setOnDidSelected:^(NSInteger index) {
			// 进入某一个提醒进行修改
			[weakSelf editRemind:index];
		}];
	}
	return _remindShowView;
}

- (UIButton *)addBtn {
	if (!_addBtn) {
		_addBtn = [[UIButton alloc] init];
		[_addBtn setBackgroundColor:[UIColor whiteColor]];
		[_addBtn addTarget:self action:@selector(addButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
		UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"添加提醒"]];
		
		[self.addBtn addSubview:img];
		img.sd_layout
		.centerYEqualToView(self.addBtn)
		.leftSpaceToView(self.addBtn, 15.0f)
		.widthIs(20.0f)
		.heightEqualToWidth();
		
		UILabel *titleLabel = [[UILabel alloc] init];
		[titleLabel setText: @"添加提醒"];
		[titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[self.addBtn addSubview:titleLabel];
		titleLabel.sd_layout
		.centerYEqualToView(self.addBtn)
		.leftSpaceToView(img, 15.0f)
		.widthIs(100.0f)
		.heightIs(20.0f);
		
		UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"进入 收货地址"]];
		[self.addBtn addSubview:arrow];
		arrow.sd_layout
		.centerYEqualToView(self.addBtn)
		.rightSpaceToView(self.addBtn, 15.0f)
		.widthIs(10.0f)
		.heightIs(15.0f);
		
		UILabel *infoLabel = [[UILabel alloc] init];
		[infoLabel setText: @"请选择"];
		[infoLabel setFont:[UIFont systemFontOfSize:15.0f]];
		[infoLabel setTextAlignment:NSTextAlignmentRight];
		[infoLabel setTextColor:UIColorFromRGB(0x898989)];
		[self.addBtn addSubview: infoLabel];
		infoLabel.sd_layout
		.centerYEqualToView(self.addBtn)
		.rightSpaceToView(arrow, 20.0f)
		.widthIs(80.0f)
		.heightIs(20.0f);
	}
	return _addBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self addPopBackBtn];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    if (@available(iOS 14.0, *)) {
        self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    [self.datePicker setDate:[formatter dateFromString:self.model.date]];
	[self.datePicker setBackgroundColor:[UIColor whiteColor]];
	[self setMainView];

    self.nameTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.phoneTF.delegate = self;
    self.phoneTF.inputAccessoryView = [self addToolbar];
    self.remarkTV.delegate = self;
    self.remarkTV.inputAccessoryView = [self addToolbar];
	self.selectedNum = 2;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self setMainView];
}

- (void)setMainView {
	typeArray = [NSArray arrayWithObjects:@"上午",@"中午",@"下午",@"晚上",@"全天",@"不接单", nil];
	[self.pickerView reloadAllComponents];
    NSInteger row = 1;
    if ([typeArray containsObject:self.model.timeslot]) {
        row = [typeArray indexOfObject:self.model.timeslot];
    }
    [self.pickerView selectRow:row inComponent:0 animated:YES];
	[self.baseView addSubview: self.pickerView];
	self.pickerView.sd_layout
	.topEqualToView(self.datePicker)
	.bottomEqualToView(self.datePicker)
	.leftSpaceToView(self.datePicker, 0.0f)
	.rightSpaceToView(self.baseView, 0.0f);
	// 判断是否新建或者修改
	[self.navigationItem setTitle: self.model ? @"编辑档期" : @"添加档期"];
	// 基本资料
	//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	//	[formatter setDateFormat:@"yyyy-MM-dd"];
	//	self.datePicker.date = [formatter dateFromString:self.model.date];
	//	[self.pickerView selectedRowInComponent:2];
	self.nameTF.text = self.model.contacts;
	self.phoneTF.text = self.model.contactnumber;
	self.remarkTV.text = self.model ? self.model.remarks : @"请输入备注";
	
	UIView *line = [[UIView alloc] init];
	[line setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
	[self.container addSubview:line];
	line.sd_layout
	.bottomSpaceToView(self.container, 0.0f)
	.leftSpaceToView(self.container, 0.0f)
	.rightSpaceToView(self.container, 0.0f)
	.heightIs(1.0f);
	
	
	UIView *lineView = [[UIView alloc] init];
	[lineView setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
	[self.baseView addSubview: lineView];
	lineView.sd_layout
	.topSpaceToView(self.container, 0.0f)
	.leftSpaceToView(self.baseView, 0.0f)
	.rightSpaceToView(self.baseView, 0.0f)
	.heightIs(10.0f);
	
	// 添加档期提醒
	[self.remindShowView setIsDeleteHidden: NO];
	[self.baseView addSubview:self.remindShowView];
	self.remindShowView.sd_layout
	.topSpaceToView(self.container, 0.0f)
	.leftSpaceToView(self.baseView, 0.0f)
	.rightSpaceToView(self.baseView, 0.0f)
	.heightIs(40.0f * self.model.tixing.count);
	[self.remindShowView updateViewWithModel:self.model.tixing];
	
	// 添加按钮
	[self.baseView addSubview: self.addBtn];
	self.addBtn.sd_layout
	.topSpaceToView(self.remindShowView, 10.0f)
	.leftSpaceToView(self.baseView, 0.0f)
	.rightSpaceToView(self.baseView, 0.0f)
	.heightIs(50.0f);
}


- (void)addButtonClick {
	// 添加提醒（同时将档期模型传递过去）
	WeakSelf(self);
	AddTixingViewController *add = [[AddTixingViewController alloc] init];
	if (self.model == nil) {
		self.model = [[DangQiDetailsModel alloc] init];
	}
	
	if (self.model.tixing == nil) {
		self.model.tixing = [[NSMutableArray alloc] init];
	}
	
//	self.model.date = [self.datePicker.date fs_string];
//	self.model.timeslot = self.selectedNum;
	self.model.contacts = self.nameTF.text;
	self.model.contactnumber = self.phoneTF.text;
	self.model.remarks = self.remarkTV.text;
//	self.model.tixing =
	
	add.model = self.model;
	[self pushToNextVCWithNextVC:add];
	[add setOnComplete:^(DangQiDetailsModel *model) {
		// 传递过来的提醒数组(同时刷新页面)
		weakSelf.model = model;
//		[weakSelf deleteRemind:model.tixing];
		[weakSelf setMainView];
	}];
}

#pragma mark - 当删除某个提醒时
//- (void)deleteRemind:(NSMutableArray *)array {
//	// 重设约束
//	self.remindShowView.sd_layout
//	.topSpaceToView(self.container, 0.0f)
//	.leftSpaceToView(self.baseView, 0.0f)
//	.rightSpaceToView(self.baseView, 0.0f)
//	.heightIs(40.0f * self.model.tixing.count);
//	[self.remindShowView updateViewWithModel:self.model.tixing];
//
//	self.addBtn.sd_layout
//	.topSpaceToView(self.remindShowView, 10.0f)
//	.leftSpaceToView(self.baseView, 0.0f)
//	.rightSpaceToView(self.baseView, 0.0f)
//	.heightIs(50.0f);
//
//}

- (void)editRemind:(NSInteger)index {
	// 修改某个提醒
	AddRemindViewController *caipai = [[AddRemindViewController alloc] init];
	caipai.isEdit = YES;
	caipai.index = index;
	caipai.model = self.model;
	RemindDetailsModel *model = self.model.tixing[index];
	caipai.type = [model.type integerValue];
	
	
	if (caipai.type == 1) {
		caipai.navigationItem.title = @"彩排提醒";
	}else if (caipai.type == 2) {
		caipai.navigationItem.title = @"约见提醒";
	}else {
		caipai.navigationItem.title = @"其他提醒";
	}
	
	
	[self pushToNextVCWithNextVC:caipai];
	
	WeakSelf(self);
	[caipai setOnComplete:^(DangQiDetailsModel *model) {
		// 二级页面返回数据
		weakSelf.model = model;
//		[weakSelf.remindShowView updateViewWithModel:model.tixing];
		[weakSelf setMainView];
	}];
}

#pragma mark - 保存档期模型
- (IBAction)saveBtnClick:(UIButton *)sender {
	// 将模型数组替换为字典数组
	NSMutableArray *array = [[NSMutableArray array] init];
	for (NSInteger i = 0; i < self.model.tixing.count; i ++) {
		NSDictionary *dic = self.model.tixing[i].mj_keyValues;
		[array addObject:dic];
	}
	
	
	// 保存新建档期
	if (self.datePicker.date == nil) {
		[NavigateManager showMessage: @"请选择日期"];
		return;
	}
	
	if (self.selectedNum <= 0) {
		[NavigateManager showMessage: @"请选择当日时间段"];
		return;
	}
	
	if (self.nameTF.text.length == 0) {
//		[NavigateManager showMessage: @"请填写联系人"];
//		return;
		self.nameTF.text = @"";
	}
	
	if (self.phoneTF.text.length == 0) {
//		[NavigateManager showMessage: @"请填写联系人电话"];
//		return;
		self.phoneTF.text = @"";
	}
	
	if (self.remarkTV.text.length == 0 || [self.remarkTV.text isEqualToString:@"请输入备注"]) {
//		[NavigateManager showMessage: @"请填写备注"];
//		return;
		self.remarkTV.text = @"";
	}
	
	NSDictionary *dic = [[NSDictionary alloc] init];
	NSString *str = [self arrayToJSONString:array];
	if (self.isEdit) {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"id":@(self.model.id),
				@"contactnumber":self.phoneTF.text,
				@"contacts":self.nameTF.text,
				@"date":self.datePicker.date,
				@"remarks":self.remarkTV.text,
				@"timeslot":@(self.selectedNum),
				@"tixing":str};
	} else {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"contactnumber":self.phoneTF.text,
				@"contacts":self.nameTF.text,
				@"date":self.datePicker.date,
				@"remarks":self.remarkTV.text,
				@"timeslot":@(self.selectedNum),
				@"tixing":str};
	}
	
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl: self.isEdit ? URL_editSchedule : URL_addSchedule
										method:POST
										loding:@""
										   dic:dic
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([[response[@"code"] stringValue] isEqualToString:@"0"]) {
											   [NavigateManager showMessage: @"提交成功"];
											   [weakSelf jump];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: weakSelf.isEdit ? @"修改失败" : @"新建失败"];
									   }];
}

- (void)jump {
	MyDangQiViewController *jumpVC = nil;
	for (NSInteger i = 0; i < self.navigationController.viewControllers.count;  i ++) {
		FatherViewController *vc = self.navigationController.viewControllers[i];
		if ([vc isKindOfClass:[MyDangQiViewController class]]) {
			jumpVC = (MyDangQiViewController *)vc;
			break;
		}
	}
	[self.navigationController popToViewController:jumpVC animated:YES];
}


- (NSString *)arrayToJSONString:(NSArray *)array {
	NSError *error = nil;
	//    NSMutableArray *muArray = [NSMutableArray array];
	//    for (NSString *userId in array) {
	//        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
	//    }
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
	NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	//    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	//    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
	//    NSLog(@"json array is: %@", jsonResult);
	return jsonString;
}

#pragma mark - pickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return typeArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return 32.0f;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [typeArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	self.selectedNum = row+1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
