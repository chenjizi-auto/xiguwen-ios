//
//  NewPeopleDetilViewModel.m
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewPeopleDetilViewModel.h"
#import "NewPeopleDetilTableViewCell.h"

@implementation NewPeopleDetilViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        //处理正在请求状态
        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            if ([x integerValue] != 1) {
                [NavigateManager hiddenLoadingMessage];
            }
        }];
        //请求成功
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
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
        [self.PLGLCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.PLGLSubject sendNext:x];
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
    
//    if (!self.dataArray) self.dataArray = [NSMutableArray array];
//    if (isHeaderRefersh) [self.dataArray removeAllObjects];
//    
//    [self.dataArray addObjectsFromArray:[NewPeopleDetilModel mj_objectArrayWithKeyValuesArray:object]];
    
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

- (RACSubject *)selectTuanSubject {
    
    if (!_selectTuanSubject) _selectTuanSubject = [RACSubject subject];
    
    return _selectTuanSubject;
}
- (RACSubject *)selectZuoSubject {
    
    if (!_selectZuoSubject) _selectZuoSubject = [RACSubject subject];
    
    return _selectZuoSubject;
}
- (RACSubject *)PLGLSubject {
    
    if (!_PLGLSubject) _PLGLSubject = [RACSubject subject];
    
    return _PLGLSubject;
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
- (RACCommand *)PLGLCommand{
    
    if (!_PLGLCommand) {
        @weakify(self);
        _PLGLCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_orderEvaluationList
                                      loading:nil
                                Authorization:@""
                                        isGet:POST
                                         info:input];
        }];
    }
    return _PLGLCommand;
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
    //    [requestSignal throttle:1];
    return requestSignal;
}


#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        if (self.model) {
            peopleDetailModel *model = self.model;
            
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"NewOneTableViewCell") contentViewWidth:ScreenWidth];
        }
        return 160;
    }
    if (indexPath.row == 1) {
        if (self.model.openCitiesMap) {
            NSMutableDictionary *dic = self.model.openCitiesMap;
            for (NSString *s in [dic allKeys]) {
                if ([dic objectForKey:s]) {
                    NSMutableArray *array = [dic objectForKey:s];
                    if (array.count == 0) {
                        return 100;
                       
                    }else if (array.count < 4){
                        return 130;
                    }else {
                        return 160;
                    }
                }
            }
        }
        return 100;
    }
    if (indexPath.row == 2) {
        
        return 432;
    }
    if (indexPath.row == 3) {
        if (self.model.recommendUsers) {
            if (self.model.recommendUsers.count == 0) {
                return 60;
            }
            
            if (self.model.recommendUsers.count < 4 && self.model.recommendUsers.count > 0) {
                if (ScreenWidth == 320) {
                    
                    return 100 + 60;
                    
                }else if (ScreenWidth == 375) {
                    
                    return 180;
                    
                }else {
                    return 190;
                }
            }else {
                if (ScreenWidth == 320) {
                    
                    return 200 + 60 + 60;
                    
                }else if (ScreenWidth == 375) {
                    
                    return 270 + 60;
                    
                }else {
                    return 280 + 60;
                }
            }
            
        }else {
            return 60;
        }
        
    }
    if (indexPath.row == 4) {
        
        if (self.model.exampleList) {
            
            if (self.model.exampleList.count < 4) {
                return 130 + 60 + 30;
            }else {
                return 260 + 60 + 60;
            }
            
        }
        return 60;
    }
    if (indexPath.row == 5) {
        
        if (self.model.comments.commentList) {
            return 200;
        }
    }
    return 0;
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
    
    if (indexPath.row == 0) {
        
        NewOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewOneTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewOneTableViewCell" owner:nil options:nil].firstObject;
        }

        cell.model = self.model;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 1) {
        NewTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewTwoTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewTwoTableViewCell" owner:nil options:nil].firstObject;
        }
        if (self.model.openCitiesMap) {
            NSMutableDictionary *dic = self.model.openCitiesMap;
            for (NSString *s in [dic allKeys]) {
                if ([dic objectForKey:s]) {
                    NSMutableArray *array = [dic objectForKey:s];
                    cell.fuwuArray = array; 
                }
                
            }
        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 2) {

        NewThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewThreeTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewThreeTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.userId = self.userId;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 3) {
        
        NewFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewFourTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewFourTableViewCell" owner:nil options:nil].firstObject;
        }
        
        cell.model = self.model;
        cell.userId = self.userId;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            
            [self.selectTuanSubject sendNext:x];
        }];
        return  cell;
    }else if (indexPath.row == 4) {
        NewFiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewFiveTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewFiveTableViewCell" owner:nil options:nil].firstObject;
        }

        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            
            [self.selectZuoSubject sendNext:x];
        }];
        
        return  cell;
    }else {
        
        SixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SixTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SixTableViewCell" owner:nil options:nil].firstObject;
        }
        if (self.arrayPL.count > 0) {
            cell.dataArray = self.arrayPL;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
}

@end
