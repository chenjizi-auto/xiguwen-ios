//
//  MyDangQiModel.h
//  BoYi
//
//  Created by heng on 2018/1/18.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DangQiDetailsModel,RemindDetailsModel;

@interface MyDangQiModel : NSObject

// custom code
@property (nonatomic, strong) NSArray<DangQiDetailsModel *> * a;// 档期详情数组
@property (nonatomic, strong) NSString *dateye;// 日期
@property (nonatomic ,assign) NSInteger danshu;// 当日订单数量

@end

@interface DangQiDetailsModel : NSObject

@property (nonatomic, assign) NSInteger id;// id
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *timeslot;
@property (nonatomic, strong) NSString *contacts;
@property (nonatomic, strong) NSString *contactnumber;
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) NSInteger create_ti;
@property (nonatomic, assign) NSInteger update_ti;
@property (nonatomic, strong) NSString *dateye;
@property (nonatomic, assign) NSInteger shijiancuo;
@property (nonatomic, assign) NSInteger order_id;
@property (nonatomic, assign) BOOL remind;
@property (nonatomic, assign) BOOL xitong;

@property (nonatomic, strong) NSMutableArray<RemindDetailsModel *> *tixing;// 事件提醒数组

@end

@interface RemindDetailsModel : NSObject

@property (nonatomic, strong) NSString *beizhu;
@property (nonatomic, strong) NSString *didian;
@property (nonatomic, strong) NSString *hunlishijian;
@property (nonatomic, strong) NSString *shijian;
@property (nonatomic, strong) NSString *tixinshijian1;
@property (nonatomic, strong) NSString *tixinshijian2;
@property (nonatomic, strong) NSString *type;

@end
