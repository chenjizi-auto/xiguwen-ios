//
//  ShangChengListNewModel.h
//  BoYi
//
//  Created by heng on 2018/2/28.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shopnew;
@interface ShangChengListNewModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Shopnew *> *shop;



@end
@interface Shopnew : NSObject

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *coupons_price;

@property (nonatomic, copy) NSString *county;

@property (nonatomic, copy) NSString *spec_name_1;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *expressname;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger pcolumnid;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, assign) NSInteger saled;

@property (nonatomic, assign) NSInteger expressid;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, assign) NSInteger columnid;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger followed;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *pcolumnname;

@property (nonatomic, strong) NSArray<NSString *> *shopimg;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *statecontent;

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *spec_name_2;

@property (nonatomic, copy) NSString *columnname;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, assign) NSInteger statetime;

@property (nonatomic, assign) NSInteger userid;

@end

