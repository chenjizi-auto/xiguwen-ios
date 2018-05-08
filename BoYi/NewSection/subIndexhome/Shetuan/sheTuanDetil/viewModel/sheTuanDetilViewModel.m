//
//  ShetuanDetilViewModel.m
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShetuanDetilViewModel.h"
#import "ShetuanDetilTableViewCell.h"
#import "ShetuanDetilHeaderView.h"
//动态
#import "DongtaiHeaderTableViewCell.h"
#import "DongtaiTableViewCell.h"
//成员
#import "ChengyuanOneTableViewCell.h"
#import "ChengyuanTwoTableViewCell.h"
#import "ChengyuanThreeTableViewCell.h"
//作品
#import "ZuopinOneTableViewCell.h"
#import "ZuopinTwoTableViewCell.h"
//联系
#import "LianxiOneTableViewCell.h"
#import "LianxiThreeTableViewCell.h"
#import "HuifuiPL.h"

@implementation ShetuanDetilViewModel

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
        //请求成功
        [self.zuopinDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.zuopinUISubject sendNext:x];
        }];
        //请求成功
        [self.chengyuanDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.chengyuanUISubject sendNext:x];
        }];
        //请求成功
        [self.lianxifangshiDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.lianxifangshiUISubject sendNext:x];
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
 
            [self.guanzhuUISubject sendNext:x];
        }];
        [self.deleguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.guanzhuUISubject sendNext:x];
            
        }];
        [[self.dianzanCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        [self.dianzanCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
           
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
//- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
//    
//    if (!self.dataArray) self.dataArray = [NSMutableArray array];
//    if (isHeaderRefersh) [self.dataArray removeAllObjects];
//    
//    [self.dataArray addObjectsFromArray:[ShetuanDetilViewModel mj_objectArrayWithKeyValuesArray:object]];
//    
//}


#pragma mark - private


- (RACSubject *)guanzhuUISubject {
    
    if (!_guanzhuUISubject) _guanzhuUISubject = [RACSubject subject];
    
    return _guanzhuUISubject;
}

- (RACSubject *)zuopinUISubject {
    
    if (!_zuopinUISubject) _zuopinUISubject = [RACSubject subject];
    
    return _zuopinUISubject;
}
- (RACSubject *)chengyuanUISubject {
    
    if (!_chengyuanUISubject) _chengyuanUISubject = [RACSubject subject];
    
    return _chengyuanUISubject;
}
- (RACSubject *)lianxifangshiUISubject {
    
    if (!_lianxifangshiUISubject) _lianxifangshiUISubject = [RACSubject subject];
    
    return _lianxifangshiUISubject;
}
- (RACSubject *)isNavViewSubject {
    
    if (!_isNavViewSubject) _isNavViewSubject = [RACSubject subject];
    
    return _isNavViewSubject;
}
- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}

- (RACSubject *)pinglunUISubject {
    
    if (!_pinglunUISubject) _pinglunUISubject = [RACSubject subject];
    
    return _pinglunUISubject;
}


- (RACSubject *)pinglunseleUISubject {
    
    if (!_pinglunseleUISubject) _pinglunseleUISubject = [RACSubject subject];
    
    return _pinglunseleUISubject;
}

- (RACSubject *)selectRenSubject {
    
    if (!_selectRenSubject) _selectRenSubject = [RACSubject subject];
    
    return _selectRenSubject;
}
- (RACSubject *)selectZuopinSubject {
    
    if (!_selectZuopinSubject) _selectZuopinSubject = [RACSubject subject];
    
    return _selectZuopinSubject;
}
- (RACSubject *)selectLianxiRenmSubject {
    
    if (!_selectLianxiRenmSubject) _selectLianxiRenmSubject = [RACSubject subject];
    
    return _selectLianxiRenmSubject;
}
- (RACSubject *)loginubject {
    
    if (!_loginubject) _loginubject = [RACSubject subject];
    
    return _loginubject;
}

//index
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shetuanDetilindex
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
//作品
- (RACCommand *)zuopinDataCommand {
    
    if (!_zuopinDataCommand) {
        @weakify(self);
        _zuopinDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shetuanDetilzuopin
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _zuopinDataCommand;
}
//成员
- (RACCommand *)chengyuanDataCommand {
    
    if (!_chengyuanDataCommand) {
        @weakify(self);
        _chengyuanDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shetuanDetilchengyuan
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _chengyuanDataCommand;
}
//联系
- (RACCommand *)lianxifangshiDataCommand {
    
    if (!_lianxifangshiDataCommand) {
        @weakify(self);
        _lianxifangshiDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shetuanDetillianxifangshi
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _lianxifangshiDataCommand;
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
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        if (self.markType == 0) {
            return self.modelIndex.dynamiclist.count + 1;
            
        }else if (self.markType == 1){
            return 2 + self.modelChengyuan.chengyuan.count;
        }else if (self.markType == 2){
            return 2;
        }else {
            return 2 + self.modellianxi.chengyuan.count;
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 265;
    }else {
        if (self.markType == 0) {
            if (indexPath.row > 0) {

                NSString *content = self.modelIndex.dynamiclist[indexPath.row - 1].content;
                CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(ScreenWidth - 32, CGFLOAT_MAX)];
                NSInteger zhangshu;
                if (self.modelIndex.dynamiclist[indexPath.row - 1].pics.count == 0) {
                    zhangshu = 0;
                }else if (self.modelIndex.dynamiclist[indexPath.row - 1].pics.count > 0 && self.modelIndex.dynamiclist[indexPath.row - 1].pics.count < 4) {
                    zhangshu = 1;
                }else if (self.modelIndex.dynamiclist[indexPath.row - 1].pics.count > 3 && self.modelIndex.dynamiclist[indexPath.row - 1].pics.count < 7) {
                    zhangshu = 2;
                }else {
                    zhangshu = 3;
                }
                return size.height +  64 + 12 + 55 + 120 * zhangshu;
            }
            return 20;
        }else if (self.markType == 1){
            if (indexPath.row == 0) {
                return 114 + 8;
            }else if (indexPath.row == 1) {
                return 47;
            }else {
                return 67;
            }
        }else if (self.markType == 2){
            if (indexPath.row == 0) {
                NSString *content = self.modelZuopin.chuangshiren.weddingdescribe;
                CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(ScreenWidth - 32, CGFLOAT_MAX)];
                return 442;
            }else {
                return 220 * (self.modelZuopin.chengyuan.count / 2 + self.modelZuopin.chengyuan.count % 2)+ 1;
            }
        }else {
            if (indexPath.row == 0) {
                return 106;
            }else{
                return 50;
            }
        }
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 44;
    }
    
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if (section == 1) {
        ShetuanDetilHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"ShetuanDetilHeaderView" owner:nil options:nil].firstObject;
        header.frame = CGRectMake(0, 0, ScreenWidth, 44);
        header.markType = self.markType;
        @weakify(self);
        [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            
            switch ([x integerValue]) {
                case 0:
                    self.markType = 0;
                    break;
                case 1:
                    self.markType = 1;
                    break;
                case 2: {
                    self.markType = 2;
                    break;
                }
                case 3: {
                    self.markType = 3;
                    break;
                }
                default:
                    break;
            }
            
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
            
        }];
        return header;
    }
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ShetuanDetilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShetuanDetilTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ShetuanDetilTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.model = self.modelIndex;
        return  cell;
    }else {
        if (self.markType == 0) {
            if (indexPath.row == 0) {
                
                DongtaiHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DongtaiHeaderTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"DongtaiHeaderTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.name.text = [NSString stringWithFormat:@"全部动态（%ld）",self.modelIndex.dynamiclist.count];
                return  cell;
            }else {
                
                DongtaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DongtaiTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"DongtaiTableViewCell" owner:nil options:nil].firstObject;
                }

                NSInteger zhangshu;
                if (self.modelIndex.dynamiclist[indexPath.row - 1].pics.count == 0) {
                    zhangshu = 0;
                }else if (self.modelIndex.dynamiclist[indexPath.row - 1].pics.count > 0 && self.modelIndex.dynamiclist[indexPath.row - 1].pics.count < 4) {
                    zhangshu = 1;
                }else if (self.modelIndex.dynamiclist[indexPath.row - 1].pics.count > 3 && self.modelIndex.dynamiclist[indexPath.row - 1].pics.count < 7) {
                    zhangshu = 2;
                }else {
                    zhangshu = 3;
                }

                cell.collectionHeight.constant = 120 * zhangshu;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.modelIndex.dynamiclist[indexPath.row - 1];
                
                @weakify(self);
                [[[cell.dianzanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    
                    @strongify(self);
                    Dynamiclist *model = self.modelIndex.dynamiclist[indexPath.row - 1];
                    
                    if (model.myzan) {
                        [NavigateManager showMessage:@"您已点过赞"];
                        return ;
                    }
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                    [dic setValue:[NSString stringWithFormat:@"%ld",model.id] forKey:@"id"];
                    [self.dianzanCommand execute:dic];
                    self.modelIndex.dynamiclist[indexPath.row - 1].myzan = 1;
                }];
                [[[cell.pinglunBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    Dynamiclist *model = self.modelIndex.dynamiclist[indexPath.row - 1];
                    @strongify(self);
                    [self.pinglunseleUISubject sendNext:@(model.id)];
                }];
                [[[cell.isGunazhuBTn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    
                    @strongify(self);
                    
                    if (![UserDataNew UserLoginState]) {
                        [self.loginubject sendNext:nil];
                        return ;
                    }
                    Dynamiclist *model = self.modelIndex.dynamiclist[indexPath.row - 1];
                    [cell.isGunazhuBTn setImage:[UIImage imageNamed:model.follow ? @"加关注":@"取消关注"] forState:UIControlStateNormal];
                    if (model.follow == 1) {//已关注
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",model.userid] forKey:@"id"];
                        [self.deleguanzhuCommand execute:dic];
                      
                        
                    }else {//关注
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",model.userid] forKey:@"id"];
                        [self.addguanzhuCommand execute:dic];
                      
                    }

                }];
                return  cell;
            }
            
        }else if (self.markType == 1){
            
            if (indexPath.row == 0) {
                
                
                ChengyuanOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChengyuanOneTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ChengyuanOneTableViewCell" owner:nil options:nil].firstObject;
                }
                [cell.headerimage sd_setImageWithUrl:self.modelChengyuan.chuangshiren.head placeHolder:[UIImage imageNamed:@"头像"]];
                cell.name.text = [NSString stringWithFormat:@"%@",self.modelChengyuan.chuangshiren.nickname];
                cell.zhiwei.text = [NSString stringWithFormat:@"%@",self.modelChengyuan.chuangshiren.occupation];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }else if (indexPath.row == 1) {
                ChengyuanTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChengyuanTwoTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ChengyuanTwoTableViewCell" owner:nil options:nil].firstObject;
                }
                return  cell;
            }else {
                ChengyuanThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChengyuanThreeTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ChengyuanThreeTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.model = self.modelChengyuan.chengyuan[indexPath.row - 2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }
        }else if (self.markType == 2){
            if (indexPath.row == 0) {
                ZuopinOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZuopinOneTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ZuopinOneTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.modelZuopin.chuangshiren;
                return  cell;
                
            }else {
                ZuopinTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZuopinTwoTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ZuopinTwoTableViewCell" owner:nil options:nil].firstObject;
                }
                @weakify(self);
                [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                    @strongify(self);
                    NSInteger i = [x integerValue];
                    [self.selectZuopinSubject sendNext:@(i)];
                }];
                
                cell.model = self.modelZuopin;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }
        }else {
            if (indexPath.row == 0) {
                
                LianxiOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LianxiOneTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"LianxiOneTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.model = self.modellianxi.chuangshiren;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }else if (indexPath.row == 1){
                ChengyuanTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChengyuanTwoTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ChengyuanTwoTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }else {
                LianxiThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LianxiThreeTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"LianxiThreeTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.model = self.modellianxi.chengyuan[indexPath.row - 2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }
        }
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

    }else {
        if (self.markType == 0) {
            if (indexPath.row == 0) {
            }else {
                [self.selectItemSubject sendNext:self.modelIndex.dynamiclist[indexPath.row - 1]];
            }
        }else if (self.markType == 1){
            if (indexPath.row == 0) {
                NSDictionary *dic = @{@"userid":S_Integer(self.modelChengyuan.chuangshiren.userid),@"usertype":S_Integer(self.modelChengyuan.chuangshiren.usertype)};
                
                [self.selectRenSubject sendNext:dic];
            }else if (indexPath.row == 1) {
                
            }else {
                
                
                NSDictionary *dic = @{@"userid":S_Integer(self.modelChengyuan.chengyuan[indexPath.row - 2].userid)
                                          ,@"usertype":S_Integer(self.modelChengyuan.chengyuan[indexPath.row - 2].usertype)};
                [self.selectRenSubject sendNext:dic];
            }
        }else if (self.markType == 2){
            if (indexPath.row == 0) {
                
                [self.selectZuopinSubject sendNext:@(self.modelZuopin.chuangshiren.userid)];
                
            }else {
                
            }
        }else {
            if (indexPath.row == 0) {
                [self.selectLianxiRenmSubject sendNext:self.modellianxi.chuangshiren.mobile];
                
            }else if (indexPath.row == 1){
                
            }else {
                [self.selectLianxiRenmSubject sendNext:self.modellianxi.chengyuan[indexPath.row - 2].mobile];

            }
        }
    }
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    int i = scrollView.contentOffset.y;
//    [self.isNavViewSubject sendNext:@(i)];
//
//}
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

//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
//{
//    return self.modelIndex.count > 0  && self.dataArray;
//}
//
//- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
//{
//    return YES;
//}
//
//- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
//{
//    return YES;
//}
@end



