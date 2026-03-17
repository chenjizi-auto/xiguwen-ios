//
//  MyOrderViewModel.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyOrderViewModel.h"
#import "MyOrderTableViewCell.h"
#import "ShopOrderTableViewHeader.h"
#import "ShopOrderTableViewCell.h"
#import "ShopOrderTableViewFooter.h"

@implementation MyOrderViewModel

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
    
    [self.dataArray addObjectsFromArray:[MyOrderModel mj_objectArrayWithKeyValuesArray:object]];
    
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
- (RACCommand *)updateOrderStateCommand {
    
    if (!_updateOrderStateCommand) {
        @weakify(self);
        _updateOrderStateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_updateOrderStatus
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _updateOrderStateCommand;
}
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_GET_MY_ORDER
                                                                 method:POST
                                                                 loding:@"加载中..."
                                                                    dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)submitOrderCommentCommand {
    
    if (!_submitOrderCommentCommand) {
        @weakify(self);
        _submitOrderCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_submitOrderComment
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _submitOrderCommentCommand;
}
- (RACCommand *)submitRefundCommand {
    
    if (!_submitRefundCommand) {
        @weakify(self);
        _submitRefundCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_submitRefund
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _submitRefundCommand;
}

//URL_orderPay
- (RACCommand *)orderPayCommand {
    
    if (!_orderPayCommand) {
        @weakify(self);
        _orderPayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_orderPay
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _orderPayCommand;
}

- (RACSubject *)otherClickSubject {
    
    if (!_otherClickSubject) _otherClickSubject = [RACSubject subject];
    
    return _otherClickSubject;
}



#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count > 0 ? self.dataArray.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray[section].detailInfoBvoList.count;
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 101;
}
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    view.tintColor = [UIColor clearColor];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ShopOrderTableViewHeader *header = (ShopOrderTableViewHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopOrderTableViewHeader"];
    header.contentView.backgroundColor = RGBA(242, 242, 242, 1);
    header.shopName.text = self.dataArray[section].bizUser.cnName;
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    ShopOrderTableViewFooter *footer = (ShopOrderTableViewFooter *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopOrderTableViewFooter"];
    footer.contentView.backgroundColor = [UIColor whiteColor];
    
    MyOrderModel *model = self.dataArray[section];
    
    footer.totalCount.text = [NSString stringWithFormat:@"共计%ld件商品,合计全额:",model.detailInfoBvoList.count];
    footer.totalPrice.text = [NSString stringWithFormat:@"￥%.1f",model.price];
    footer.orderMoney.text = [NSString stringWithFormat:@"￥%.1f",model.deposit];
    //订单状态 -1：待审核 1：待接单 2：商家已接单 3：订单取消 4：申请退款 5：商家完成订单 6：用户确认完成订单 7：同意退款 8：拒绝退款 9.已评价
    //付款状态 -1：未付款 1：已付定金 2：已付全款
    
    footer.completeImage.hidden = YES;
    footer.completeLabel.hidden = YES;
    
    
    if (model.payStatus == -1) {
        footer.leftBtn.hidden = YES;
        footer.centerBtn.hidden = NO;
        footer.rightBtn.hidden = NO;
        [footer.centerBtn setTitle:@"订单取消" forState:UIControlStateNormal];
        [footer.rightBtn setTitle:@"去付款" forState:UIControlStateNormal];
        if (model.status == 3) {
            footer.leftBtn.hidden = YES;
            footer.centerBtn.hidden = YES;
            footer.rightBtn.hidden = YES;
            
            footer.completeImage.hidden = NO;
            footer.completeLabel.hidden = NO;
            footer.completeLabel.text = @"订单取消";
        }
    } else {
        switch (model.status) {
            case 2: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
//                [footer.centerBtn setTitle:@"申请退款" forState:UIControlStateNormal];
                [footer.rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            }
                break;
            case 3: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = YES;
                
                footer.completeImage.hidden = NO;
                footer.completeLabel.hidden = NO;
                footer.completeLabel.text = @"订单取消";
//                [footer.centerBtn setTitle:@"订单取消" forState:UIControlStateNormal];
//                [footer.rightBtn setTitle:@"去付款" forState:UIControlStateNormal];
            }
                break;
            case 1: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
                [footer.rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            }
                break;
            case 4: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
                [footer.rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            }
                break;
            case 5: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = NO;
                footer.rightBtn.hidden = NO;
                [footer.centerBtn setTitle:@"完成订单" forState:UIControlStateNormal];
                [footer.rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            }
                break;
            case 6: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
                [footer.rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
            }
                break;
            case 7: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
                
                footer.completeImage.hidden = NO;
                footer.completeLabel.hidden = NO;
                footer.completeLabel.text = @"退款成功";
                [footer.rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            }
            case 8: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
                [footer.rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            }
                break;
            default:
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = YES;
                break;
        }
    }
    
    
    
    
    @weakify(self);
    [[[footer.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:footer.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        [self.selectItemSubject sendNext:self.dataArray[section]];
    }];
    
    [[[footer.centerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:footer.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        [self.otherClickSubject sendNext:self.dataArray[section]];
    }];
//    [[[footer.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:footer.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        
//        @strongify(self);
//        [self.otherClickSubject sendNext:@{@"isAgree":@"1",@"order":self.dataArray[section]}];
//    }];
    return footer;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopOrderTableViewCell"];
    cell.model = self.dataArray[indexPath.section].detailInfoBvoList[indexPath.row];
    return  cell;
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
    return 49.0;
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
