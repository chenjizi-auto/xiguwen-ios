//
//  FayangaoModel.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Fayangaoarray;
@interface FayangaoModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Fayangaoarray *> *fayangaoArray;

@end
@interface Fayangaoarray : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger creater;

@end

