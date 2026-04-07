//
//  HunqinViewModel.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "HunqinViewModel.h"
#import "HunqinTwoTableViewCell.h"
#import "HunQinThreeTableViewCell.h"
#import "HunqinFourTableViewCell.h"
#import "HunqinfiveTableViewCell.h"

#import "HunqinsevenTableViewCell.h"
#import "HunqinSixTableViewCell.h"
#import "HunqinEightTableViewCell.h"
#import "HunqinOneTableViewCell.h"
#import "HunqinFourTuanduiTableViewCell.h"
#import "HunqinNineTableViewCell.h"
#import "CwCacheableRequestHelper.h"

static const NSTimeInterval CwHunqingHomeCacheTTL = 10 * 60;
static const NSTimeInterval CwHunqingCategoryCacheTTL = 24 * 60 * 60;

@implementation HunqinViewModel

static NSInteger const CwHunqinBaseRowsWithoutHotActivity = 5;
static NSInteger const CwHunqinBaseRowsWithHotActivity = 6;

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
        //请求成功分类列表
        [self.fenleilistDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.fenleilistUISubject sendNext:x];
        }];
        //
        [self.addguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.addguanzhuUISubject sendNext:x];
        }];
        //
        [self.deleguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.deleguanzhuUISubject sendNext:x];
        }];
        
    }
    return self;
}

#pragma mark - public

- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    
    if (!self.dataArray) self.dataArray = [NSMutableArray array];
    if (isHeaderRefersh) [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[Youlike mj_objectArrayWithKeyValuesArray:object[@"youlike"]]];


}


#pragma mark - private

- (RACSubject *)lookMakeHunliBtnSelectSubject {
    
    if (!_lookMakeHunliBtnSelectSubject) _lookMakeHunliBtnSelectSubject = [RACSubject subject];
    
    return _lookMakeHunliBtnSelectSubject;
}
- (RACSubject *)fenleilistUISubject {
    
    if (!_fenleilistUISubject) _fenleilistUISubject = [RACSubject subject];
    
    return _fenleilistUISubject;
}
- (RACSubject *)hotHuoFiveBtnSelectSubject {
    
    if (!_hotHuoFiveBtnSelectSubject) _hotHuoFiveBtnSelectSubject = [RACSubject subject];
    
    return _hotHuoFiveBtnSelectSubject;
}
- (RACSubject *)tuanduiSHangjiaListSelectSubject {
    
    if (!_tuanduiSHangjiaListSelectSubject) _tuanduiSHangjiaListSelectSubject = [RACSubject subject];
    
    return _tuanduiSHangjiaListSelectSubject;
}
- (RACSubject *)gerenSHangjiaListSelectSubject {
    
    if (!_gerenSHangjiaListSelectSubject) _gerenSHangjiaListSelectSubject = [RACSubject subject];
    
    return _gerenSHangjiaListSelectSubject;
}
- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)typeSelectSubject {
    
    if (!_typeSelectSubject) _typeSelectSubject = [RACSubject subject];
    
    return _typeSelectSubject;
}
- (RACSubject *)gongjuSelectSubject {
    
    if (!_gongjuSelectSubject) _gongjuSelectSubject = [RACSubject subject];
    
    return _gongjuSelectSubject;
}

- (RACSubject *)addguanzhuUISubject {
    
    if (!_addguanzhuUISubject) _addguanzhuUISubject = [RACSubject subject];
    
    return _addguanzhuUISubject;
}
- (RACSubject *)deleguanzhuUISubject {
    
    if (!_deleguanzhuUISubject) _deleguanzhuUISubject = [RACSubject subject];
    
    return _deleguanzhuUISubject;
}
- (RACSubject *)loginSubject {
    
    if (!_loginSubject) _loginSubject = [RACSubject subject];
    
    return _loginSubject;
}

- (RACCommand *)fenleilistDataCommand {
    
    if (!_fenleilistDataCommand) {
        @weakify(self);
        _fenleilistDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [CwCacheableRequestHelper signalWithURL:URL_New_indexfenleilist
                                                    method:POST
                                                   loading:nil
                                                    params:input
                                                       ttl:CwHunqingCategoryCacheTTL
                                              cacheEnabled:YES
                                               errorDomain:@"com.xiguwen.cache.hunqing.category"
                                              errorMessage:@"婚庆分类加载失败"];
        }];
    }
    return _fenleilistDataCommand;
}
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [CwCacheableRequestHelper signalWithURL:URL_New_indexData
                                                    method:POST
                                                   loading:nil
                                                    params:input
                                                       ttl:CwHunqingHomeCacheTTL
                                              cacheEnabled:YES
                                               errorDomain:@"com.xiguwen.cache.hunqing.home"
                                              errorMessage:@"婚庆首页加载失败"];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)deleguanzhuCommand {
    
    if (!_deleguanzhuCommand) {
        @weakify(self);
        _deleguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_deleGuanzhu
                                                   method:POST
                                                   loding:nil
                                                      dic:input];
        }];
    }
    return _deleguanzhuCommand;
}
- (RACCommand *)addguanzhuCommand {
    
    if (!_addguanzhuCommand) {
        @weakify(self);
        _addguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_ADDUserFollowById
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _addguanzhuCommand;
}

- (BOOL)hotActivityModelIsValid:(id)model {
    if (!model || model == [NSNull null]) {
        return NO;
    }
    NSInteger adid = [[model valueForKey:@"adid"] integerValue];
    if (adid > 0) {
        return YES;
    }
    NSArray<NSString *> *keys = @[@"title", @"miaoshu", @"src", @"wapimg"];
    for (NSString *key in keys) {
        id value = [model valueForKey:key];
        if ([value isKindOfClass:[NSString class]] && ![NSStringFormatter(value) isBlankString]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)shouldShowHotActivitySection {
    if (self.model.xiaoguanggaoyi.count > 0) {
        return YES;
    }
    Remenhuodong *remenhuodong = self.model.remenhuodong;
    return [self hotActivityModelIsValid:remenhuodong.rmhd1]
    || [self hotActivityModelIsValid:remenhuodong.rmhd2]
    || [self hotActivityModelIsValid:remenhuodong.rmhd3]
    || [self hotActivityModelIsValid:remenhuodong.rmhd4]
    || [self hotActivityModelIsValid:remenhuodong.rmhd5];
}

- (NSInteger)contentStartRow {
    return [self shouldShowHotActivitySection] ? CwHunqinBaseRowsWithHotActivity : CwHunqinBaseRowsWithoutHotActivity;
}

- (NSInteger)contentIndexForRow:(NSInteger)row {
    return row - [self contentStartRow];
}

- (Youlike *)contentModelAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger contentIndex = [self contentIndexForRow:indexPath.row];
    if (contentIndex < 0 || contentIndex >= self.dataArray.count) {
        return nil;
    }
    return self.dataArray[contentIndex];
}

#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count + [self contentStartRow];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 190;
    }else if (indexPath.row == 1){
        return 130;
    }else if (indexPath.row == 2){
        return 114;
    }else if (indexPath.row == 3){
        return 185;
    }else if (indexPath.row == 4){
        return 185;
    }else if (indexPath.row == 5 && [self shouldShowHotActivitySection]){
        return 338;
    }else {
        Youlike *model = [self contentModelAtIndexPath:indexPath];
        if (!model) {
            return 0.0000001;
        }
        if ([model.typee isEqualToString:@"1"]) {//type == 1 1代表案
            
            return 405;
//            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"HunqinSixTableViewCell") contentViewWidth:ScreenWidth];
            
        }else if ([model.typee isEqualToString:@"2"]){//type == 2 2 代表图册
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"HunqinsevenTableViewCell") contentViewWidth:ScreenWidth];
        }else if ([model.typee isEqualToString:@"3"]){//type == 3 3 代表视频
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"HunqinEightTableViewCell") contentViewWidth:ScreenWidth];
        }else {//type == 4 4 代表商品
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"HunqinNineTableViewCell") contentViewWidth:ScreenWidth];
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
    if (indexPath.row == 0) {

        HunqinOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinOneTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinOneTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Fenleiarray *model = [[Fenleiarray alloc] init];
        model.occupationid = 10000;
        model.proname = @"分类";
        model.wapimg = @"分类";
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        arr = [NSMutableArray arrayWithArray:self.fenleiArray];
        if (arr.count > 0) {
            [arr insertObject:model atIndex:0];
        }
        cell.fuwuArray = arr;
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.typeSelectSubject sendNext:x];
        }];
        return  cell;
    }else if (indexPath.row == 1) {
        
        HunqinTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinTwoTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinTwoTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.lookMakeHunliBtnSelectSubject sendNext:x];
        }];
        return  cell;
        
    }else if (indexPath.row == 2) {
        
        HunQinThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunQinThreeTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HunQinThreeTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.gongjuSelectSubject sendNext:x];
        }];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
        
    }else if (indexPath.row == 3) {
        
        HunqinFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinFourTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinFourTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.geren = self.model.remengeren;
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.gerenSHangjiaListSelectSubject sendNext:x];
        }];
        return  cell;
        
    }else if (indexPath.row == 4) {
        
        HunqinFourTuanduiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinFourTuanduiTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinFourTuanduiTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.tuandui = self.model.rementuandui;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.tuanduiSHangjiaListSelectSubject sendNext:x];
            
        }];
        return  cell;
        
    }else if (indexPath.row == 5 && [self shouldShowHotActivitySection]) {
        
        HunqinfiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinfiveTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinfiveTableViewCell" owner:nil options:nil].firstObject;
        }
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        [[cell.gotoNextVc takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.hotHuoFiveBtnSelectSubject sendNext:x];
        }];
        if (self.model.xiaoguanggaoyi.count > 0) {
            [cell.xiaoguanggao sd_setImageWithUrl:self.model.xiaoguanggaoyi[0].wapimg placeHolder:[UIImage imageNamed:@"占位图片"]];
        } else {
            cell.xiaoguanggao.image = [UIImage imageNamed:@"占位图片"];
        }
        cell.remenhuodong = self.model.remenhuodong;
        
        return  cell;
        
    }else {
        
#pragma mark  内容
        Youlike *model = [self contentModelAtIndexPath:indexPath];
        if (!model) {
            return [UITableViewCell new];
        }
        if ([model.typee isEqualToString:@"1"]) {//type == 1 1代表案
            
            HunqinSixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinSixTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinSixTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[[cell.guanzhuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
               
                if ([UserDataNew sharedManager].userInfoModel.token.token) {
                    if (self.dataArray[[self contentIndexForRow:indexPath.row]].follow == 1) {
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[[self contentIndexForRow:indexPath.row]].userid] forKey:@"id"];
                        
                        [self.deleguanzhuCommand execute:dic];
                        self.index = indexPath.row;
                        
                    }else {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[[self contentIndexForRow:indexPath.row]].userid] forKey:@"id"];
                        [self.addguanzhuCommand execute:dic];
                        self.index = indexPath.row;
                    }
                }else {
                    [self.loginSubject sendNext:nil];
                }

            }];
            
            cell.model = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else if ([model.typee isEqualToString:@"2"]){//type == 2 2 代表图册
            HunqinsevenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinsevenTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinsevenTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[[cell.guanzhuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
              if (![UserDataNew UserLoginState]) {
                  [self.loginSubject sendNext:nil];
              }else {
                  if (self.dataArray[[self contentIndexForRow:indexPath.row]].follow == 1) {
                      
                      NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                      [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                      [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                      [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[[self contentIndexForRow:indexPath.row]].userid] forKey:@"id"];
                      
                      [self.deleguanzhuCommand execute:dic];
                      self.index = indexPath.row;
                      
                  }else {
                      NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                      [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                      [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                      [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[[self contentIndexForRow:indexPath.row]].userid] forKey:@"id"];
                      [self.addguanzhuCommand execute:dic];
                      self.index = indexPath.row;
                  }
              }
                
            }];
            cell.model = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else if ([model.typee isEqualToString:@"3"]){//type == 3 3 代表视频
            HunqinEightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinEightTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinEightTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[[cell.guanzhuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
            
                if (![UserDataNew UserLoginState]) {
                    [self.loginSubject sendNext:nil];
                }else {
                    if (self.dataArray[[self contentIndexForRow:indexPath.row]].follow == 1) {
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[[self contentIndexForRow:indexPath.row]].userid] forKey:@"id"];
                        
                        [self.deleguanzhuCommand execute:dic];
                        self.index = indexPath.row;
                        
                    }else {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[[self contentIndexForRow:indexPath.row]].userid] forKey:@"id"];
                        [self.addguanzhuCommand execute:dic];
                        self.index = indexPath.row;
                    }
                }
            }];
            cell.model = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else {//type == 4 4 代表商品
            
            HunqinNineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqinNineTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"HunqinNineTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[[cell.guanzhuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
        
                if (![UserDataNew UserLoginState]) {
                    [self.loginSubject sendNext:nil];
                }else {
                    if (self.dataArray[[self contentIndexForRow:indexPath.row]].follow == 1) {
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[[self contentIndexForRow:indexPath.row]].userid] forKey:@"id"];
                        
                        [self.deleguanzhuCommand execute:dic];
                        self.index = indexPath.row;
                        
                    }else {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",self.dataArray[[self contentIndexForRow:indexPath.row]].userid] forKey:@"id"];
                        [self.addguanzhuCommand execute:dic];
                        self.index = indexPath.row;
                    }
                }
            }];
            cell.model = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataArray.count > 0 && indexPath.row >= [self contentStartRow]) {
        [self.selectItemSubject sendNext:self.dataArray[[self contentIndexForRow:indexPath.row]]];
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
