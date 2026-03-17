//
//  GuanzhuShangjiaModel.h
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShangjiaGuanzhuModel;
@interface GuanzhuShangjiaModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<ShangjiaGuanzhuModel *> *shangjia;

@end
@interface ShangjiaGuanzhuModel : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *occupationid;

@property (nonatomic, assign) NSInteger usertype;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger provinceid;

@end

