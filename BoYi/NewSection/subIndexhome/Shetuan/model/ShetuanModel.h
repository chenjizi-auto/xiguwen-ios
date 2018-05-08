//
//  ShetuanModel.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shetuan;
@interface ShetuanModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Shetuan *> *shetuan;



@end
@interface Shetuan : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *logourl;

@property (nonatomic, copy) NSString *profile;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *appphotourl;

@property (nonatomic, assign) NSInteger membersnum;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger create_ti;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger update_ti;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *minimumprice;

@property (nonatomic, copy) NSString *name;

// 补充社团类型id
@property (nonatomic, assign) NSInteger typeid;

@property (nonatomic, assign) NSInteger renshu;

@property (nonatomic, strong) NSString *addressd;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger chengyuan;

@property (nonatomic, assign) NSInteger cydangqi;

@property (nonatomic, strong) NSString *dizhi;

@property (nonatomic, assign) NSInteger jiaid;

@property (nonatomic, assign) NSInteger jrxinzeng;

@property (nonatomic, assign) NSInteger jryoudan;

@property (nonatomic, assign) NSInteger jiaose;


@end

