//
//  ShangchengQuanViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengQuanViewModel.h"
//#import "HunqinQuanTableViewCell.h"
#import "CXHunqingquanTableViewCell.h"
static NSString *CXHunqingquanTableViewCellIndentifier = @"CXHunqingquanTableViewCellIndentifier";

@implementation ShangchengQuanViewModel

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
        [self.fenleilistDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.fenleilistUISubject sendNext:x];
        }];
        [self.addguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            self.selectModel.follow = 1;
            [self.refreshdateSubject sendNext:@YES];
        }];
        [self.deleguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            self.selectModel.follow = 0;
            [self.refreshdateSubject sendNext:@NO];
        }];
        [self.dianzanCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            self.selectModel.shifouzan = 1;
            self.selectModel.zan += 1;
            [self.dianzanSubject sendNext:@YES];
        }];
        [self.deleteDianzanCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            self.selectModel.shifouzan = 0;
            self.selectModel.zan -= 1;
            [self.dianzanSubject sendNext:@NO];
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
    
    [self.dataArray addObjectsFromArray:[Hunqinnewarray mj_objectArrayWithKeyValuesArray:object]];
    
}



#pragma mark - private

- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}
- (RACSubject *)pinglunseleUISubject {
    
    if (!_pinglunseleUISubject) _pinglunseleUISubject = [RACSubject subject];
    
    return _pinglunseleUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)fenleilistUISubject {
    
    if (!_fenleilistUISubject) _fenleilistUISubject = [RACSubject subject];
    
    return _fenleilistUISubject;
}
- (RACSubject *)dianzanSubject {
    if (!_dianzanSubject) {
        _dianzanSubject = [RACSubject subject];
    }
    return _dianzanSubject;
}
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_faxianshangcheng
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)fenleilistDataCommand {
    
    if (!_fenleilistDataCommand) {
        @weakify(self);
        _fenleilistDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_indexfenleilist
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _fenleilistDataCommand;
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
- (RACSubject *)refreshdateSubject {
    
    if (!_refreshdateSubject) _refreshdateSubject = [RACSubject subject];
    
    return _refreshdateSubject;
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    CGFloat partwid = (cxwid - 48) / 3;
    NSString *des = self.dataArray[row].content;
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGSize size = [des boundingRectWithSize:CGSizeMake(cxwid - 32, 1000000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    NSInteger sizehit = ceilf(size.height);
    
    CGFloat topdis = 10 + sizehit + 64 + (10 + partwid) * ((self.dataArray[row].photourl.count - 1) / 3 + 1);
    if (self.dataArray[row].photourl.count == 0) {
        topdis = 10 + sizehit + 64;
    }
    NSLog(@"count = %ld",self.dataArray[row].photourl.count);
    return  topdis + 40;
    //    CGFloat cellWidth = ScreenWidth - 32;
    //    CGSize size = [self.dataArray[indexPath.row].content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
    //    NSInteger zhangshu;
    //    if (self.dataArray[indexPath.row].photourl.count == 0) {
    //        zhangshu = 0;
    //    }else if (self.dataArray[indexPath.row].photourl.count > 0 && self.dataArray[indexPath.row].photourl.count < 4) {
    //        zhangshu = 1;
    //    }else if (self.dataArray[indexPath.row].photourl.count > 3 && self.dataArray[indexPath.row].photourl.count < 7) {
    //        zhangshu = 2;
    //    }else {
    //        zhangshu = 3;
    //    }
    //    return 64 + 55 + 13 + size.height + 110 * zhangshu;
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
    NSInteger row = indexPath.row;
    Hunqinnewarray *model = self.dataArray[row];
    CXHunqingquanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CXHunqingquanTableViewCellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.partTpaed = ^(NSString *typeName) {
    //        if ([typeName isEqual:@"see"]) {
    //
    //        }
    //        else if ([typeName isEqual:@"talk"]){
    //
    //        }
    //        else if ([typeName isEqual:@"good"]){
    //
    //        }
    //        else if ([typeName isEqual:@"care"]){
    //
    //        }
    //    };
    
    @weakify(self);
    
    [[[cell.goods rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        if (![UserDataNew UserLoginState]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserNotLoginIn_ToLogin" object:nil];
            return;
        }
        self.selectModel = model;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:[NSString stringWithFormat:@"%ld",model.id] forKey:@"id"];
        if (model.shifouzan == 1) {
            [self.deleteDianzanCommand execute:dic];
        } else {
            [self.dianzanCommand execute:dic];
        }
        
    }];
    //    [[[cell.talks rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
    //
    //        @strongify(self);
    //        [self.pinglunseleUISubject sendNext:@(model.id)];
    //    }];
    [[[cell.careBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        if (![UserDataNew UserLoginState]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserNotLoginIn_ToLogin" object:nil];
            return;
        }
        if (model.userid == [UserDataNew sharedManager].userInfoModel.user.userid) {
            [NavigateManager showMessage:@"不能关注自己哦~"];
            return;
        }
        self.selectModel = model;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:[NSString stringWithFormat:@"%ld",model.userid] forKey:@"id"];
        
        
        if (model.follow == 1) {//已关注
            
            [self.deleguanzhuCommand execute:dic];
        }else {//关注
            
            [self.addguanzhuCommand execute:dic];
        }
        
    }];
    
    WeakSelf(self);
    [cell setOnSelectedImg:^(NSInteger index) {
        NSMutableArray *arr = [NSMutableArray array];
        for (PhotourlFaxian *model1 in model.photourl) {
            [arr addObject:model1.photourl];
        }
        weakSelf.onSelectedImage(arr, index);
    }];
    cell.onSelectedHeader = ^{
        weakSelf.onSelectedHeader(model.userid);
    };
    [cell loadwithModel:model];
    return cell;
    //    HunqinQuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinQuanTableViewCell"];
    //    cell.model = self.dataArray[indexPath.row];
    //
    //    @weakify(self);
    //    Hunqinnewarray *model = self.dataArray[indexPath.row];
    //    [[[cell.dianzanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
    //
    //        @strongify(self);
    //
    //
    //        if (model.myzan) {
    //            [NavigateManager showMessage:@"您已点过赞"];
    //            return ;
    //        }
    //        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    //        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    //        [dic setValue:[NSString stringWithFormat:@"%ld",model.id] forKey:@"id"];
    //        [self.dianzanCommand execute:dic];
    //
    //    }];
    //    [[[cell.pinglunBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
    //
    //        @strongify(self);
    //        [self.pinglunseleUISubject sendNext:@(model.id)];
    //    }];
    //    [[[cell.guanzhuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
    //
    //        @strongify(self);
    //
    //        [cell.guanzhuBtn setImage:[UIImage imageNamed:model.follow ? @"加关注":@"取消关注"] forState:UIControlStateNormal];
    //        if (model.follow == 1) {//已关注
    //            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    //            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    //            [dic setValue:[NSString stringWithFormat:@"%ld",model.userid] forKey:@"id"];
    //            [self.deleguanzhuCommand execute:dic];
    //
    //
    //        }else {//关注
    //            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    //            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    //            [dic setValue:[NSString stringWithFormat:@"%ld",model.userid] forKey:@"id"];
    //            [self.addguanzhuCommand execute:dic];
    //        }
    //
    //    }];
    //    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

