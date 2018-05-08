//
//  StockSettingViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "StockSettingViewController.h"
#import "StockTableViewCell.h"
#import "StockSettingView.h"

@interface StockSettingViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) StockSettingView *showView;

@end

@implementation StockSettingViewController

- (UITableView *)tableview {
	if (!_tableview) {
		_tableview = [[UITableView alloc] init];
		[_tableview setDelegate:self];
		[_tableview setDataSource:self];
		[_tableview setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
	}
	return _tableview;
}

- (StockSettingView *)showView {
	if (!_showView) {
		_showView = [[StockSettingView alloc] init];
		WeakSelf(self);
		[_showView setOnSaveBlock:^(SkuModel *model) {
			[weakSelf.model.sku addObject:model];
			[weakSelf.tableview reloadData];
		}];
		
	}
	return _showView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	self.navigationItem.title = @"库存设置";
	[self addPopBackBtn];
	[self addRightBtnWithTitle:@"" image:@"添加银行卡"];
	
	self.showView.typeOne.delegate = self;
	self.showView.typeOne.inputAccessoryView = [self addToolbar];
	
	self.showView.typeTwo.delegate = self;
	self.showView.typeTwo.inputAccessoryView = [self addToolbar];
	
	self.showView.priceTF.delegate = self;
	self.showView.priceTF.inputAccessoryView = [self addToolbar];
	
	self.showView.numberTF.delegate = self;
	self.showView.numberTF.inputAccessoryView = [self addToolbar];
	
	NSArray *array = [[NSArray alloc] init];
	array = @[@"属性1",@"属性2",@"价格",@"库存"];
	for (NSInteger index = 0; index < 4; index ++) {
		UILabel *label = [[UILabel alloc] init];
		[label setText:array[index]];
		[label setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
		[label setTextColor:UIColorFromRGB(0x898989)];
		[label setTextAlignment:NSTextAlignmentCenter];
		[label setFont:[UIFont systemFontOfSize:13.0f]];
		[self.view addSubview: label];
		label.sd_layout
		.topSpaceToView(self.view, 64.0f)
		.leftSpaceToView(self.view, ScreenWidth/4*index)
		.widthIs(ScreenWidth/4)
		.heightIs(30.0f);
	}
	
	[self.view addSubview: self.tableview];
	self.tableview.sd_layout
	.topSpaceToView(self.view, 94.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.bottomSpaceToView(self.view, 0.0f);
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	// 将要结束时将数据传递到上一界面
	self.onDidReturn(self.model);
}

- (void)respondsToRightBtn {
	// 添加库存设置
	[self.showView show];
}

#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.model.sku.count <= 0 ? 0 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.model.sku.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	StockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
	if (!cell) {
		cell = [[StockTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
	}
	[cell updateViewWithModel:self.model.sku[indexPath.row]];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	// 删除数据原请求之后进行刷新
	[self.model.sku removeObjectAtIndex:indexPath.row];
	[self.tableview reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
