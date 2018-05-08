//
//  SureDingdanNewModel.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Usersure,Cartlist,Sellersure,Goodssure;
@interface SureDingdanNewModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<NSString *> *ids;

@property (nonatomic, strong) NSArray<Cartlist *> *cartlist;

@property (nonatomic, assign) NSInteger allcount;

@property (nonatomic, strong) Usersure *user;

@property (nonatomic, copy) NSString *heji;

@end
@interface Usersure : NSObject

@property (nonatomic, copy) NSString *vouchers;

@property (nonatomic, copy) NSString *pvouchers;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *payvouchers;

@end

@interface Cartlist : NSObject

@property (nonatomic, strong) Sellersure *seller;

@property (nonatomic, strong) NSArray<Goodssure *> *goods;

@property (nonatomic, assign) NSInteger store_id;

@property (nonatomic, assign) NSInteger kinds;

@property (nonatomic, copy) NSString *liulan;

@end

@interface Sellersure : NSObject

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

@property (nonatomic, copy) NSString *registerwu;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger birthday;

@property (nonatomic, copy) NSString *vouchers;

@property (nonatomic, assign) NSInteger boolwu;

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

@interface Goodssure : NSObject



@property (nonatomic, assign) NSInteger zquantity;

@property (nonatomic, copy) NSString *yuandingjin;
@property (nonatomic, copy) NSString *deductible;
@property (nonatomic, copy) NSString *zongjine;
@property (nonatomic, copy) NSString *zongdingjin;
@property (nonatomic, copy) NSString *zongdikou;

@property (nonatomic, copy) NSString *heji;

@property (nonatomic, copy) NSString *specification;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger paytype;

@property (nonatomic, assign) NSInteger baojia_time;

@property (nonatomic, copy) NSString *dikou;

@property (nonatomic, assign) NSInteger baojia_id;

@property (nonatomic, assign) CGFloat dikoutotal;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *baojia_date;

@property (nonatomic, copy) NSString *partprice;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) CGFloat subtotal;

@property (nonatomic, copy) NSString *goods_image;

@property (nonatomic, copy) NSString *baojia_name;

@property (nonatomic, assign) NSInteger store_id;

@property (nonatomic, copy) NSString *baojia_image;

@property (nonatomic, copy) NSString *session_id;

@property (nonatomic, assign) NSInteger boolwu;

@property (nonatomic, assign) NSInteger rec_id;

@end




