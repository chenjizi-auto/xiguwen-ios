//
//  AnlieListSearchViewModel.h
//  BoYi
//
//  Created by heng on 2017/12/27.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnlieListSearchModel.h"


@interface AnlieListSearchViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <Anlielistsearcharray *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//类型
@property (nonatomic, strong) RACSubject *leixingUISubject;
@property (nonatomic, strong) RACCommand *leixingDataCommand;
//环境
@property (nonatomic, strong) RACSubject *huanjinUISubject;
@property (nonatomic, strong) RACCommand *huanjinDataCommand;

//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;


//关注
@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;

@property (nonatomic, strong) RACSubject *addguanUISubject;
@property (nonatomic, strong) RACSubject *deleteguanzhuUISubject;

@property (nonatomic, strong) RACSubject *loginSubject;
@property (nonatomic, assign) NSInteger index;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
