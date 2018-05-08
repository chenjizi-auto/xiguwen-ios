//
//  MyOfferModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Createtime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Updatetime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone;
@interface MyOfferModel : NSObject

// custom code

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) NSInteger productType;

@property (nonatomic, assign) NSInteger channelId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger deposit;

@property (nonatomic, assign) NSInteger coins;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *originalPrice;

@property (nonatomic, assign) NSInteger currentPrice;

@property (nonatomic, strong) Createtime *createTime;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, assign) NSInteger auditCount;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Updatetime *updateTime;

@end



