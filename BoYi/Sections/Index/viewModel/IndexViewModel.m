//
//  IndexViewModel.m
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "IndexViewModel.h"
#import "IndexTableViewCell.h"


@implementation IndexViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        self.dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@""]];
        //处理正在请求状态
//        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
//            
//            @strongify(self);
//        }];
        //请求成功
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        [self.refreshDataCommandCH.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubjectCH sendNext:x];
        }];
        [self.refreshDataCommandZC.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubjectZC sendNext:x];
        }];
        [self.refreshDataCommandSY.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubjectSY sendNext:x];
        }];
        [self.refreshDataCommandSX.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubjectSX sendNext:x];
        }];
        [self.refreshDataCommandHZ.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubjectHZ sendNext:x];
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

- (void)ConvertingToObjectCH:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh{
    
    [self.dataArray replaceObjectAtIndex:0 withObject:[IndexModel mj_objectArrayWithKeyValuesArray:object[@"r"]]];

}

- (void)ConvertingToObjectZC:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh{
    [self.dataArray replaceObjectAtIndex:1 withObject:[IndexModel mj_objectArrayWithKeyValuesArray:object[@"r"]]];
}

- (void)ConvertingToObjectSY:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh{
    [self.dataArray replaceObjectAtIndex:2 withObject:[IndexModel mj_objectArrayWithKeyValuesArray:object[@"r"]]];
}

- (void)ConvertingToObjectSX:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh{
    [self.dataArray replaceObjectAtIndex:3 withObject:[IndexModel mj_objectArrayWithKeyValuesArray:object[@"r"]]];
}

- (void)ConvertingToObjectHZ:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh{
    [self.dataArray replaceObjectAtIndex:4 withObject:[IndexModel mj_objectArrayWithKeyValuesArray:object[@"r"]]];
}

#pragma mark - private
//UI
- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}
- (RACSubject *)refreshUISubjectCH {
    
    if (!_refreshUISubjectCH) _refreshUISubjectCH = [RACSubject subject];
    
    return _refreshUISubjectCH;
}
- (RACSubject *)refreshUISubjectZC {
    
    if (!_refreshUISubjectZC) _refreshUISubjectZC = [RACSubject subject];
    
    return _refreshUISubjectZC;
}
- (RACSubject *)refreshUISubjectSY {
    
    if (!_refreshUISubjectSY) _refreshUISubjectSY = [RACSubject subject];
    
    return _refreshUISubjectSY;
}
- (RACSubject *)refreshUISubjectSX {
    
    if (!_refreshUISubjectSX) _refreshUISubjectSX = [RACSubject subject];
    
    return _refreshUISubjectSX;
}
- (RACSubject *)refreshUISubjectHZ {
    
    if (!_refreshUISubjectHZ) _refreshUISubjectHZ = [RACSubject subject];
    
    return _refreshUISubjectHZ;
}
//点击行数
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//请求
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_banner
                                      loading:nil
                                Authorization:@""
                                        isGet:(RequestMethod )GET
                                         info:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)refreshDataCommandCH {
    
    if (!_refreshDataCommandCH) {
        @weakify(self);
        _refreshDataCommandCH = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_CH
                                      loading:nil
                                Authorization:@""
                                        isGet:(RequestMethod )POST
                                         info:input];
        }];
    }
    return _refreshDataCommandCH;
}
- (RACCommand *)refreshDataCommandZC {
    
    if (!_refreshDataCommandZC) {
        @weakify(self);
        _refreshDataCommandZC = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_ZC
                                      loading:nil
                                Authorization:@""
                                        isGet:(RequestMethod )POST
                                         info:input];
        }];
    }
    return _refreshDataCommandZC;
}
- (RACCommand *)refreshDataCommandSY {
    
    if (!_refreshDataCommandSY) {
        @weakify(self);
        _refreshDataCommandSY = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_SY
                                      loading:nil
                                Authorization:@""
                                        isGet:(RequestMethod )POST
                                         info:input];
        }];
    }
    return _refreshDataCommandSY;
}
- (RACCommand *)refreshDataCommandSX {
    
    if (!_refreshDataCommandSX) {
        @weakify(self);
        _refreshDataCommandSX = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_SX
                                      loading:nil
                                Authorization:@""
                                        isGet:(RequestMethod )POST
                                         info:input];
        }];
    }
    return _refreshDataCommandSX;
}
- (RACCommand *)refreshDataCommandHZ {
    
    if (!_refreshDataCommandHZ) {
        @weakify(self);
        _refreshDataCommandHZ = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_HZ
                                      loading:nil
                                Authorization:@""
                                       isGet:(RequestMethod )POST
                                         info:input];
        }];
    }
    return _refreshDataCommandHZ;
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
    return requestSignal;
}

- (RACSubject *)gotoZhongSubject {
    
    if (!_gotoZhongSubject) {
        _gotoZhongSubject = [RACSubject subject];
    }
    return _gotoZhongSubject;
}
- (RACSubject *)gotoHanSubject {
    
    if (!_gotoHanSubject) {
        _gotoHanSubject = [RACSubject subject];
    }
    return _gotoHanSubject;
}
- (RACSubject *)gotoHuaSubject {
    
    if (!_gotoHuaSubject) {
        _gotoHuaSubject = [RACSubject subject];
    }
    return _gotoHuaSubject;
}
- (RACSubject *)gotoMoreSubject {
    
    if (!_gotoMoreSubject) {
        _gotoMoreSubject = [RACSubject subject];
    }
    return _gotoMoreSubject;
}
#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;

}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dataArray[indexPath.row] isKindOfClass:[NSString class]]) {
        
        return 100;
        
    }else {
        
        
        NSMutableArray *array = self.dataArray[indexPath.row];
        
        if (array.count == 0) {
            
            return 100;
        }
        
        if (indexPath.row == 0) {
            
            IndexModel *model;
            
            if ([[UserData UserDefaults:@"index_one"] isEqualToString:@"2"]) {
                
                model = array[1];
                
            }else if ([[UserData UserDefaults:@"index_one"] isEqualToString:@"3"]) {
                
                model = array[2];
                
            }else {
                
                model = array[0];
            }
            if (model.children.count == 0) {
                return 100;
            }
            if (model.children.count < 4) {
                return 100 + 150;
            }else {
                return 100 + 150 + 150;
            }
        }else if (indexPath.row == 1) {
            
            IndexModel *model;
            
            if ([[UserData UserDefaults:@"index_two"] isEqualToString:@"2"]) {
                
                model = array[1];
                
            }else if ([[UserData UserDefaults:@"index_two"] isEqualToString:@"3"]) {
                
                model = array[2];
                
            }else {
                
                model = array[0];
            }
            
            if (model.children.count == 0) {
                return 100;
            }
            if (model.children.count < 4) {
                return 100 + 150;
            }else {
                return 100 + 150 + 150;
            }
        }else if (indexPath.row == 2) {
            
            IndexModel *model;
            
            if ([[UserData UserDefaults:@"index_three"] isEqualToString:@"2"]) {
                
                model = array[1];
                
            }else if ([[UserData UserDefaults:@"index_three"] isEqualToString:@"3"]) {
                
                model = array[2];
                
            }else {
                
                model = array[0];
            }
            
            if (model.children.count == 0) {
                return 100;
            }
            if (model.children.count < 4) {
                return 100 + 150;
            }else {
                return 100 + 150 + 150;
            }
        }else if (indexPath.row == 3) {
            
            
            IndexModel *model;
            
            if ([[UserData UserDefaults:@"index_four"] isEqualToString:@"2"]) {
                
                model = array[1];
                
            }else if ([[UserData UserDefaults:@"index_four"] isEqualToString:@"3"]) {
                
                model = array[2];
                
            }else {
                
                model = array[0];
            }
            
            if (model.children.count == 0) {
                return 100;
            }
            if (model.children.count < 4) {
                return 100 + 150;
            }else {
                return 100 + 150 + 150;
            }
        }else {
            
            IndexModel *model;
            
            if ([[UserData UserDefaults:@"index_five"] isEqualToString:@"2"]) {
                
                model = array[1];
                
            }else if ([[UserData UserDefaults:@"index_five"] isEqualToString:@"3"]) {
                
                model = array[2];
                
            }else {
                
                model = array[0];
            }
            
            if (model.children.count == 0) {
                return 100;
            }
            if (model.children.count < 4) {
                return 100 + 150;
            }else {
                return 100 + 150 + 150;
            }
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

    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    
    IndexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IndexTableViewCell" owner:nil options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    @weakify(self);
    
    [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        [self.selectItemSubject sendNext:x];
        
    }];
    
    [[[cell.zhongBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        
        
        if (indexPath.row == 0) {
            
            [UserData UserDefaults:@"1" key:@"index_one"];
       
            
        }else if (indexPath.row == 1) {

            [UserData UserDefaults:@"1" key:@"index_two"];
        
            
        }else if (indexPath.row == 2) {
            
            [UserData UserDefaults:@"1" key:@"index_three"];
      
            
            
        }else if (indexPath.row == 3) {
     
            [UserData UserDefaults:@"1" key:@"index_four"];
   
            
            
        }else {
            [UserData UserDefaults:@"1" key:@"index_five"];
            
        }

        [self.gotoZhongSubject sendNext:indexPath];
    }];
    [[[cell.hanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        
        if (indexPath.row == 0) {
            
            [UserData UserDefaults:@"2" key:@"index_one"];
            
            
        }else if (indexPath.row == 1) {
            
            [UserData UserDefaults:@"2" key:@"index_two"];
            
            
        }else if (indexPath.row == 2) {
            
            [UserData UserDefaults:@"2" key:@"index_three"];
            
            
            
        }else if (indexPath.row == 3) {
            
            [UserData UserDefaults:@"2" key:@"index_four"];
            
            
            
        }else {
            [UserData UserDefaults:@"2" key:@"index_five"];
            
        }
        
        
        [self.gotoHanSubject sendNext:indexPath];
    }];
    [[[cell.huaBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        
        if (indexPath.row == 0) {
            
            [UserData UserDefaults:@"3" key:@"index_one"];
            
            
        }else if (indexPath.row == 1) {
            
            [UserData UserDefaults:@"3" key:@"index_two"];
            
            
        }else if (indexPath.row == 2) {
            
            [UserData UserDefaults:@"3" key:@"index_three"];
            
            
            
        }else if (indexPath.row == 3) {
            
            [UserData UserDefaults:@"3" key:@"index_four"];
            
            
            
        }else {
            [UserData UserDefaults:@"3" key:@"index_five"];
            
        }
        
        [self.gotoHuaSubject sendNext:indexPath];
    }];
    [[[cell.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        [self.gotoMoreSubject sendNext:indexPath];
    }];
    
    if (indexPath.row == 0) {
        cell.hotName.text = @"热门策划师";
        
    }else if (indexPath.row == 1) {
        cell.hotName.text = @"热门主持人";
        
    }else if (indexPath.row == 2) {
        cell.hotName.text = @"热门摄影师";
        
    }else if (indexPath.row == 3) {
        cell.hotName.text = @"热门摄像师";
        
    }else {
        cell.hotName.text = @"热门化妆师";
        
    }
    if (![self.dataArray[indexPath.row] isKindOfClass:[NSString class]]) {
        
        NSMutableArray *array = self.dataArray[indexPath.row];
        if (array.count > 0) {
            IndexModel *model = array[0];
            IndexModel *model1 = array[1];
            IndexModel *model2 = array[2];
            [cell.zhongBtn setTitle:model.ad.name forState:UIControlStateNormal];
            [cell.hanBtn setTitle:model1.ad.name forState:UIControlStateNormal];
            [cell.huaBtn setTitle:model2.ad.name forState:UIControlStateNormal];
            
            IndexModel *modelMark;
            if (indexPath.row == 0) {
                
                if ([[UserData UserDefaults:@"index_one"] isEqualToString:@"2"]) {
                    
                    modelMark = array[1];
                    
                }else if ([[UserData UserDefaults:@"index_one"] isEqualToString:@"3"]) {
                    
                    modelMark = array[2];
                    
                }else {
                    
                    modelMark = array[0];
                }
                
                
            }else if (indexPath.row == 1) {
                
                if ([[UserData UserDefaults:@"index_two"] isEqualToString:@"2"]) {
                    
                    modelMark = array[1];
                    
                }else if ([[UserData UserDefaults:@"index_two"] isEqualToString:@"3"]) {
                    
                    modelMark = array[2];
                    
                }else {
                    
                    modelMark = array[0];
                }
                
                
            }else if (indexPath.row == 2) {
                
                if ([[UserData UserDefaults:@"index_three"] isEqualToString:@"2"]) {
                    
                    modelMark = array[1];
                    
                }else if ([[UserData UserDefaults:@"index_three"] isEqualToString:@"3"]) {
                    
                    modelMark = array[2];
                    
                }else {
                    
                    modelMark = array[0];
                }
                
                
                
            }else if (indexPath.row == 3) {
                
                if ([[UserData UserDefaults:@"index_four"] isEqualToString:@"2"]) {
                    
                    modelMark = array[1];
                    
                }else if ([[UserData UserDefaults:@"index_four"] isEqualToString:@"3"]) {
                    
                    modelMark = array[2];
                    
                }else {
                    
                    modelMark = array[0];
                }
                
                
                
            }else {
                if ([[UserData UserDefaults:@"index_five"] isEqualToString:@"2"]) {
                    
                    modelMark = array[1];
                    
                }else if ([[UserData UserDefaults:@"index_five"] isEqualToString:@"3"]) {
                    
                    modelMark = array[2];
                    
                }else {
                    
                    modelMark = array[0];
                }
                
            }
            //IDNEXI
            [UserData UserDefaults:S_Integer(indexPath.row) key:@"index_mark_indexRow"];
            
            cell.model = modelMark;

        }
        
    }
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}
#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"暂无消息";
    
    
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



