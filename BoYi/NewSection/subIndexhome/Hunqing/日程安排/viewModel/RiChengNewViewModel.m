//
//  RiChengNewViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "RiChengNewViewModel.h"
#import "RiChengNewTableViewCell.h"

@implementation RiChengNewViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        //处理正在请求状态
        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        
    }
    return self;
}

#pragma mark - public
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    
    if (!self.dataArray) self.dataArray = [NSMutableArray array];
    if (isHeaderRefersh) [self.dataArray removeAllObjects];
    self.dataArrayJintian = [NSMutableArray array];
    self.dataArrayWancheng = [NSMutableArray array];
    [self.dataArray addObjectsFromArray:[Newrichengarray mj_objectArrayWithKeyValuesArray:object]];
    for (int i = 0; i < self.dataArray.count; i ++) {
        Newrichengarray *model = self.dataArray[i];
        if (model.isend == 1) {
            [self.dataArrayWancheng addObject:model];
        }else {
            [self.dataArrayJintian addObject:model];
        }
    }
}


#pragma mark - private

- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}

- (RACSubject *)deleteItemSubject {
	if (!_deleteItemSubject) _deleteItemSubject = [RACSubject subject];
	return _deleteItemSubject;
}

- (RACSubject *)statusItemSubject {
	if (!_statusItemSubject) _statusItemSubject = [RACSubject subject];
	return _statusItemSubject;
}

- (RACSubject *)editItemSubject {
	if (!_editItemSubject) _editItemSubject = [RACSubject subject];
	return _editItemSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_richengList
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}

#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count > 0 ? 2 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArrayJintian.count;
    }else {
        return self.dataArrayWancheng.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return [tableView cellHeightForIndexPath:indexPath model:self.dataArrayJintian[indexPath.row] keyPath:@"model" cellClass:NSClassFromString(@"RiChengNewTableViewCell") contentViewWidth:ScreenWidth - 51 - 16];
    }else {
        return [tableView cellHeightForIndexPath:indexPath model:self.dataArrayWancheng[indexPath.row] keyPath:@"model" cellClass:NSClassFromString(@"RiChengNewTableViewCell") contentViewWidth:ScreenWidth - 51 - 16];
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    view.backgroundColor = RGBA(255, 240, 244, 1);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 7, 54, 16)];
    label.font = [UIFont systemFontOfSize:13.f];
    label.textColor = RGBA(156, 96, 113, 1);
    label.text = section == 0 ? @"今天" :@"已完成";
    [view addSubview:label];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RiChengNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RiChengNewTableViewCell"];
	
    if (indexPath.section == 0) {
        cell.model = self.dataArrayJintian[indexPath.row];
    }else {
        cell.model = self.dataArrayWancheng[indexPath.row];
    }
	
	WeakSelf(self);
	[cell setOnSendModel:^(Newrichengarray *model) {
		[weakSelf.statusItemSubject sendNext:model];
	}];
	
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//	
//}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		if (indexPath.section == 0) {
			[self.deleteItemSubject sendNext:self.dataArrayJintian[indexPath.row]];
		} else {
			[self.deleteItemSubject sendNext:self.dataArrayWancheng[indexPath.row]];
		}
		DLog(@"点击了删除");
	}];
	UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		if (indexPath.section == 0) {
			[self.editItemSubject sendNext:self.dataArrayJintian[indexPath.row]];
		} else {
			[self.editItemSubject sendNext:self.dataArrayWancheng[indexPath.row]];
		}
		DLog(@"点击了编辑");
	}];
	editAction.backgroundColor = [UIColor grayColor];
	return @[deleteAction, editAction];
}

#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"空空如也";
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = RGBA(202, 202, 202, 1);
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return IMAGE_NAME(@"无数据 空状态");
}





- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -49.0;
}

//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -49.0;
//}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.dataArray.count == 0  && self.dataArray;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
@end
