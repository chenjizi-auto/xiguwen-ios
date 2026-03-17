//
//  MyXuqiuModel.h
//  BoYi
//
//  Created by heng on 2018/1/15.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyXuqiuModel,PlayersModel;

@interface MyXuqiuModel : NSObject

// custom code
@property (nonatomic, assign) NSInteger browsingvolume;
@property (nonatomic, strong) NSString *create_ti;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) NSString *remainingtime;
@property (nonatomic, assign) NSInteger renshu;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger openphone;
@property (nonatomic, assign) NSInteger openmessage;
@property (nonatomic, strong) NSString *provinceid;
@property (nonatomic, strong) NSString *cityid;
@property (nonatomic, strong) NSString *countyid;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *details;

// 详情补充
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) NSInteger create_nyr;
@property (nonatomic, strong) NSString *daoqitime;
@property (nonatomic, strong) NSString *dizhi;
@property (nonatomic, assign) NSInteger update_ti;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, assign) NSInteger jiedan;


@end

@interface XuqiuDetailsModel : NSObject

@property (nonatomic, strong) MyXuqiuModel *xuquxiangqing;
@property (nonatomic, strong) NSMutableArray <PlayersModel *>*jiedanren;

@end

@interface PlayersModel : NSObject

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, strong) NSString *create_ti;
@property (nonatomic, assign) NSInteger demandid;
@property (nonatomic, assign) NSInteger goodscore;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *jdshuoming;
@property (nonatomic, assign) NSInteger minimumprice;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSString *occupationid;
@property (nonatomic, assign) NSInteger pv;
@property (nonatomic, strong) NSString *selected_time;
@property (nonatomic, assign) NSInteger status_j;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, strong) NSString *username;

// 详情补充
@property (nonatomic, assign) NSInteger college;
@property (nonatomic, assign) NSInteger follow;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) NSInteger platform;
@property (nonatomic, assign) NSInteger sincerity;
@property (nonatomic, assign) NSInteger team2;
@property (nonatomic, assign) NSInteger usertype;

@end


