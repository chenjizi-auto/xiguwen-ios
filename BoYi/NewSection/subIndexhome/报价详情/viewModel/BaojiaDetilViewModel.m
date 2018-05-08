//
//  BaojiaDetilViewModel.m
//  BoYi
//
//  Created by heng on 2017/12/23.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "BaojiaDetilViewModel.h"
#import "BaojiaDetilTableViewCell.h"
#import "BaojiaDetilTwoTableViewCell.h"
#import "BaojiaNewThreeTableViewCell.h"
#import "LookMingxiNewViewController.h"

@implementation BaojiaDetilViewModel

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

    self.model = [BaojiaDetilModel mj_objectWithKeyValues:object];
    
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
- (RACSubject *)lookSubject {
    
    if (!_lookSubject) _lookSubject = [RACSubject subject];
    
    return _lookSubject;
}
- (RACSubject *)deleteguanzhuUISubject {
    
    if (!_deleteguanzhuUISubject) _deleteguanzhuUISubject = [RACSubject subject];
    
    return _deleteguanzhuUISubject;
}
- (RACSubject *)addguanUISubject {
    
    if (!_addguanUISubject) _addguanUISubject = [RACSubject subject];
    
    return _addguanUISubject;
}
- (RACCommand *)deleguanzhuCommand {
    
    if (!_deleguanzhuCommand) {
        @weakify(self);
        _deleguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:[HOMEURL stringByAppendingString:@"appapi/Follow/qgzbaojia"]
                                      loading:@""
                                Authorization:@""
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
            return [self requestSignalWithUrl:[HOMEURL stringByAppendingString:@"appapi/Follow/gzbaojia"]
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _addguanzhuCommand;
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
                                                                            //
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
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_baojiaDetil
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}

#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 605;
    }else if (indexPath.row == 1){
        CGFloat cellWidth = ScreenWidth - 32;
        NSString *content = self.model.baojia.content;
        CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
        return size.height + 50 + 265 * self.model.baojia.imglist.count;
    }else {
        NSInteger index = self.model.youlike.count / 2 + self.model.youlike.count % 2;
        return 75 + 185 * index;
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
    if (indexPath.row == 0) {

        BaojiaDetilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaojiaDetilTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"BaojiaDetilTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        [[[cell.lookbtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self.lookSubject sendNext:nil];
        }];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 1) {
        BaojiaDetilTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaojiaDetilTwoTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"BaojiaDetilTwoTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        
        return  cell;
    }else {
        BaojiaNewThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaojiaNewThreeTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"BaojiaNewThreeTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.selectItemSubject sendNext:x];
            
        }];
        
        return  cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}

@end
