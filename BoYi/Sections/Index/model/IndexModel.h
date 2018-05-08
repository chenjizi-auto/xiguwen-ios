//
//  IndexModel.h
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ad,Createtime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Updatetime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone;
@class Ad,Createtime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Updatetime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Children,Createtime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Updatetime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone;
@interface IndexModel : NSObject

@property (nonatomic, strong) Ad *ad;

@property (nonatomic, strong) NSArray<Children *> *children;


@end







@interface Ad : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *parentName;

@property (nonatomic, assign) NSInteger isCheck;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, strong) Updatetime *updateTime;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *goodEvaluation;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *positionName;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger positionId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *commentCount;

@property (nonatomic, copy) NSString *urlStatus;

@property (nonatomic, strong) Createtime *createTime;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *entityId;

@end



@interface Children : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *parentName;

@property (nonatomic, assign) NSInteger isCheck;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *province;//省份

@property (nonatomic, copy) NSString *district; //区

@property (nonatomic, strong) Updatetime *updateTime;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *goodEvaluation;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *descn;//jianjie

@property (nonatomic, copy) NSString *positionName;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger positionId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *commentCount;

@property (nonatomic, copy) NSString *urlStatus;

@property (nonatomic, strong) Createtime *createTime;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *entityId;

@end

