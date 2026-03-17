//
//  RiChengNewModel.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Newrichengarray;
@interface RiChengNewModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Newrichengarray *> *newrichengArray;

@end
@interface Newrichengarray : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *riqi;

@property (nonatomic, copy) NSString *statime;

@property (nonatomic, copy) NSString *creater;

@property (nonatomic, copy) NSString *endtime;

@property (nonatomic, assign) NSInteger isend;

@property (nonatomic, copy) NSString *conn;

@end

