//
//  ScheduleViewModel.m
//  BoYi
//
//  Created by Chen on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ScheduleViewModel.h"
#import "ScheduleTableViewCell.h"
#import "ScheduleTableViewHeaderFooterView.h"

@implementation ScheduleViewModel

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
//        [[self.refreshDataCommand.executionSignals.switchToLatest zipWith:self.getCalendarCommand.executionSignals.switchToLatest] subscribeNext:^(id  _Nullable x) {
//            
//        }];
        
        
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
    else [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:[ScheduleModelWithDate mj_objectArrayWithKeyValuesArray:object]];
    
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

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_findScheduleByWhere
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
//修改档期
- (RACCommand *)udpateStatusByIdCommand {
    
    if (!_udpateStatusByIdCommand) {
        @weakify(self);
        _udpateStatusByIdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_udpateStatusById
                                                          method:GET
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _udpateStatusByIdCommand;
}
//修改档期
- (RACCommand *)insertStatusByIdCommand {
    
    if (!_insertStatusByIdCommand) {
        @weakify(self);
        _insertStatusByIdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_insertStatusById
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _insertStatusByIdCommand;
}
//查询档期
- (RACCommand *)findScheduleCommand {
    
    if (!_findScheduleCommand) {
        @weakify(self);
        _findScheduleCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_findScheduleByUserIdDate
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _findScheduleCommand;
}
//获取日期宜忌
- (RACCommand *)getCalendarCommand {
    
    if (!_getCalendarCommand) {
        @weakify(self);
        _getCalendarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
//            return [[RequestManager sharedManager] RACRequestUrl:[NSString stringWithFormat:@"http://v.juhe.cn/calendar/day?date=%@&key=0a164998cb748dd67a0609e4ff29ab60",input]
//                                                          method:GET
//                                                          loding:@"加载中..."
//                                                             dic:input];
            return [self requestSignalWithUrl:@"http://v.juhe.cn/calendar/day"
                                      loading:@"加载中..."
                                Authorization:nil
                                         info:@{@"key":@"0a164998cb748dd67a0609e4ff29ab60",
                                                @"date":input}];
        }];
    }
    return _getCalendarCommand;
}
#pragma mark - 网络请求
- (RACSignal *)requestSignalWithUrl:(NSString *)url
                            loading:(NSString *)loading
                      Authorization:(NSString *)Authorization
                               info:(NSDictionary *)info {
    
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
    
        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:GET
                                                                         loding:loading
                                                                            dic:info
                                                                       progress:nil
                                                                        success:^(NSURLSessionDataTask *task, id response) {
                                                                            [subscriber sendNext:response];
                                                                            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            // 如果网络请求出错，则加载数据库中的旧数据
            
            [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
            [subscriber sendCompleted];
        }];
        
        // 在信号量作废时，取消网络请求
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
//        [requestSignal throttle:1];
    return requestSignal;
    
}


#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    ScheduleTableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ScheduleTableViewHeaderFooterView"];
//    view.contentView.backgroundColor = [UIColor whiteColor];
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleTableViewCell"];
    cell.model = self.dataArray[indexPath.row];
    
    @weakify(self);
    [[[cell.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        [self.selectItemSubject sendNext:@{@"isEdit":@YES,
                                           @"x":self.dataArray[indexPath.row]}];
    }];
    [[[cell.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        [self.selectItemSubject sendNext:@{@"isEdit":@NO,
                                           @"x":self.dataArray[indexPath.row]}];
        
    }];
    return  cell;
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
    return 190.0;
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
