//
//  ShopOrderViewModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyOrderModel.h"


@interface ShopOrderViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <MyOrderModel *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//重新加载数据
@property (nonatomic, strong) RACCommand *updateOrderStateCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
//选择某个
@property (nonatomic, strong) RACSubject *otherClickSubject;

/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
