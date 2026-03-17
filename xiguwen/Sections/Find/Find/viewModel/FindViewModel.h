//
//  FindViewModel.h
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindModel.h"


@interface FindViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <Rows *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubjectAL;
//刷新数据的时候使用 类型
@property (nonatomic, strong) RACSubject *refreshUISubjectALTYPE;
//sousuo
@property (nonatomic, strong) RACSubject *searchUISubject;

@property (nonatomic, strong) RACSubject *guanBtnUISubject;

@property (nonatomic, strong) RACSubject *addguanUISubject;

@property (nonatomic, strong) RACSubject *deleteguanzhuUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//案列巡查条件
@property (nonatomic, strong) RACCommand *refreshDataCommandAL;
//案列巡查条件类型
@property (nonatomic, strong) RACCommand *refreshDataCommandALTYPE;

//关注
@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;
//搜索
@property (nonatomic, strong) RACCommand *searchDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;


/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
