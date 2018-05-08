//
//  MyConcernViewModel.h
//  BoYi
//
//  Created by Chen on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyConcernModel.h"


@interface MyConcernViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <MyConcernModel *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
@property (nonatomic, strong) RACSubject *selectdetialItemSubject;
@property (nonatomic, strong) RACSubject *selectdetialItemSubjectAL;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//重新加载数据
@property (nonatomic, strong) RACCommand *GetShopDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (assign,nonatomic) BOOL isShop;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
