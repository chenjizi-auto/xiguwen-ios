//
//  MyCaseModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Userinfobvo,Bizwork;
@interface MyCaseModel : NSObject

// custom code

@property (nonatomic, copy) NSString *caseTime;

@property (nonatomic, copy) NSString *caseDetail;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *totalD;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *caseType;

@property (nonatomic, copy) NSString *caseHotel;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Userinfobvo *userInfoBvo;

@property (nonatomic, copy) NSString *orderDetailId;

@property (nonatomic, copy) NSString *caseComment;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *caseEnvironment;

@property (nonatomic, copy) NSString *goodD;

@property (nonatomic, copy) NSString *orderDesn;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger exampleType;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *userId;

@end
@interface Userinfobvo : NSObject

@property (nonatomic, copy) NSString *bizDealCount;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, strong) Bizwork *bizWork;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *bizWorkType;

@property (nonatomic, copy) NSString *agent;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *userType;

@property (nonatomic, copy) NSString *goods;

@property (nonatomic, copy) NSString *bizPrice;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *remoteFee;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *username;

@end

@interface Bizwork : NSObject

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

