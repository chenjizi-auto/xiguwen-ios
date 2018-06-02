//
//  MyNewViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewViewModel.h"
#import "MynewUserWHTableViewCell.h"
#import "MyNewshangjiaCellTableViewCell.h"
#import "MyNewshangjiaCellTwoTableViewCell.h"

@implementation MyNewViewModel

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
    
    [self.dataArray addObjectsFromArray:[MyNewViewModel mj_objectArrayWithKeyValuesArray:object]];
    
}


#pragma mark - private

- (RACSubject *)shangjiaTagSubject {
    
    if (!_shangjiaTagSubject) _shangjiaTagSubject = [RACSubject subject];
    
    return _shangjiaTagSubject;
}
- (RACSubject *)userTagSubject {
    
    if (!_userTagSubject) _userTagSubject = [RACSubject subject];
    
    return _userTagSubject;
}
- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)shangjiaHunQinTagSubject {
    
    if (!_shangjiaHunQinTagSubject) _shangjiaHunQinTagSubject = [RACSubject subject];
    
    return _shangjiaHunQinTagSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:@""
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}

#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([UserDataNew sharedManager].userInfoModel.user.usertype == 3) {
        self.isUser = YES;
    }else {
        self.isUser = NO;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isUser) {
        return 646.0;
    }else{
        if ([UserDataNew sharedManager].userInfoModel.user.usertype == 1) {
            return 870 + 60;
        }else {
            return 972 + 54 + 50 - 72;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isUser) {
        MynewUserWHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MynewUserWHTableViewCell"];
        if (!cell) {
            cell = [[MynewUserWHTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MynewUserWHTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        [[cell.gotoNextVc takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.userTagSubject sendNext:@([x integerValue])];
        }];
        return  cell;
    }else {
        if ([UserDataNew sharedManager].userInfoModel.user.usertype == 1) {
            MyNewshangjiaCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyNewshangjiaCellTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"MyNewshangjiaCellTableViewCell" owner:nil options:nil].firstObject;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            @weakify(self);
            [[cell.gotoNextVc takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                [self.shangjiaTagSubject sendNext:@([x integerValue])];
            }];
            return  cell;
        }else {
            MyNewshangjiaCellTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyNewshangjiaCellTwoTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"MyNewshangjiaCellTwoTableViewCell" owner:nil options:nil].firstObject;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            @weakify(self);
            [[cell.gotoNextVc takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                [self.shangjiaHunQinTagSubject sendNext:@([x integerValue])];
            }];
            return  cell;
        }
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
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
