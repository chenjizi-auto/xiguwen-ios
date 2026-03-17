//
//  HunliLiuchengModel.h
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LiuChengArray;
@interface HunliLiuchengModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<LiuChengArray *> *liuChengArray;

@end

@interface LiuChengArray : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *shijian;
@property (nonatomic, copy) NSString *shixiang;
@property (nonatomic, copy) NSString *renyuan;

@end














