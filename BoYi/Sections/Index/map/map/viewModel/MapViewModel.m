//
//  MapViewModel.m
//  BoYi
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MapViewModel.h"
#import "MapTableViewCell.h"

@implementation MapViewModel

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
    [self.dataArray removeAllObjects];
    
//    [self.dataArray addObjectsFromArray:[MapModel mj_objectArrayWithKeyValuesArray:object[@"r"]]];
    
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
            return [self requestSignalWithUrl:URL_CITY
                                      loading:nil
                                Authorization:@""
                                         info:input];
        }];
    }
    return _refreshDataCommand;
}


#pragma mark - 网络请求
- (RACSignal *)requestSignalWithUrl:(NSString *)url
                            loading:(NSString *)loading
                      Authorization:(NSString *)Authorization
                               info:(NSDictionary *)info {
    
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        

        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:POST
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
                                                                            [NavigateManager hiddenLoadingMessage];
                                                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                            // 如果网络请求出错，则加载数据库中的旧数据
                                                                            
                                                                            [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
                                                                            [NavigateManager hiddenLoadingMessage];
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
    
    NewmapModel *map = self.dataArray[section];
    return 3;
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 38;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenWidth, 18)];
    label.textColor = RGBA(51, 51, 51, 1);
    label.font = [UIFont systemFontOfSize:15];
    MapModel *model = self.dataArray[section];
    label.text = model.name;
    [view addSubview:label];

    return view;
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MapTableViewCell"];
    MapModel *map = self.dataArray[indexPath.section];
    cell.city.text = map.byCityList[indexPath.row].name;
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}
#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"暂无数据";
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = RGBA(202, 202, 202, 1);
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return IMAGE_NAME(@"no-message");
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
    return self.dataArray.count > 0  && self.dataArray;
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
