//
//  HunqingJiedanViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqingJiedanViewModel.h"
#import "HunqingJiedanTableViewCell.h"
#import "HunqingJiedanSamllTableViewCell.h"
#import "HunqinOrderNHeader.h"
#import "HunqinOrderNFooter.h"
@implementation HunqingJiedanViewModel

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
    
    [self.dataArray addObjectsFromArray:[Hunqinordernew mj_objectArrayWithKeyValuesArray:object[@"data"]]];
    
}


#pragma mark - private
- (RACSubject *)secondSubject {
    
    if (!_secondSubject) _secondSubject = [RACSubject subject];
    
    return _secondSubject;
}
- (RACSubject *)firstSubject {
    
    if (!_firstSubject) _firstSubject = [RACSubject subject];
    
    return _firstSubject;
}
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
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/saleorder"]
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}

#pragma mark -  tableView 代理



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//订单状态 10：待支付 20：已关闭 60：待接单 70：待服务 79：已服务 ：80：待评价 90 交易完成 100 代服务 tuikuan
//    if (self.dataArray[indexPath.row].status == 20 || self.dataArray[indexPath.row].status == 79 || self.dataArray[indexPath.row].status == 80 ||self.dataArray[indexPath.row].status == 90 ) {
//        return 160.0;
//    }else {
//        return 210;
//    }
    return 115;
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
    
    //不传为全部，10：待支付 20：已取消 60：待接单 70：贷服务 79：已服务 ：80：带评价 100  退款
    //订单状态 10：待支付 20：已取消 60：待接单 70：待服务 79：已服务 ：80：待评价
    //付款状态 -1：未付款 1：已付定金 2：已付全款

    //订单状态 10：待支付 20：已关闭 60：待接单 70：待服务 71：已服务（需要付尾款） 79：已服务(全款已付) ：80：待评价 90 交易完成 100 代服务 tuikuan

//    if (self.dataArray[indexPath.row].status == 20 || self.dataArray[indexPath.row].status == 79 || self.dataArray[indexPath.row].status == 71 || self.dataArray[indexPath.row].status == 80 ||self.dataArray[indexPath.row].status == 90 ) {
//        HunqingJiedanSamllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqingJiedanSamllTableViewCell"];
//        if (!cell)
//        {
//            cell = [[NSBundle mainBundle] loadNibNamed:@"HunqingJiedanSamllTableViewCell" owner:nil options:nil].firstObject;
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.model = self.dataArray[indexPath.row];
//        return  cell;
//    }else {

        
        HunqingJiedanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HunqingJiedanTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HunqingJiedanTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        [[[cell.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self.firstSubject sendNext:self.dataArray[indexPath.row]];
        }];
        [[[cell.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self.secondSubject sendNext:self.dataArray[indexPath.row]];
        }];
        cell.model = self.dataArray[indexPath.row];
        return  cell;
//    }
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
