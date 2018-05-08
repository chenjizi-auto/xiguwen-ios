//
//  DongtaiDetilViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "DongtaiDetilViewModel.h"
#import "DongtaiDetilTableViewCell.h"
#import "DongraiDetilHeader.h"
#import "PinglunTableViewCell.h"

@implementation DongtaiDetilViewModel

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
        [self.addguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.addguanzhuSubject sendNext:x];
        }];
        [self.deleguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.deleguanzhuSubject sendNext:x];
        }];
        [self.dianzanCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshdateSubject sendNext:@YES];
        }];
        [self.deleteDianzanCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshdateSubject sendNext:@NO];
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
    
    self.model = [DongtaiDetilModel mj_objectWithKeyValues:object];
    
}


#pragma mark - private



- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}
- (RACSubject *)addguanzhuSubject {
    
    if (!_addguanzhuSubject) _addguanzhuSubject = [RACSubject subject];
    
    return _addguanzhuSubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)pinglunseleUISubject {
    
    if (!_pinglunseleUISubject) _pinglunseleUISubject = [RACSubject subject];
    
    return _pinglunseleUISubject;
}
- (RACSubject *)refreshdateSubject {
    
    if (!_refreshdateSubject) _refreshdateSubject = [RACSubject subject];
    
    return _refreshdateSubject;
}
- (RACSubject *)deleguanzhuSubject {
    
    if (!_deleguanzhuSubject) _deleguanzhuSubject = [RACSubject subject];
    
    return _deleguanzhuSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_dongtaiDetil
                                                          method:POST
                                                          loding:@""
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
            return [self requestSignalWithUrl:URL_deleGuanzhu
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
            return [self requestSignalWithUrl:URL_ADDUserFollowById
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _addguanzhuCommand;
}
- (RACCommand *)dianzanCommand {
    
    if (!_dianzanCommand) {
        @weakify(self);
        _dianzanCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_dianzan
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _dianzanCommand;
}
- (RACCommand *)deleteDianzanCommand {
    
    if (!_deleteDianzanCommand) {
        @weakify(self);
        _deleteDianzanCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Found/qxlikes"]
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _deleteDianzanCommand;
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
#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isPinglun) {
        NSInteger x = self.model.commentlist.count;
        return x;
    }else {
        NSInteger x = self.model.zanlist.count;
        return x;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isPinglun) {
        CommentlistDongtai *model = self.model.commentlist[indexPath.row];
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"PinglunTableViewCell") contentViewWidth:ScreenWidth] + 8;
    }else {
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        NSInteger zhangshu;
//        if (self.model.photourl.count == 0) {
//            zhangshu = 0;
//        }else if (self.model.photourl.count > 0 && self.model.photourl.count < 4) {
//            zhangshu = 1;
//        }else if (self.model.photourl.count > 3 && self.model.photourl.count < 7) {
//            zhangshu = 2;
//        }else {
//            zhangshu = 3;
//        }
//        
//        CGFloat cellWidth = ScreenWidth - 32;
//        CGSize size = [self.model.content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
//        
//        
//        return 64 + 75 + 13 + size.height + 110 * zhangshu;
//    }
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
//        DongraiDetilHeader *header = [[NSBundle mainBundle]loadNibNamed:@"DongraiDetilHeader" owner:nil options:nil].firstObject;
//
//
//        NSInteger zhangshu;
//        if (self.model.photourl.count == 0) {
//            zhangshu = 0;
//        }else if (self.model.photourl.count > 0 && self.model.photourl.count < 4) {
//            zhangshu = 1;
//        }else if (self.model.photourl.count > 3 && self.model.photourl.count < 7) {
//            zhangshu = 2;
//        }else {
//            zhangshu = 3;
//        }
//
//        CGFloat cellWidth = ScreenWidth - 32;
//        CGSize size = [self.model.content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
//
//
//        header.frame = CGRectMake(0, 0, ScreenWidth, 64 + 75 + 13 + size.height + 110 * zhangshu);
//
//        @weakify(self);
//        [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
//            @strongify(self);
//            if ([x integerValue] == 0) {
//
//                return ;
//            }else if ([x integerValue] == 1){
//                self.isPinglun = 1;
//            }else {
//                self.isPinglun = 0;
//            }
//
//            NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:0];    //刷新第3段
//            [tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
//        }];
//        [header.gotoNextVc1 subscribeNext:^(id  _Nullable x) {
//            @strongify(self);
//
//            [header.guanzhuBtn setImage:[UIImage imageNamed:self.model.follow ? @"加关注":@"取消关注"] forState:UIControlStateNormal];
//            if (self.model.follow == 1) {//已关注
//                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
//                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
//                [dic setValue:[NSString stringWithFormat:@"%ld",self.model.userid] forKey:@"id"];
//                [self.deleguanzhuCommand execute:dic];
//
//
//            }else {//关注
//                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
//                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
//                [dic setValue:[NSString stringWithFormat:@"%ld",self.model.userid] forKey:@"id"];
//                [self.addguanzhuCommand execute:dic];
//            }
//        }];
//
//        header.model = self.model;
//        return header;
    }
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isPinglun) {
        
        PinglunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PinglunTableViewCell"];
        cell.model = self.model.commentlist[indexPath.row];
        return  cell;
    }
    DongtaiDetilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DongtaiDetilTableViewCell"];
    cell.model = self.model.zanlist[indexPath.row];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


@end
