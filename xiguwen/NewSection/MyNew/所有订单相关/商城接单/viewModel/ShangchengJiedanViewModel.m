//
//  ShangchengJiedanViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengJiedanViewModel.h"
#import "ShangchengJiedanTableViewCell.h"
#import "shangchengOrderNFooterTwo.h"
#import "shangchengOrderNFooter.h"
#import "ShangchengHeaderN.h"
@implementation ShangchengJiedanViewModel

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
    
    [self.dataArray addObjectsFromArray:[DataShangcheng mj_objectArrayWithKeyValuesArray:object[@"data"]]];
    
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
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/saleorder"]
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}

#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 102;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //订单状态 10：待支付 20：已关闭 60：待发货 70：待发货 ：80：交易成功待评价 90 已评价
    if (self.dataArray[section].status == 20) {
        
        return 57;
    }else {
        return 108;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    ShangchengHeaderN *header = [[NSBundle mainBundle]loadNibNamed:@"ShangchengHeaderN" owner:nil options:nil].firstObject;
    header.frame = CGRectMake(0, 0, ScreenWidth, 81);
    header.model = self.dataArray[section];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (self.dataArray[section].status == 20 ) {
        shangchengOrderNFooter *header = [[NSBundle mainBundle]loadNibNamed:@"shangchengOrderNFooter" owner:nil options:nil].firstObject;
        header.frame = CGRectMake(0, 0, ScreenWidth, 57);
        header.model = self.dataArray[section];
        return header;
    }else {
        shangchengOrderNFooterTwo *header = [[NSBundle mainBundle]loadNibNamed:@"shangchengOrderNFooterTwo" owner:nil options:nil].firstObject;
        header.frame = CGRectMake(0, 0, ScreenWidth, 108);
        @weakify(self);
        [[[header.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self.firstSubject sendNext:self.dataArray[section]];
        }];
        [[[header.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self.secondSubject sendNext:self.dataArray[section]];
        }];
        header.model = self.dataArray[section];
        return header;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   //订单状态 10：待支付 20：已关闭 60：待发货 70：待发货 ：80：交易成功待评价 90 已评价
    ShangchengJiedanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangchengJiedanTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShangchengJiedanTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.section].goods[indexPath.row];
    return  cell;
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
