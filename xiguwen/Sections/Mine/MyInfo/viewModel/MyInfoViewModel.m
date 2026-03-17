//
//  MyInfoViewModel.m
//  BoYi
//
//  Created by Chen on 2017/8/13.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyInfoViewModel.h"
#import "MyInfoTableViewCell.h"

@implementation MyInfoViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.dataArray = @[@"头像",@"昵称：",@"手机号：",@"性别：",@"密码"].mutableCopy;
    
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
    
    [self.dataArray addObjectsFromArray:[MyInfoModel mj_objectArrayWithKeyValuesArray:object]];
    
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
            return [self requestSignalWithUrl:@""
                                      loading:@""
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
    
    return [[RequestManager sharedManager] requestSignalWithUrl:url loading:loading Authorization:Authorization info:info];
    
//    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        
//        
//        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
//                                                                         method:GET
//                                                                         loding:loading
//                                                                            dic:info
//                                                                  Authorization:Authorization
//                                                                        success:^(NSURLSessionDataTask *task, id response) {
//                                                                            //                                                                        if(response) {
//                                                                            // 可封装为请求正确，但是校验未通过处理
//                                                                            //                                                                            if ([response[@"code"] integerValue] == 1) {
//                                                                            //                                                                                [subscriber sendNext:nil];
//                                                                            //                                                                                [subscriber sendError:[NSError errorWithDomain:@"com.saitjr.demo" code:1 userInfo:@{@"msg":@"没数据啦"}]];
//                                                                            //                                                                                return;
//                                                                            //                                                                            } else {
//                                                                            [subscriber sendNext:response];
//                                                                            [subscriber sendCompleted];
//                                                                            //                                                                            }
//                                                                            //                                                                        }
//                                                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                                                            // 如果网络请求出错，则加载数据库中的旧数据
//                                                                            
//                                                                            [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
//                                                                            [subscriber sendCompleted];
//                                                                        }];
//        // 在信号量作废时，取消网络请求
//        return [RACDisposable disposableWithBlock:^{
//            [task cancel];
//        }];
//    }];
//    //    [requestSignal throttle:1];
//    return requestSignal;
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
    
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoTableViewCell"];
    cell.name.text = self.dataArray[indexPath.row];
    
    cell.value.text = @"";
    
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.header.hidden = NO;
        cell.desc.hidden = YES;
        if ([UserData sharedManager].userInfoModel.avatar) {
            [cell.header sd_setImageWithUrl:ImageAppendURL([UserData sharedManager].userInfoModel.avatar)];
        }
        
        
    } else {
        cell.header.hidden = YES;
        cell.desc.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
        switch (indexPath.row) {
            case 1: {
               cell.desc.text = @"修改昵称";
                cell.value.text = [UserData sharedManager].userInfoModel.cnName;
            }break;
            case 2:{
                cell.desc.text = @"";
                cell.value.text = [UserData sharedManager].userInfoModel.username;
            } break;
            case 3:{
                cell.value.text = [[UserData sharedManager].userInfoModel.sex integerValue] == 2 ? @"女" : @"男";
                cell.desc.text = @"修改性别";
            } break;
            case 4: {
                cell.desc.text = @"修改密码";
            } break;
                
            default:
                break;
        }
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.selectItemSubject sendNext:@(indexPath.row)];
}

@end
