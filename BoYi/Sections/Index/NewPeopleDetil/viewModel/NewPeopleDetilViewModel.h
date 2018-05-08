//
//  NewPeopleDetilViewModel.h
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewPeopleDetilModel.h"
#import "peopleDetailModel.h"
#import "NewOneTableViewCell.h"
#import "NewTwoTableViewCell.h"
#import "NewThreeTableViewCell.h"
#import "NewFourTableViewCell.h"
#import "NewFiveTableViewCell.h"
#import "SixTableViewCell.h"
@interface NewPeopleDetilViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) peopleDetailModel *model;

@property (strong,nonatomic) NSMutableArray <NewPeopleDetilModel *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *guanzhuUISubject;

@property (nonatomic, strong) RACSubject *deleteguanzhuUISubject;

@property (nonatomic, strong) RACSubject *selectTuanSubject;

@property (nonatomic, strong) RACSubject *selectZuoSubject;

//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;

//guanzhu
@property (nonatomic, strong) RACSubject *addguanUISubject;
//服务项目
@property (nonatomic, strong) RACSubject *fuwuxiangmuUISubject;

//服务项目
@property (nonatomic, strong) RACSubject *lookDQUISubject;
//关注
@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;
//服务项目
@property (nonatomic, strong) RACCommand *fuwuXiangmuCommand;

//评论管理
@property (nonatomic, strong) RACSubject *PLGLSubject;
@property (nonatomic, strong) RACCommand *PLGLCommand;
//服务项目
@property (nonatomic, strong) RACCommand *lookDQCommand;

@property (nonatomic, strong) RACCommand *GetShopDataCommand;

//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (strong,nonatomic) NSString  *userId;

@property (strong,nonatomic) NSMutableArray  *arrayPL;

/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
