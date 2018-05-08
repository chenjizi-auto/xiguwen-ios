//
//  ShopNewCarViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/6.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShopNewCarViewModel.h"
#import "ShopNewCarTableViewCell.h"
#import "CarTuijianTableViewCell.h"
#import "GoodsListNewHeader.h"
#import "GoodsNewTableViewCell.h"
#import "GoodsNewSCTableViewCell.h"

@implementation ShopNewCarViewModel

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
        [self.bianjiDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.bianjiUISubject sendNext:x];
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
    if (!self.tuiJianArray) self.tuiJianArray = [NSMutableArray array];
    if (isHeaderRefersh) [self.dataArray removeAllObjects];
    if (isHeaderRefersh) [self.tuiJianArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:[ShopNewCarListarray mj_objectArrayWithKeyValuesArray:object[@"data"]]];
    [self.tuiJianArray addObjectsFromArray:[ShopCarTuiJian mj_objectArrayWithKeyValuesArray:object[@"tuijian"]]];
    
}


#pragma mark - private
- (RACSubject *)bianjiUISubject {
    
    if (!_bianjiUISubject) _bianjiUISubject = [RACSubject subject];
    
    return _bianjiUISubject;
}
- (RACSubject *)selectTuijianSubject {
    if (!_selectTuijianSubject) _selectTuijianSubject = [RACSubject subject];
    return _selectTuijianSubject;
}
- (RACSubject *)shanchuUISubject {
    
    if (!_shanchuUISubject) _shanchuUISubject = [RACSubject subject];
    
    return _shanchuUISubject;
}

- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)moneySubject {
    
    if (!_moneySubject) _moneySubject = [RACSubject subject];
    
    return _moneySubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            NSString *url = self.isHunqin ? URL_New_hunqincarlist :URL_New_shangchengcarlist;
            return [[RequestManager sharedManager] RACRequestUrl:url
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}

- (RACCommand *)bianjiDataCommand {
    
    if (!_bianjiDataCommand) {
        @weakify(self);
        _bianjiDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            NSString *url = self.isHunqin ? [HOMEURL stringByAppendingString:@"appapi/carthq/update"] :[HOMEURL stringByAppendingString:@"appapi/cart/update"];
            return [[RequestManager sharedManager] RACRequestUrl:url
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _bianjiDataCommand;
}

#pragma mark -  tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.dataArray.count > 0) {
        
        return self.tuiJianArray.count > 0 ?  self.dataArray.count + 1 : self.dataArray.count;
        
    } else {
        return self.tuiJianArray.count > 0 ?  2 : 1;
    }
//    return self.tuiJianArray.count > 0 ?  self.dataArray.count + 1 : self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == self.dataArray.count) {
        return 1;
    }
    if (self.dataArray.count == 0) {
        return 1;
    }
    return self.dataArray[section].goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count == 0 && indexPath.section == 0) {
        return 230;
    }
    
    if (indexPath.section == self.dataArray.count || self.dataArray.count == 0) {
        //推荐
        CGFloat width = (ScreenWidth - 10)/2;
        CGFloat height = width * 7 / 12 + 90;
        return 4 * (height + 10) + 50;
    }else {
    
        return 128;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    

    if (section == self.dataArray.count) {
        //推荐
        return 0.0000001;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == self.dataArray.count || self.dataArray.count == 0) {
        //推荐
        return [UIView new];
    }
    GoodsListNewHeader *header = [[NSBundle mainBundle]loadNibNamed:@"GoodsListNewHeader" owner:nil options:nil].firstObject;
    header.frame = CGRectMake(0, 0, ScreenWidth, 44);
    header.zhiwei.text = self.dataArray[section].seller.nickname;
    header.isGouImage.image = [UIImage imageNamed:self.dataArray[section].isSele == YES ? @"勾选商品":@"未勾选商品"];
    @weakify(self);
    [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.dataArray[section].isSele) {
            self.dataArray[section].isSele = NO;
            for (int i = 0; i < self.dataArray[section].goods.count; i ++) {
                self.dataArray[section].goods[i].isSele = NO;
            }
        }else {
            self.dataArray[section].isSele = YES;
            for (int i = 0; i < self.dataArray[section].goods.count; i ++) {
                self.dataArray[section].goods[i].isSele = YES;
            }
        }
        [self.moneySubject sendNext:nil];
        NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:section];    //刷新第3段
        [tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.dataArray.count == 0 && indexPath.section == 0) {
        ShopNewCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopNewCarTableViewCell"];
        UIImage *image = [UIImage imageNamed:@"shopcar_NoData"];
        cell.noData.image = image;
        return cell;
    }
    if (indexPath.section == self.dataArray.count || self.dataArray.count == 0) {
        //推荐
        CarTuijianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarTuijianTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CarTuijianTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configModel:self.tuiJianArray];
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(ShopCarTuiJian *x) {


            @strongify(self);
            //点击推荐商家
            [self.selectTuijianSubject sendNext:x];
        }];
        return cell;
    }
    
    if (self.isHunqin) {
        GoodsNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsNewTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"GoodsNewTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArray[indexPath.section].goods[indexPath.row];
        @weakify(self);
        [[[cell.seleBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            @strongify(self);
            
            
            if (self.dataArray[indexPath.section].goods[indexPath.row].isSele) {
                self.dataArray[indexPath.section].goods[indexPath.row].isSele = NO;
            }else {
                self.dataArray[indexPath.section].goods[indexPath.row].isSele = YES;
            }
            [self.moneySubject sendNext:nil];
            
            NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:indexPath.section];    //刷新第3段
            [tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        //减
        [[[cell.jianBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            @strongify(self);
            if (self.dataArray[indexPath.section].goods[indexPath.row].quantity == 1) {
                
                
            }else {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:@(self.dataArray[indexPath.section].goods[indexPath.row].quantity - 1) forKey:@"quantity"];
                [dic setValue:@(self.dataArray[indexPath.section].goods[indexPath.row].rec_id) forKey:@"rec_id"];
                
                
                self.dataArray[indexPath.section].goods[indexPath.row].quantity = self.dataArray[indexPath.section].goods[indexPath.row].quantity - 1;
                NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:indexPath.section];    //刷新第3段
                [tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
                self.index = indexPath;
                [self.bianjiDataCommand execute:dic];
            }

        }];
        //加
        [[[cell.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            @strongify(self);
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:@(self.dataArray[indexPath.section].goods[indexPath.row].quantity + 1) forKey:@"quantity"];
            [dic setValue:@(self.dataArray[indexPath.section].goods[indexPath.row].rec_id) forKey:@"rec_id"];
            self.dataArray[indexPath.section].goods[indexPath.row].quantity = self.dataArray[indexPath.section].goods[indexPath.row].quantity + 1;
            NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:indexPath.section];    //刷新第3段
            [tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.bianjiDataCommand execute:dic];
            self.index = indexPath;
        }];
        
        return  cell;
    }else {
        GoodsNewSCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsNewSCTableViewCell"];

        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"GoodsNewSCTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArray[indexPath.section].goods[indexPath.row];
        @weakify(self);
        [[[cell.seleBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            @strongify(self);
            if (self.dataArray[indexPath.section].goods[indexPath.row].isSele) {
                self.dataArray[indexPath.section].goods[indexPath.row].isSele = NO;
            }else {
                self.dataArray[indexPath.section].goods[indexPath.row].isSele = YES;
            }
            [self.moneySubject sendNext:nil];
            NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:indexPath.section];    //刷新第3段
            [tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        //减
        [[[cell.jianBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            @strongify(self);
            if (self.dataArray[indexPath.section].goods[indexPath.row].quantity == 1) {
                
                
            }else {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:@(self.dataArray[indexPath.section].goods[indexPath.row].quantity - 1) forKey:@"quantity"];
                [dic setValue:@(self.dataArray[indexPath.section].goods[indexPath.row].rec_id) forKey:@"rec_id"];
                
                
                self.dataArray[indexPath.section].goods[indexPath.row].quantity = self.dataArray[indexPath.section].goods[indexPath.row].quantity - 1;
                NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:indexPath.section];    //刷新第3段
                [tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
                self.index = indexPath;
                [self.bianjiDataCommand execute:dic];
            }
            
        }];
        //加
        [[[cell.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            @strongify(self);
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:@(self.dataArray[indexPath.section].goods[indexPath.row].quantity + 1) forKey:@"quantity"];
            [dic setValue:@(self.dataArray[indexPath.section].goods[indexPath.row].rec_id) forKey:@"rec_id"];
            self.dataArray[indexPath.section].goods[indexPath.row].quantity = self.dataArray[indexPath.section].goods[indexPath.row].quantity + 1;
            NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:indexPath.section];    //刷新第3段
            [tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.bianjiDataCommand execute:dic];
            self.index = indexPath;
        }];
        return  cell;
    }
    

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.dataArray.count || self.dataArray.count == 0) {
        //推荐
        return NO;
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        
        Goods *model = self.dataArray[indexPath.section].goods[indexPath.row];
        NSString *url = self.isHunqin ? [HOMEURL stringByAppendingString:@"appapi/carthq/drop"] :[HOMEURL stringByAppendingString:@"appapi/cart/drop"];
        [[RequestManager sharedManager] requestUrl:url
                                            method:POST
                                            loding:@""
                                               dic:@{@"rec_id":@(model.rec_id),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               
                                               if ([response[@"code"] integerValue] == 0) {
                                                   
                                                   [NavigateManager hiddenLoadingMessage];

                                                   if (self.dataArray[indexPath.section].goods.count == 1) {
                                                       [(NSMutableArray *)self.dataArray removeObjectAtIndex:indexPath.section];
                                                   }else {
                                                       [(NSMutableArray *)self.dataArray[indexPath.section].goods removeObjectAtIndex:indexPath.row];
                                                   }

                                                   [tableView reloadData];
                                                   [self.shanchuUISubject sendNext:nil];
                                               }else{
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                               

                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                               [NavigateManager showMessage:@"删除失败"];
                                               
                                           }];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
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
