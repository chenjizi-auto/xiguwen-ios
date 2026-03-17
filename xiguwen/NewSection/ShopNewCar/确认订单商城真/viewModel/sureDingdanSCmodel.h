//
//  sureDingdanSCmodel.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserSC,CartlistSC,SellerSC,GoodsSC;
@interface sureDingdanSCmodel : NSObject

@property (nonatomic, copy) NSString *ids;

@property (nonatomic, strong) NSArray<CartlistSC *> *cartlist;

@property (nonatomic, strong) NSArray *useradders;

@property (nonatomic, assign) NSInteger allcount;

@property (nonatomic, strong) UserSC *user;

@end
@interface UserSC : NSObject

@property (nonatomic, copy) NSString *vouchers;

@property (nonatomic, copy) NSString *pvouchers;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *payvouchers;

@end

@interface CartlistSC : NSObject

@property (nonatomic, strong) SellerSC *seller;

@property (nonatomic, strong) NSArray<GoodsSC *> *goods;

@property (nonatomic, assign) NSInteger store_id;

@property (nonatomic, assign) NSInteger kinds;

@end

@interface SellerSC : NSObject

@property (nonatomic, assign) NSInteger sign;

@property (nonatomic, copy) NSString *inviter;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *site;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *payword;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger logintime;

@property (nonatomic, assign) NSInteger createtime;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *salt;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, assign) NSInteger isuserivip;

@property (nonatomic, copy) NSString *sslmpid;

@property (nonatomic, assign) NSInteger usertype;

@property (nonatomic, copy) NSString *weibo_openid;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *sslmid;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger authentication;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *qq_openid;

@property (nonatomic, copy) NSString *im_token;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger evaluate;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *pvouchers;

@property (nonatomic, copy) NSString *register123;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger birthday;

@property (nonatomic, copy) NSString *vouchers;

@property (nonatomic, assign) NSInteger bool123;

@property (nonatomic, copy) NSString *wachat_openid;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, copy) NSString *isuseriviptoken;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, copy) NSString *weixin;

@property (nonatomic, assign) NSInteger userivipstat;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *identitynum;

@property (nonatomic, copy) NSString *payvouchers;

@property (nonatomic, assign) NSInteger onlinestatus;

@property (nonatomic, assign) NSInteger userivipendt;

@end

@interface GoodsSC : NSObject


@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger statetime;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *coupons_price;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, assign) NSInteger sku2id;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *spec_name_1;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, copy) NSString *county;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) CGFloat subtotal;

@property (nonatomic, assign) CGFloat dikoutotal;

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

@property (nonatomic, assign) NSInteger sku1id;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *sku1name;

@property (nonatomic, copy) NSString *sku1;

@property (nonatomic, copy) NSString *pcolumnname;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *goods_image;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *shopimg;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger rec_id;

@property (nonatomic, copy) NSString *sku2name;

@property (nonatomic, copy) NSString *statecontent;

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *sku2;

@property (nonatomic, copy) NSString *spec_name_2;

@property (nonatomic, copy) NSString *columnname;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, assign) NSInteger userid;

@end

