//
//  NewShangjiaViewModel.m
//  BoYi
//
//  Created by heng on 2017/12/21.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewShangjiaViewModel.h"
#import "NewShangjiaTableViewCell.h"
#import "ShangjiaNewHeaderView.h"
#import "ShangjiaIndexTableViewCell.h"
#import "ShangjianewTwoTableViewCell.h"
#import "ShangjiaNewthreeTableViewCell.h"
#import "ShangjianewFourTableViewCell.h"
#import "teshupingjiaTableViewCell.h"
//报价
#import "BaojiaNewTableViewCell.h"
//作品
#import "ZuopinNewTableViewCell.h"
//评价
#import "PingjiaNewViewTableViewCell.h"
//动态
#import "DongtaiNewViewTableViewCell.h"
//资料
#import "ZiliaoNewTableViewCell.h"
//档期
#import "DangqiNewTableViewCell.h"
@implementation NewShangjiaViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        self.markType = 0;
        //处理正在请求状态
        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        //请求成功baojia
        [self.refreshBaojiaListDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.BaojiaListUISubject sendNext:x];
        }];
        //请求成功zuopin
        [self.refreZuopinListDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.ZuopinListUISubject sendNext:x];
        }];
        //请求成功动态
        [self.refreDongtaiListDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.DongtaiListUISubject sendNext:x];
        }];
        //请求成功档期
        [self.refredangqiListDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.dangqiUISubject sendNext:x];
        }];
        //请求成功资料
        [self.refreziliaoDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.ziliaoUISubject sendNext:x];
        }];
        //请求成功评论
        [self.refrepinglunDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.pinglunUISubject sendNext:x];
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
        [[self.dianzanCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        [self.dianzanCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.dianzansuessUISubject sendNext:x];
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
//首页
- (void)Convertin:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    
    if (!self.dataArrayPingjia) self.dataArrayPingjia = [NSMutableArray array];
    [self.dataArrayPingjia removeAllObjects];
    [self.dataArrayPingjia addObjectsFromArray:[Shangjiapinglun mj_objectArrayWithKeyValuesArray:object[@"data"]]];
    
    self.pingjiaNumber = [NSString stringWithFormat:@"%@",object[@"num"]];
    
}

- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    if (self.markType == 0) {
        self.model = [NewShangjiaModel mj_objectWithKeyValues:object];
    }else if (self.markType == 1) {
        
        if (!self.dataArrayBaojia) self.dataArrayBaojia = [NSMutableArray array];
        [self.dataArrayBaojia removeAllObjects];
        [self.dataArrayBaojia addObjectsFromArray:[Baojiashangjiafen mj_objectArrayWithKeyValuesArray:object[@"baojia"]]];
    }else if (self.markType == 2) {
        
        if (!self.dataArrayZuopin) self.dataArrayZuopin = [NSMutableArray array];
        [self.dataArrayZuopin removeAllObjects];
        [self.dataArrayZuopin addObjectsFromArray:[Zuopinnewfen mj_objectArrayWithKeyValuesArray:object]];
    }else if (self.markType == 3) {
//        if (!self.dataArrayPingjia) self.dataArrayPingjia = [NSMutableArray array];
//        if (isHeaderRefersh) [self.dataArrayPingjia removeAllObjects];
//        [self.dataArrayPingjia addObjectsFromArray:[Shangjiapinglun mj_objectArrayWithKeyValuesArray:object[@"data"]]];
//
//        self.pingjiaNumber = [NSString stringWithFormat:@"%@",object[@"num"]];
        
    }else if (self.markType == 4) {
        if (!self.dataArrayDongtai) self.dataArrayDongtai = [NSMutableArray array];
        [self.dataArrayDongtai removeAllObjects];
        [self.dataArrayDongtai addObjectsFromArray:[Dongtaiarray mj_objectArrayWithKeyValuesArray:object[@"data"]]];
        self.dongtaiNumber = [NSString stringWithFormat:@"%@",object[@"num"]];
        
    }else if (self.markType == 5) {
        if (!self.dataArrayDangqi) self.dataArrayDangqi = [NSMutableArray array];
        [self.dataArrayDangqi removeAllObjects];
        [self.dataArrayDangqi addObjectsFromArray:[Dangqinnewarray mj_objectArrayWithKeyValuesArray:object]];
    }else {
        self.shangjiaModel = [shangjiaZiliaoModel mj_objectWithKeyValues:object];
    }
    
}

#pragma mark - private
//首页
- (RACSubject *)shouyeSubject {
    
    if (!_shouyeSubject) _shouyeSubject = [RACSubject subject];
    
    return _shouyeSubject;
}
//报价
- (RACSubject *)baojiaSubject {
    
    if (!_baojiaSubject) _baojiaSubject = [RACSubject subject];
    
    return _baojiaSubject;
}
//作品
- (RACSubject *)zuopinSubject {
    
    if (!_zuopinSubject) _zuopinSubject = [RACSubject subject];
    
    return _zuopinSubject;
}
//评价
- (RACSubject *)pingjiaSubject {
    
    if (!_pingjiaSubject) _pingjiaSubject = [RACSubject subject];
    
    return _pingjiaSubject;
}
//动态
- (RACSubject *)dongtaiSubject {
    
    if (!_dongtaiSubject) _dongtaiSubject = [RACSubject subject];
    
    return _dongtaiSubject;
}
//档期
- (RACSubject *)dangqiSubject {
    
    if (!_dangqiSubject) _dangqiSubject = [RACSubject subject];
    
    return _dangqiSubject;
}
- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)iphoneSubject {
    
    if (!_iphoneSubject) _iphoneSubject = [RACSubject subject];
    
    return _iphoneSubject;
}
- (RACSubject *)moreBaojiaSubject {
    
    if (!_moreBaojiaSubject) _moreBaojiaSubject = [RACSubject subject];
    
    return _moreBaojiaSubject;
}
- (RACSubject *)zuopinindexSubject {
    
    if (!_zuopinindexSubject) _zuopinindexSubject = [RACSubject subject];
    
    return _zuopinindexSubject;
}
- (RACSubject *)morezuopinSubject {
    
    if (!_morezuopinSubject) _morezuopinSubject = [RACSubject subject];
    
    return _morezuopinSubject;
}
- (RACSubject *)tuijianSubject {
    
    if (!_tuijianSubject) _tuijianSubject = [RACSubject subject];
    
    return _tuijianSubject;
}
- (RACSubject *)BaojiaListUISubject {
    
    if (!_BaojiaListUISubject) _BaojiaListUISubject = [RACSubject subject];
    
    return _BaojiaListUISubject;
}
- (RACSubject *)refreshUITypeSubject {
    
    if (!_refreshUITypeSubject) _refreshUITypeSubject = [RACSubject subject];
    
    return _refreshUITypeSubject;
}
- (RACSubject *)ZuopinListUISubject {
    
    if (!_ZuopinListUISubject) _ZuopinListUISubject = [RACSubject subject];
    
    return _ZuopinListUISubject;
}
- (RACSubject *)DongtaiListUISubject {
    
    if (!_DongtaiListUISubject) _DongtaiListUISubject = [RACSubject subject];
    
    return _DongtaiListUISubject;
}
- (RACSubject *)dangqiUISubject {
    
    if (!_dangqiUISubject) _dangqiUISubject = [RACSubject subject];
    
    return _dangqiUISubject;
}
- (RACSubject *)ziliaoUISubject {
    
    if (!_ziliaoUISubject) _ziliaoUISubject = [RACSubject subject];
    
    return _ziliaoUISubject;
}
- (RACSubject *)pinglunUISubject {
    
    if (!_pinglunUISubject) _pinglunUISubject = [RACSubject subject];
    
    return _pinglunUISubject;
}
- (RACSubject *)deleteguanzhuUISubject {
    
    if (!_deleteguanzhuUISubject) _deleteguanzhuUISubject = [RACSubject subject];
    
    return _deleteguanzhuUISubject;
}
- (RACSubject *)addguanUISubject {
    
    if (!_addguanUISubject) _addguanUISubject = [RACSubject subject];
    
    return _addguanUISubject;
}
- (RACSubject *)dianzanUISubject {
    
    if (!_dianzanUISubject) _dianzanUISubject = [RACSubject subject];
    
    return _dianzanUISubject;
}
- (RACSubject *)pinglunseleUISubject {
    
    if (!_pinglunseleUISubject) _pinglunseleUISubject = [RACSubject subject];
    
    return _pinglunseleUISubject;
}
- (RACSubject *)dianzansuessUISubject {
    
    if (!_dianzansuessUISubject) _dianzansuessUISubject = [RACSubject subject];
    
    return _dianzansuessUISubject;
}
- (RACSubject *)lookImageSubject {
    
    if (!_lookImageSubject) _lookImageSubject = [RACSubject subject];
    
    return _lookImageSubject;
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
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shangjiadetil
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)refreshBaojiaListDataCommand {
    
    if (!_refreshBaojiaListDataCommand) {
        @weakify(self);
        _refreshBaojiaListDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_baojialist
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshBaojiaListDataCommand;
}
- (RACCommand *)refreZuopinListDataCommand {
    
    if (!_refreZuopinListDataCommand) {
        @weakify(self);
        _refreZuopinListDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_zuopinlist
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreZuopinListDataCommand;
}
- (RACCommand *)refreDongtaiListDataCommand {
    
    if (!_refreDongtaiListDataCommand) {
        @weakify(self);
        _refreDongtaiListDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_New_dongtailist
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _refreDongtaiListDataCommand;
}
- (RACCommand *)refredangqiListDataCommand {
    
    if (!_refredangqiListDataCommand) {
        @weakify(self);
        _refredangqiListDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_dangqi
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refredangqiListDataCommand;
}
- (RACCommand *)refreziliaoDataCommand {
    
    if (!_refreziliaoDataCommand) {
        @weakify(self);
        _refreziliaoDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shangjiaziliao
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreziliaoDataCommand;
}
- (RACCommand *)refrepinglunDataCommand {
    
    if (!_refrepinglunDataCommand) {
        @weakify(self);
        _refrepinglunDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
//            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shangjiapinglun
//                                                          method:POST
//                                                          loding:@""
//                                                             dic:input];
            return [self requestSignalWithUrl:URL_New_shangjiapinglun
                               loading:@""
                         Authorization:@""
                                  info:input];
        }];
    }
    return _refrepinglunDataCommand;
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
            return 3;
            
        }else if (self.markType == 1){
            return 1;
        }else if (self.markType == 2){
            return 1;
        }else if (self.markType == 3){
            return 1 + self.dataArrayPingjia.count;
        }else if (self.markType == 4){
            return self.dataArrayDongtai.count + 1;
        }else if (self.markType == 5){
            return self.dataArrayDangqi.count;
        }else {
            return 1;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 398;
    }else {
        if (self.markType == 0) {
            if (indexPath.row == 0) {
                if (self.model.baojia.baojia.count == 0) {
                    return 47 ;
                }else if (self.model.baojia.baojia.count > 0 && self.model.baojia.baojia.count < 3) {
                    return 47 + 185;
                }else {
                    return 47 + 185 * 2;
                }
            }else if (indexPath.row == 1) {
                if (self.model.zuoping.zuopin.count == 0) {
                    return 47 ;
                }else if (self.model.zuoping.zuopin.count > 0 && self.model.zuoping.zuopin.count < 3) {
                    return 47  + 216;
                }else {
                    return 47  + 216 * 2;
                }
            }
//            else if (indexPath.row == 2) {
//                if (self.dataArrayPingjia.count > 0) {
//                    CGFloat cellWidth = ScreenWidth - 32;
//                    NSString *content = self.dataArrayPingjia[0].content;
//                    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
//                    
//                    NSString *content1 = self.dataArrayPingjia[0].replay_content;
//                    CGSize size1 = [content1 sizeWithFont:[UIFont systemFontOfSize:14] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
//                    int i = 0;
//                    if (self.dataArrayPingjia[0].pictures.count == 0) {
//                        i = 110 * 0;
//                    }else if (self.dataArrayPingjia[0].pictures.count > 0 && self.dataArrayPingjia[0].pictures.count < 4) {
//                        i = 110 * 1;
//                        
//                    }else if (self.dataArrayPingjia[0].pictures.count > 3 && self.dataArrayPingjia[0].pictures.count < 7) {
//                        i = 110 * 2;
//                    }else {
//                        i = 110 * 3;
//                    }
//                    return 93 + size1.height + size.height + i;
//                }else {
//                    return 0.00001;
//                }
//                
//            }
            else {
                if (self.model.tuijiantd.count == 0) {
                    return 48;
                }else if (self.model.tuijiantd.count > 0 && self.model.tuijiantd.count <4){
                    return 48 + 1 * 150;
                }else if (self.model.tuijiantd.count > 3 && self.model.tuijiantd.count < 7){
                    return 48 + 2 * 150;
                }else {
                    return 48 + 3 * 150;
                }
                
            }
            
        }else if (self.markType == 1){
            
            return 190 * (self.dataArrayBaojia.count % 2 + self.dataArrayBaojia.count /2) + 30;
        }else if (self.markType == 2){
            return 216 * (self.dataArrayZuopin.count % 2 + self.dataArrayZuopin.count /2) + 30 + 20;;
        }else if (self.markType == 3){
            if (indexPath.row == 0) {
                return 30;
            }else {
                
                
                CGFloat cellWidth = ScreenWidth - 32;
                NSString *content = self.dataArrayPingjia[indexPath.row - 1].content;
                CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
                
                NSString *content1 = self.dataArrayPingjia[indexPath.row - 1].replay_content;
                CGSize size1 = [content1 sizeWithFont:[UIFont systemFontOfSize:14] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
                int i = 0;
                if (self.dataArrayPingjia[indexPath.row - 1].pictures.count == 0) {
                    i = 110 * 0;
                }else if (self.dataArrayPingjia[indexPath.row - 1].pictures.count > 0 && self.dataArrayPingjia[indexPath.row - 1].pictures.count < 4) {
                    i = 110 * 1;
                    
                }else if (self.dataArrayPingjia[indexPath.row - 1].pictures.count > 3 && self.dataArrayPingjia[indexPath.row - 1].pictures.count < 7) {
                    i = 110 * 2;
                }else {
                    i = 110 * 3;
                }
                return 93 + size1.height + size.height + i;
                
            }
        }else if (self.markType == 4){
            
            if (indexPath.row == 0) {
                return 30;
            }else {
                CGFloat cellWidth = ScreenWidth - 32;
                NSString *content = self.dataArrayDongtai[indexPath.row - 1].content;
                CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
                int i = 0;
                if (self.dataArrayDongtai[indexPath.row - 1].photourl.count == 0) {
                    i = 110 * 0;
                }else if (self.dataArrayDongtai[indexPath.row - 1].photourl.count > 0 && self.dataArrayDongtai[indexPath.row - 1].photourl.count < 4) {
                    i = 110 * 1;
                    
                }else if (self.dataArrayDongtai[indexPath.row - 1].photourl.count > 3 && self.dataArrayDongtai[indexPath.row - 1].photourl.count < 7) {
                    i = 110 * 2;
                }else {
                    i = 110 * 3;
                }
                return 102 + 20 + size.height + i;
            }
        }else if (self.markType == 5){
            NSInteger i = 0;
            i = self.dataArrayDangqi[indexPath.row].dangqi.count;
            if (i == 0) {
                
                return 47;
            }else if (i > 0 && i < 7) {
                return 47 + 65;
            }else if (i > 7 && i < 15) {
                return 47 + 65 * 2;
            }else if (i > 14 && i < 22) {
                return 47 + 65 * 3;
            }else if (i > 21 && i < 29) {
                return 47 + 65 * 4;
            }else {
                return 47 + 65 * 5;
            }
        }else {
            return 300;
        }
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
        ShangjiaNewHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"ShangjiaNewHeaderView" owner:nil options:nil].firstObject;
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
                case 4: {
                    self.markType = 4;
                    break;
                }
                case 5: {
                    self.markType = 5;
                    break;
                }
                case 6: {
                    self.markType = 6;
                    break;
                }
                default:
                    break;
            }
            [self.refreshUITypeSubject sendNext:@(self.markType)];
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

        NewShangjiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewShangjiaTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewShangjiaTableViewCell" owner:nil options:nil].firstObject;
        }
        if (self.model) {
             cell.model = self.model;
        }
        @weakify(self);
        [[[cell.iphonebtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self.iphoneSubject sendNext:indexPath];
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else {
        if (self.markType == 0) {
            if (indexPath.row == 0) {//报价
                ShangjiaIndexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangjiaIndexTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ShangjiaIndexTableViewCell" owner:nil options:nil].firstObject;
                }
                @weakify(self);
                [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(id  _Nullable x) {
                    @strongify(self);
                    [self.shouyeSubject sendNext:x];
                    
                }];
//                [[[cell.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//                    @strongify(self);
//                    [self.moreBaojiaSubject sendNext:nil];
//                }];
//                [[[cell.moreBtnother rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//                    @strongify(self);
//                    [self.moreBaojiaSubject sendNext:nil];
//                }];
                cell.model = self.model;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }else if (indexPath.row == 1) {//作品
                ShangjianewTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangjianewTwoTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ShangjianewTwoTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.pingjiaNumber.text = [NSString stringWithFormat:@"全部评论（%@）",self.pingjiaNumber];
                @weakify(self);
                [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(id  _Nullable x) {
                    @strongify(self);
                    [self.zuopinindexSubject sendNext:x];
                    
                }];
                [[[cell.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    
                    @strongify(self);
                    [self.morezuopinSubject sendNext:nil];
                }];
                [[[cell.moreBtnother rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    
                    @strongify(self);
                    [self.morezuopinSubject sendNext:nil];
                }];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.model;
                return  cell;
            }
//            else if (indexPath.row == 2) {//评价
            
//                if (self.dataArrayPingjia.count > 0) {
//                    ShangjiaNewthreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangjiaNewthreeTableViewCell"];
//                    if (!cell)
//                    {
//                        cell = [[NSBundle mainBundle] loadNibNamed:@"ShangjiaNewthreeTableViewCell" owner:nil options:nil].firstObject;
//                    }
//                    if (self.dataArrayPingjia.count > 0) {
//                        cell.model = self.dataArrayPingjia[0];
//                    }
//
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                    return  cell;
//                }else {
//                    teshupingjiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teshupingjiaTableViewCell"];
//                    if (!cell)
//                    {
//                        cell = [[NSBundle mainBundle] loadNibNamed:@"teshupingjiaTableViewCell" owner:nil options:nil].firstObject;
//                    }
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                    return  cell;
//
//                }
                
//            }
            else {//推荐
                ShangjianewFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangjianewFourTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ShangjianewFourTableViewCell" owner:nil options:nil].firstObject;
                }
                @weakify(self);
                [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(id  _Nullable x) {
                    @strongify(self);
                    [self.tuijianSubject sendNext:x];
                    
                }];
                cell.model = self.model;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }
            
        }else if (self.markType == 1){
            BaojiaNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaojiaNewTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"BaojiaNewTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                [self.baojiaSubject sendNext:x];
                
            }];
            cell.fuwuArray = self.dataArrayBaojia;
            cell.baojiaNumber.text = [NSString stringWithFormat:@"全部报价（%ld）",self.model.baojia.zongshu];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else if (self.markType == 2){
            ZuopinNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZuopinNewTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"ZuopinNewTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                [self.zuopinindexSubject sendNext:x];
                
            }];
            cell.fuwuArray = self.dataArrayZuopin;
            cell.zuopinNumber.text = [NSString stringWithFormat:@"全部作品（%ld）",self.dataArrayZuopin.count];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else if (self.markType == 3){
            if (indexPath.row == 0) {
                PingjiaNewViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PingjiaNewViewTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"PingjiaNewViewTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.name.text = [NSString stringWithFormat:@"全部评论（%@）",self.pingjiaNumber];
                return  cell;
            }else {
                ShangjiaNewthreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangjiaNewthreeTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ShangjiaNewthreeTableViewCell" owner:nil options:nil].firstObject;
                }
                @weakify(self);
                [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(id  _Nullable x) {
                    @strongify(self);
                    [self.lookImageSubject sendNext:x];
                    
                }];
                cell.model = self.dataArrayPingjia[indexPath.row - 1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }
            
        }else if (self.markType == 4){
            if (indexPath.row == 0) {
                PingjiaNewViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PingjiaNewViewTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"PingjiaNewViewTableViewCell" owner:nil options:nil].firstObject;
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.name.text = [NSString stringWithFormat:@"全部动态（%@）",self.dongtaiNumber];
                return  cell;
            }else {
                DongtaiNewViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DongtaiNewViewTableViewCell"];
                if (!cell)
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"DongtaiNewViewTableViewCell" owner:nil options:nil].firstObject;
                }
                @weakify(self);
                [[[cell.dianzanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    
                    @strongify(self);
//                    [self.dianzanUISubject sendNext:self.dataArrayDongtai[indexPath.row - 1]];
//                    self.index = indexPath.row;
                }];
                [[[cell.pinglunBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    
                    @strongify(self);
                    [self.pinglunseleUISubject sendNext:self.dataArrayDongtai[indexPath.row - 1]];
                    self.index = indexPath.row;
                }];
                [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal]  subscribeNext:^(NewShangjiaModel *x) {
                    @strongify(self);
                    [self.selectItemSubject sendNext:@(indexPath.row - 1)];
                }];
                cell.model = self.dataArrayDongtai[indexPath.row - 1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return  cell;
            }
        }else if (self.markType == 5){
            
            DangqiNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DangqiNewTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DangqiNewTableViewCell" owner:nil options:nil].firstObject;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.time.text = self.dataArrayDangqi[indexPath.row].dateye;
            cell.model = self.dataArrayDangqi[indexPath.row];
            return  cell;
        }else {
            ZiliaoNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZiliaoNewTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"ZiliaoNewTableViewCell" owner:nil options:nil].firstObject;
            }
            cell.model = self.shangjiaModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
    if (self.markType == 0) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1) {
            
        }else if (indexPath.row == 2) {
            
        }else {
            
        }
    }else if (self.markType == 1){
        
    }else if (self.markType == 2){
        
    }else if (self.markType == 3){
        if (indexPath.row == 0) {
           
        }else {
            
        }
    }else if (self.markType == 4){
        if (indexPath.row == 0) {
            
        }else {
            
        }
    }else if (self.markType == 5){
        
    }else {
        
    }
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

- (RACSubject *)hiddenNavSubject {
	if (!_hiddenNavSubject) _hiddenNavSubject = [RACSubject subject];
	return _hiddenNavSubject;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGPoint point = scrollView.contentOffset;
	NSNumber *obj = [NSNumber numberWithFloat:point.y];
	[self.hiddenNavSubject sendNext:obj];
}


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
