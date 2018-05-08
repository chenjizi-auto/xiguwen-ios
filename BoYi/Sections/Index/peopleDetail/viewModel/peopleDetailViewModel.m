//
//  peopleDetailViewModel.m
//  BoYi
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "peopleDetailViewModel.h"
#import "peopleDetailTableViewCell.h"
#import "TlakTableViewCell.h"
@implementation peopleDetailViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        //处理正在请求状态
        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
//            if ([x integerValue] == 1) {
//                [NavigateManager hiddenLoadingMessage];
//            }
            [NavigateManager hiddenLoadingMessage];
        }];
        [[self.addguanzhuCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            //            if ([x integerValue] == 1) {
            //                [NavigateManager hiddenLoadingMessage];
            //            }
            [NavigateManager hiddenLoadingMessage];
        }];
        [[self.lookDQCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            //            if ([x integerValue] == 1) {
            //                [NavigateManager hiddenLoadingMessage];
            //            }
         
        }];
        //请求成功
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        [self.addguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.addguanUISubject sendNext:x];
        }];
        //服务
        [self.fuwuXiangmuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.fuwuxiangmuUISubject sendNext:x];
        }];
        [self.lookDQCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.lookDQUISubject sendNext:x];
        }];
        //请求成功
        [self.GetShopDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.guanzhuUISubject sendNext:x];
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
    self.dataArray = [NSMutableArray arrayWithArray:self.model.comments.commentList];
    
    
}


#pragma mark - private
- (RACSubject *)deleteguanzhuUISubject {
    
    if (!_deleteguanzhuUISubject) _deleteguanzhuUISubject = [RACSubject subject];
    
    return _deleteguanzhuUISubject;
}
- (RACSubject *)guanzhuUISubject {
    
    if (!_guanzhuUISubject) _guanzhuUISubject = [RACSubject subject];
    
    return _guanzhuUISubject;
}

- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}
- (RACSubject *)addguanUISubject {
    
    if (!_addguanUISubject) _addguanUISubject = [RACSubject subject];
    
    return _addguanUISubject;
}
- (RACSubject *)fuwuxiangmuUISubject {
    
    if (!_fuwuxiangmuUISubject) _fuwuxiangmuUISubject = [RACSubject subject];
    
    return _fuwuxiangmuUISubject;
}
- (RACSubject *)lookDQUISubject {
    
    if (!_lookDQUISubject) _lookDQUISubject = [RACSubject subject];
    
    return _lookDQUISubject;
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
            return [self requestSignalWithUrl:URL_DETAIL
                                      loading:@""
                                Authorization:@""
                                        isGet:GET
                                         info:input];
        }];
    }
    return _refreshDataCommand;
}//tianqi
- (RACCommand *)deleguanzhuCommand {
    
    if (!_deleguanzhuCommand) {
        @weakify(self);
        _deleguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_deleGuanzhu
                                      loading:nil
                                Authorization:@""
                                        isGet:POST
                                         info:input];
        }];
    }
    return _deleguanzhuCommand;
}
- (RACCommand *)addguanzhuCommand {
    
    if (!_addguanzhuCommand) {
        @weakify(self);
        _addguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_ADDUserFollowById
                                      loading:nil
                                Authorization:@""
                                        isGet:POST
                                         info:input];
        }];
    }
    return _addguanzhuCommand;
}//tianqi

- (RACCommand *)fuwuXiangmuCommand {
    
    if (!_fuwuXiangmuCommand) {
        @weakify(self);
        _fuwuXiangmuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_FUwuXIANGMU
                                      loading:@""
                                Authorization:@""
                                        isGet:POST
                                         info:input];
        }];
    }
    return _fuwuXiangmuCommand;
}
- (RACCommand *)lookDQCommand {
    
    if (!_lookDQCommand) {
        @weakify(self);
        _lookDQCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_findScheduleByUserIdDate
                                      loading:nil
                                Authorization:@""
                                        isGet:POST
                                         info:input];
        }];
    }
    return _lookDQCommand;
}

- (RACCommand *)GetShopDataCommand {
    
    if (!_GetShopDataCommand) {
        @weakify(self);
        _GetShopDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_lookguanzhu
                                      loading:nil
                                Authorization:@""
                                        isGet:GET
                                         info:input];
        }];
    }
    return _GetShopDataCommand;
}
#pragma mark - 网络请求
- (RACSignal *)requestSignalWithUrl:(NSString *)url
                            loading:(NSString *)loading
                      Authorization:(NSString *)Authorization
                              isGet:(RequestMethod )get
                               info:(NSDictionary *)info {
    
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:get
                                                                         loding:loading
                                                                            dic:info
                                                                       progress:nil
                                                                        success:^(NSURLSessionDataTask *task, id response) {
                                                                            //                                                                        if(response) {
                                                                            // 可封装为请求正确，但是校验未通过处理
                                                                            //                                                                            if ([response[@"code"] integerValue] == 1) {
                                                                            //                                                                                [subscriber sendNext:nil];
                                                                            //                                                                                [subscriber sendError:[NSError errorWithDomain:@"com.saitjr.demo" code:1 userInfo:@{@"msg":@"没数据啦"}]];
                                                                            //                                                                                return;
                                                                            //                                                                            } else {
                                                                            [subscriber sendNext:response];
                                                                            [subscriber sendCompleted];
                                                                            //                                                                            }
                                                                            //                                                                        }
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
    //    [requestSignal throttle:1];
    return requestSignal;
}


#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count > 0 ? self.dataArray.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentlistW *model = self.dataArray[indexPath.row];
    
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"TlakTableViewCell") contentViewWidth:ScreenWidth];
    
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
    
    TlakTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TlakTableViewCell"];
    CommentlistW *model = self.dataArray[indexPath.row];
    cell.model = model;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}
#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"暂无评论";
    
    
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
    return NO;
}
@end
