//
//  FindDetailViewModel.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FindDetailViewModel.h"
#import "FindDetailTableViewCell.h"
#import "TlakTableViewCell.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
#import "ThreeTableViewCell.h"
#import "FindXinXiModel.h"
#import "QianTwoTableViewCell.h"

@implementation FindDetailViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        //处理正在请求状态
        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        //处理正在请求状态
        [[self.refreshDataCommandTP executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        //处理正在请求状态
        [[self.refreshDataCommandTJ executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        //处理正在请求状态
        [[self.refreshDataCommandPJ executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];

    
        //信息
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        [self.refreshDataCommandTP.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            
            [self.refreshUISubjectTP sendNext:x];

            
            
        }];
        [self.refreshDataCommandTJ.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubjectTJ sendNext:x];
        }];

        [self.refreshDataCommandPJ.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubjectPJ sendNext:x];
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
    
    if (!self.dataArrayPJ) self.dataArrayPJ = [NSMutableArray array];
    if (isHeaderRefersh) [self.dataArrayPJ removeAllObjects];
    
    [self.dataArrayPJ addObjectsFromArray:[EsarraypjPJ mj_objectArrayWithKeyValuesArray:object[@"r"][@"rows"]]];
    
}
- (void)ConvertingToObjectTP:(id)object {
    
    if (!self.dataArrayTP) self.dataArrayTP = [NSMutableArray array];

    [self.dataArrayTP addObjectsFromArray:[Rows mj_objectArrayWithKeyValuesArray:object[@"r"][@"rows"]]];

}
- (void)ConvertingToObjectTJ:(id)object {
    
    if (!self.dataArrayTJ) self.dataArrayTJ = [NSMutableArray array];
    
    [self.dataArrayTJ addObjectsFromArray:[EsarraytjTJ mj_objectArrayWithKeyValuesArray:object[@"r"]]];
    
}
#pragma mark - private

- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}
- (RACSubject *)refreshUISubjectTP {
    
    if (!_refreshUISubjectTP) _refreshUISubjectTP = [RACSubject subject];
    
    return _refreshUISubjectTP;
}
- (RACSubject *)refreshUISubjectTJ {
    
    if (!_refreshUISubjectTJ) _refreshUISubjectTJ = [RACSubject subject];
    
    return _refreshUISubjectTJ;
}

- (RACSubject *)refreshUISubjectPJ {
    
    if (!_refreshUISubjectPJ) _refreshUISubjectPJ = [RACSubject subject];
    
    return _refreshUISubjectPJ;
}
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}

- (RACSubject *)lookSubject {
    
    if (!_lookSubject) _lookSubject = [RACSubject subject];
    
    return _lookSubject;
}
- (RACSubject *)moreSubject {
    
    if (!_moreSubject) _moreSubject = [RACSubject subject];
    
    return _moreSubject;
}


- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_ANLIE_XINXI
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)refreshDataCommandTP {
    
    if (!_refreshDataCommandTP) {
        @weakify(self);
        _refreshDataCommandTP = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_ANLIE_TP
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _refreshDataCommandTP;
}
- (RACCommand *)refreshDataCommandTJ {
    
    if (!_refreshDataCommandTJ) {
        @weakify(self);
        _refreshDataCommandTJ = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_ANLIE_TJ
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _refreshDataCommandTJ;
}
- (RACCommand *)refreshDataCommandPJ {
    
    if (!_refreshDataCommandPJ) {
        @weakify(self);
        _refreshDataCommandPJ = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_ANLIE_PJ
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _refreshDataCommandPJ;
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
    
    return requestSignal;
}


#pragma mark -  tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.xinxiModel != nil) {
//        return 1;
//    }
    return 4;
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        FindXinXiModel *model = self.xinxiModel;
        
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"OneTableViewCell") contentViewWidth:ScreenWidth];
    }
    if (indexPath.row == 1) {
        
        return self.dataArrayTP.count * 190 + 50;
    }
    if (indexPath.row == 2) {
        if (self.dataArrayTJ.count == 0) {
            
            return 0;
            
        }else if (self.dataArrayTJ.count < 4) {
            
            return 160 + 50;
            
        }else {
            return 2 * 160 + 50;
        }
        
    }
    if (indexPath.row == 3) {
        if (self.dataArrayPJ.count == 0) {
            return 200;
        }
        return 400;
        
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
        OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"OneTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        if (self.xinxiModel) {
            [[[cell.lookBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
                [self.lookSubject sendNext:@(self.xinxiModel.id)];
                
            }];
            
            cell.model = self.xinxiModel;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }if (indexPath.row == 1) {
        
        QianTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QianTwoTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"QianTwoTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        [[[cell.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self.moreSubject sendNext:x];
            
        }];
        cell.dataArrayTP = self.dataArrayTP;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.row == 2) {
        
        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TwoTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.selectItemSubject sendNext:x];
            
        }];
        
        cell.dataArrayTJ = self.dataArrayTJ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.row == 3) {
        
        ThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ThreeTableViewCell" owner:nil options:nil].firstObject;
        }
        
         
        cell.dataArrayPJ = self.dataArrayPJ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}

@end
