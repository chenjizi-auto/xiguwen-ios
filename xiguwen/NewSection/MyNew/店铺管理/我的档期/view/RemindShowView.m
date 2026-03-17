//
//  RemindShowView.m
//  BoYi
//
//  Created by Niklaus on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "RemindShowView.h"

@interface RemindShowView () <UITableViewDelegate,UITableViewDataSource>



@end

@implementation RemindShowView

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.bounces = NO;
	}
	return _tableView;
}


#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	self.onDidSelected(indexPath.row);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	RemindCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
	if (!cell) {
		cell = [[RemindCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
		[cell setBackgroundColor:UIColorFromRGB(0xFFF2DC)];
		[cell.deleteBtn setHidden: self.isDeleteHidden];
	}
	WeakSelf(self);
	RemindDetailsModel *model = self.array[indexPath.row];
	[cell updateViewWithModel:model];
	[cell setOnDidSelected:^{
		// 选择性删除
		[weakSelf.array removeObjectAtIndex:indexPath.row];
		[weakSelf.tableView reloadData];
		weakSelf.onDeleteRemind(weakSelf.array);
	}];
	
	return cell;
}

#pragma mark - 更新视图
- (void)updateViewWithModel:(NSMutableArray *)array {
	
	self.array = array;
	
	[self addSubview: self.tableView];
	self.tableView.sd_layout
	.topSpaceToView(self, 0.0f)
	.leftSpaceToView(self, 0.0f)
	.rightSpaceToView(self, 0.0f)
	.heightIs(40*array.count);
	[self.tableView reloadData];
}


@end
