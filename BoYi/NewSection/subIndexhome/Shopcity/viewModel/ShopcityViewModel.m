//
//  ShopcityViewModel.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShopcityViewModel.h"
#import "shangchengTwoTableViewCell.h"
#import "shangchengThreeTableViewCell.h"
#import "shangchengFourTableViewCell.h"
#import "HunqinOneTableViewCell.h"
#import "SHopbugTableViewCell.h"
@implementation ShopcityViewModel

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
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    
//    if (!self.dataArray) self.dataArray = [NSMutableArray array];
//    if (isHeaderRefersh) [self.dataArray removeAllObjects];
//    
//    [self.dataArray addObjectsFromArray:[ShopcityViewModel mj_objectArrayWithKeyValuesArray:object]];
    
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
- (RACSubject *)fenleilistUISubject {
    
    if (!_fenleilistUISubject) _fenleilistUISubject = [RACSubject subject];
    
    return _fenleilistUISubject;
}
- (RACSubject *)typeSelectSubject {
    
    if (!_typeSelectSubject) _typeSelectSubject = [RACSubject subject];
    
    return _typeSelectSubject;
}
- (RACSubject *)hotHuoFiveBtnSelectSubject {
    
    if (!_hotHuoFiveBtnSelectSubject) _hotHuoFiveBtnSelectSubject = [RACSubject subject];
    
    return _hotHuoFiveBtnSelectSubject;
}
- (RACSubject *)hotxiaopinpaisixBtnSelectSubject {
    
    if (!_hotxiaopinpaisixBtnSelectSubject) _hotxiaopinpaisixBtnSelectSubject = [RACSubject subject];
    
    return _hotxiaopinpaisixBtnSelectSubject;
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
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shangchengLeibieList
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _fenleilistDataCommand;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shangchengIndex
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
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Follow/qgzshop"]
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
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Follow/gzshop"]
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _addguanzhuCommand;
}
#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3 + self.model.remenshangpin.count;
    }
    return self.model.youlove.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 190;
        }else if (indexPath.row == 1){
            return 240;
        }else if (indexPath.row == 2){
            return 491;
        }else {
            return 357;
        }
    }
    return 146;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 47;
    }
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 47)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 16)];
        image.image = [UIImage imageNamed:@"文字"];
        image.center = view.center;
        [view addSubview:image];
        return view;
    }
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
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
            model.wapname = @"分类";
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else if (indexPath.row == 1) {
            
            SHopbugTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHopbugTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"SHopbugTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[cell.gotoNextVc takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                [self.hotHuoFiveBtnSelectSubject sendNext:x];
            }];
            cell.model = self.model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
            
        }else if(indexPath.row == 2) {
            
            shangchengTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shangchengTwoTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"shangchengTwoTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[cell.gotoNextVc takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                [self.hotxiaopinpaisixBtnSelectSubject sendNext:x];
            }];
            cell.model = self.model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else {

            shangchengThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shangchengThreeTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"shangchengThreeTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [[[cell.guanzhuBTN rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
                
                if ([UserDataNew sharedManager].userInfoModel.token.token) {
                    
                    
                    if (self.model.remenshangpin[indexPath.row - 3].afollow == 1) {
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",self.model.remenshangpin[indexPath.row - 3].shopid] forKey:@"id"];
                        
                        [self.deleguanzhuCommand execute:dic];
                        self.index = indexPath.row;
                        
                    }else {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",self.model.remenshangpin[indexPath.row - 3].shopid] forKey:@"id"];
                        [self.addguanzhuCommand execute:dic];
                        self.index = indexPath.row ;
                    }
                }else {
                    [self.loginSubject sendNext:nil];
                }
                
            }];
            cell.model = self.model.remenshangpin[indexPath.row - 3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }
        return  nil;
    }
    shangchengFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shangchengFourTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"shangchengFourTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.model = self.model.youlove[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.selectItemSubject sendNext:self.model.remenshangpin[indexPath.row - 3]];
    }
    if (indexPath.section == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.selectItemSubject sendNext:self.model.youlove[indexPath.row]];
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
