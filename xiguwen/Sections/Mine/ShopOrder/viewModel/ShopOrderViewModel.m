//
//  ShopOrderViewModel.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShopOrderViewModel.h"
#import "ShopOrderTableViewCell.h"
#import "ShopOrderTableViewHeader.h"
#import "ShopOrderTableViewFooter.h"

@implementation ShopOrderViewModel

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
- (RACSubject *)otherClickSubject {
    
    if (!_otherClickSubject) _otherClickSubject = [RACSubject subject];
    
    return _otherClickSubject;
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
#pragma mark - 网络请求
- (RACSignal *)requestSignalWithUrl:(NSString *)url
                            loading:(NSString *)loading
                      Authorization:(NSString *)Authorization
                               info:(NSDictionary *)info {
    
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:GET
                                                                         loding:loading
                                                                            dic:info
                                                                      progress:nil
                                                                        success:^(NSURLSessionDataTask *task, id response) {
                                                                            //                                                                        if(response) {
                                                                            // 可封装为请求正确，但是校验未通过处理
                                                                            //                                                                            if ([response[@"code"] integerValue] == 1) {
                                                                            //                                                                                [subscriber sendNext:nil];
                                                                            //                                                                                [subscriber sendError:[NSError errorWithDomain:@"com.saitjr.demo" code:1 userInfo:@{@"msg":@"没数据啦"}]];
                                                                            //                                                                                return;
                                                                            //                                                                            } else {
                                                                            [subscriber sendNext:response];
                                                                            [subscriber sendCompleted];
                                                                            //                                                                            }
                                                                            //                                                                        }
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
    //    [requestSignal throttle:1];
    return requestSignal;
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
    footer.totalPrice.text = [NSString stringWithFormat:@"￥%.f",model.price];
    footer.orderMoney.text = [NSString stringWithFormat:@"￥%ld",(long)model.deposit];
    //订单状态 -1：待审核 1：待接单 2：商家已接单 3：订单取消 4：申请退款 5：商家完成订单 6：用户确认完成订单 7：同意退款 8：拒绝退款 9.已评价
    footer.completeImage.hidden = YES;
    footer.completeLabel.hidden = YES;
    
    if (model.payStatus == -1) {
        footer.leftBtn.hidden = YES;
        footer.centerBtn.hidden = YES;
        footer.rightBtn.hidden = YES;
    } else {
        switch (model.status) {
            case 1: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
                [footer.rightBtn setTitle:@"订单确认" forState:UIControlStateNormal];
            }
                break;
            case 2: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
                [footer.rightBtn setTitle:@"订单完成" forState:UIControlStateNormal];
            }
                break;
            case 4: {
                footer.leftBtn.hidden = NO;
                footer.rightBtn.hidden = NO;
                footer.centerBtn.hidden = NO;
                [footer.leftBtn setTitle:@"同意退款" forState:UIControlStateNormal];
                [footer.centerBtn setTitle:@"拒绝退款" forState:UIControlStateNormal];
                [footer.rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            }
                break;
            case 6: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = YES;
//                [footer.rightBtn setTitle:@"订单确认" forState:UIControlStateNormal];
            }
                break;
            case 7: {
                footer.leftBtn.hidden = YES;
                footer.centerBtn.hidden = YES;
                footer.rightBtn.hidden = NO;
                [footer.rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
                
                footer.completeImage.hidden = NO;
                footer.completeLabel.hidden = NO;
                footer.completeLabel.text   = @"退款成功";
                
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
        [self.otherClickSubject sendNext:@{@"isAgree":@"0",@"order":self.dataArray[section]}];
    }];
    [[[footer.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:footer.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        [self.otherClickSubject sendNext:@{@"isAgree":@"1",@"order":self.dataArray[section]}];
    }];
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
