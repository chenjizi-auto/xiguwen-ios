//
//  AnlieViewModel.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieViewModel.h"
#import "AnlieTableViewCell.h"
#import "AnlieHeader.h"
@implementation AnlieViewModel

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
        //处理正在请求状态
        [[self.deleguanzhuCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        //处理正在请求状态
        [[self.addguanzhuCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        [self.addguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.addguanUISubject sendNext:x];
        }];
        [self.deleguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.deleteguanzhuUISubject sendNext:x];
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
    
    [self.dataArray addObjectsFromArray:[Anliindexesarray mj_objectArrayWithKeyValuesArray:object]];
    
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
- (RACSubject *)typeItemSubject {
    
    if (!_typeItemSubject) _typeItemSubject = [RACSubject subject];
    
    return _typeItemSubject;
}
- (RACSubject *)deleteguanzhuUISubject {
    
    if (!_deleteguanzhuUISubject) _deleteguanzhuUISubject = [RACSubject subject];
    
    return _deleteguanzhuUISubject;
}
- (RACSubject *)addguanUISubject {
    
    if (!_addguanUISubject) _addguanUISubject = [RACSubject subject];
    
    return _addguanUISubject;
}

- (RACSubject *)loginSubject {
    
    if (!_loginSubject) _loginSubject = [RACSubject subject];
    
    return _loginSubject;
}
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_indexanlielist
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)deleguanzhuCommand {
    
    if (!_deleguanzhuCommand) {
        @weakify(self);
        _deleguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_anliequxiaoguanzhu
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _deleguanzhuCommand;
}
- (RACCommand *)addguanzhuCommand {
    
    if (!_addguanzhuCommand) {
        @weakify(self);
        _addguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_anlieguanzhu
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _addguanzhuCommand;
}
#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 426;
    return [tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model" cellClass:NSClassFromString(@"AnlieTableViewCell") contentViewWidth:ScreenWidth];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 81;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    AnlieHeader *header = [[NSBundle mainBundle]loadNibNamed:@"AnlieHeader" owner:nil options:nil].firstObject;
    header.frame = CGRectMake(0, 0, ScreenWidth, 81);
    @weakify(self);
    [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
        @strongify(self);

        [self.typeItemSubject sendNext:x];
    }];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AnlieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnlieTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AnlieTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(self);
    [[[cell.guanzhuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        if ([UserDataNew sharedManager].userInfoModel.token.token) {
            if (self.dataArray[indexPath.row].afollow == 1) {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[indexPath.row].id] forKey:@"id"];
                
                [self.deleguanzhuCommand execute:dic];
                self.index = indexPath.row;
                
            }else {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[indexPath.row].id] forKey:@"id"];
                [self.addguanzhuCommand execute:dic];
                self.index = indexPath.row;
            }
        }else {
            [self.loginSubject sendNext:nil];
        }
    }];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
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
