//
//  youhuiModel.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Contyouhui;
@interface youhuiModel : NSObject

@property (nonatomic, strong) NSArray<Contyouhui *> *cont;

@property (nonatomic, assign) NSInteger num;

@end
@interface Contyouhui : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *typename;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *isnew;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger updatetime;

@property (nonatomic, assign) NSInteger columnid;

@property (nonatomic, assign) NSInteger is_show;

@property (nonatomic, assign) NSInteger typeid;

@end

