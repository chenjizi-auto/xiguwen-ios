//
//  ShopcityViewModel.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopcityModel.h"


@interface ShopcityViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <ShopcityModel *>*dataArray;
@property (strong,nonatomic) ShopcityModel *model;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
//加载首页分类列表
@property (nonatomic, strong) RACSubject *fenleilistUISubject;
@property (nonatomic, strong) RACCommand *fenleilistDataCommand;
//分类列表
@property (strong,nonatomic) NSArray *fenleiArray;
//点击分类跳转
@property (nonatomic, strong) RACSubject *typeSelectSubject;
//特别推荐/婚约预约/热门活动 6ge
@property (nonatomic, strong) RACSubject *hotHuoFiveBtnSelectSubject;

@property (nonatomic, strong) RACSubject *hotxiaopinpaisixBtnSelectSubject;


@property (nonatomic, strong) RACSubject *addguanzhuUISubject;
@property (nonatomic, strong) RACSubject *deleguanzhuUISubject;

@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;

@property (nonatomic, strong) RACSubject *loginSubject;

@property (nonatomic, assign) NSInteger index;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
