//
//  BingkeHuifuModel.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Zhufu;
@interface BingkeHuifuModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Zhufu *> *zhufu;

@end
@interface Zhufu : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *zhufu;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *createti;

@end

