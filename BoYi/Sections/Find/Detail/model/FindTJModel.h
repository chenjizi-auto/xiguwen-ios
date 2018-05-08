//
//  FindTJModel.h
//  BoYi
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EsarraytjTJ,RecommenduserTJ,BizworkTJ;
@interface FindTJModel : NSObject

@property (nonatomic, strong) NSArray<EsarraytjTJ *> *esArrayTJ;

@end
@interface EsarraytjTJ : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *user;

@property (nonatomic, strong) RecommenduserTJ *recommendUser;

@property (nonatomic, copy) NSString *perD;

@property (nonatomic, copy) NSString *exampleId;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *recommendId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *example;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, copy) NSString *rolename;

@property (nonatomic, copy) NSString *updateTime;

@end

@interface RecommenduserTJ : NSObject

@property (nonatomic, assign) NSInteger bizDealCount;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, strong) BizworkTJ *bizWork;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *bizWorkType;

@property (nonatomic, copy) NSString *agent;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *userType;

@property (nonatomic, copy) NSString *goods;

@property (nonatomic, assign) NSInteger bizPrice;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *remoteFee;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *username;

@end

@interface BizworkTJ : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *parentId;

@property (nonatomic, copy) NSString *parentName;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *statusName;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *byAdList;

@property (nonatomic, assign) NSInteger findFlag;

@property (nonatomic, copy) NSString *positionName;

@property (nonatomic, copy) NSString *positionId;

@property (nonatomic, copy) NSString *channelList;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *status;

@end

