//
//  AnlieNewDetilViewModel.h
//  BoYi
//
//  Created by heng on 2017/12/24.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnlieNewDetilModel.h"
#import "AnlieListSearchModel.h"

@interface AnlieNewDetilViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) AnlieNewDetilModel *model;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//查看明细
@property (nonatomic, strong) RACSubject *lookmingxiUISubject;
//查看商家详情
@property (nonatomic, strong) RACSubject *lookshangjiaUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (nonatomic, strong)Anlielistsearcharray *modelfather;

//关注
@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;

@property (nonatomic, strong) RACSubject *addguanUISubject;
@property (nonatomic, strong) RACSubject *deleteguanzhuUISubject;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
