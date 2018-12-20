//
//  shangpinnewModel.h
//  BoYi
//
//  Created by heng on 2018/2/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GuigeSP,SkuSP,UserSP,ShangpinSP,TebietuijianSP;
@interface shangpinnewModel : NSObject

@property (nonatomic, strong) GuigeSP *guige;

@property (nonatomic, strong) ShangpinSP *shangpin;

@property (nonatomic, strong) NSArray<TebietuijianSP *> *tebietuijian;

@property (nonatomic, strong) UserSP *user;


@end




@interface GuigeSP : NSObject

@property (nonatomic, strong) NSArray<SkuSP *> *sku;

@property (nonatomic, strong) NSArray *datas;

@end

@interface SkuSP : NSObject

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *skuname;

@property (nonatomic, assign) NSInteger skutype;

@property (nonatomic, assign) NSInteger skuid;

@end

@interface UserSP : NSObject

@property (nonatomic, copy) NSString *xueyuanname;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger college;

@property (nonatomic, assign) NSInteger xueyuan;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger team2;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, assign) NSInteger platform;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *occupation;

@property (nonatomic, assign) NSInteger sincerity;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, assign) NSInteger shiming;

@property (nonatomic, assign) NSInteger allgoods;

@property (nonatomic, copy) NSString *addr;

@property (nonatomic, assign) NSInteger team;

@end

@interface ShangpinSP : NSObject

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *coupons_price;

@property (nonatomic, copy) NSString *county;

@property (nonatomic, copy) NSString *spec_name_1;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger userf;

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

@property (nonatomic, assign) NSInteger shopf;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *pcolumnname;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger focus;

@property (nonatomic, strong) NSArray<NSString *> *shopimg;

@property (nonatomic, strong) NSArray<UIImageView *> *zl_imgviews;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *statecontent;

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *spec_name_2;

@property (nonatomic, copy) NSString *columnname;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, assign) NSInteger statetime;

@property (nonatomic, assign) NSInteger userid;

@end

@interface TebietuijianSP : NSObject

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, strong) NSArray<NSString *> *shopimg;

@end

