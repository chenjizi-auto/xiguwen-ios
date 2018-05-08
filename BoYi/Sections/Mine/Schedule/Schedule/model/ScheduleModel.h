//
//  ScheduleModel.h
//  BoYi
//
//  Created by Chen on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyOrderModel.h"

@class Createtime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Updatetime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone;
@interface ScheduleModel : NSObject

// custom code

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) Scheduledate *scheduleDate;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) Updatetime *updateTime;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *orderDetailId;

@property (nonatomic, assign) NSInteger scheduleType;

@property (nonatomic, strong) Createtime *createTime;

@property (nonatomic, assign) NSInteger orderBy;

@end

@interface ScheduleModelWithDate : NSObject

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *scheduletime;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *scheduledate;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *scheduletab;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *name;

@end

