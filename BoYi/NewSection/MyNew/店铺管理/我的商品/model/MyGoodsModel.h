//
//  MyGoodsModel.h
//  BoYi
//
//  Created by Niklaus on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SkuModel;
@interface MyGoodsModel : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) NSInteger cityid;
@property (nonatomic, assign) NSInteger clicked;
@property (nonatomic, assign) NSInteger columnid;
@property (nonatomic, strong) NSString *columnname;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, assign) NSInteger countyid;
@property (nonatomic, strong) NSString *coupons_price;
@property (nonatomic, assign) NSInteger expressid;
@property (nonatomic, strong) NSString *expressname;
@property (nonatomic, assign) NSInteger followed;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger pcolumnid;
@property (nonatomic, strong) NSString *pcolumnname;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, assign) NSInteger provinceid;
@property (nonatomic, assign) NSInteger saled;
@property (nonatomic, assign) NSInteger shopid;
@property (nonatomic, strong) NSMutableArray *shopimg;// 图片集合
@property (nonatomic, strong) NSString *shopname;
@property (nonatomic, strong) NSString *spec_name_1;
@property (nonatomic, strong) NSString *spec_name_2;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString *statecontent;
@property (nonatomic, assign) NSInteger statetime;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *siteid;
@property (nonatomic, strong) NSString *sku1;
@property (nonatomic, strong) NSString *sku2;


@property (nonatomic, strong) NSMutableArray <SkuModel *>*sku;

@end

@interface SkuModel : NSObject

@property (nonatomic, strong) NSString *sku1name;
@property (nonatomic, strong) NSString *sku2name;
@property (nonatomic, strong) NSString *prices;
@property (nonatomic, strong) NSString *number;

@end
