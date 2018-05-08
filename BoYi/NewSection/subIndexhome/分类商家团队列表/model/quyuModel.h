//
//  quyuModel.h
//  BoYi
//
//  Created by heng on 2018/2/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Quyuquarray;
@interface quyuModel : NSObject

@property (nonatomic, strong) NSArray<Quyuquarray *> *quyuquArray;

@end
@interface Quyuquarray : NSObject

@property (nonatomic, copy) NSString *cityid;

@property (nonatomic, copy) NSString *pinyin;

@property (nonatomic, copy) NSString *initial;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger isnew;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *lv;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) BOOL isSelete;
@end

