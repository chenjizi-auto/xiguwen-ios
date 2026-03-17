//
//  ListViewModel.h
//  BoYi
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListModel.h"


@interface ListViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <Userlist *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//加载区域
@property (nonatomic, strong) RACCommand *refreshDataCommandQY;
//刷新区域
@property (nonatomic, strong) RACSubject *refreshCityQYSubject;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

/**
 是否是关键词搜索
 */
@property (nonatomic, assign) BOOL isWorkLook;
/**
 是否是rows key列表
 */
@property (nonatomic, assign) BOOL isRows;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
