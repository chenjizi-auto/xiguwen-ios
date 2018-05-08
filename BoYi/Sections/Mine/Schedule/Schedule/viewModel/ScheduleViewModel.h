//
//  ScheduleViewModel.h
//  BoYi
//
//  Created by Chen on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleModel.h"


@interface ScheduleViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <ScheduleModelWithDate *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//获取日期宜忌
@property (nonatomic, strong) RACCommand *getCalendarCommand;
//查询档期
@property (nonatomic, strong) RACCommand *findScheduleCommand;
//修改档期
@property (nonatomic, strong) RACCommand *udpateStatusByIdCommand;
//添加档期  即没得档期，关闭档期
@property (nonatomic, strong) RACCommand *insertStatusByIdCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;


/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
