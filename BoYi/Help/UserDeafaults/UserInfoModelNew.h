//
//  UserInfoModelNew.h
//  BoYi
//
//  Created by heng on 2018/1/29.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TokenNew,UserNew;

@interface UserInfoModelNew : NSObject
// 用户token
@property (nonatomic, strong) TokenNew *token;
// 用户基本数据
@property (nonatomic, strong) UserNew *user;
// 用户认证信息
//@property (nonatomic, strong) CertificationNew *certification;

@end

@interface TokenNew : NSObject

@property (nonatomic, assign) NSInteger login_time;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *token;



@end

@interface UserNew : NSObject

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *im_token;

@property (nonatomic, assign) NSInteger sign;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *site;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *payword;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *recommend;

@property (nonatomic, copy) NSString *logintime;

@property (nonatomic, assign) NSInteger createtime;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger platform;

@property (nonatomic, assign) NSInteger team2;

@property (nonatomic, assign) NSInteger isuserivip;

@property (nonatomic, assign) NSInteger college;

@property (nonatomic, assign) NSInteger team;

@property (nonatomic, assign) NSInteger isshopvip;

@property (nonatomic, copy) NSString *sslmpid;

@property (nonatomic, assign) NSInteger usertype;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, copy) NSString *background;

@property (nonatomic, copy) NSString *weibo_openid;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *sslmid;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *shopimg;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger authentication;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *qq_openid;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger sincerity;

@property (nonatomic, assign) NSInteger evaluate;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *pvouchers;

@property (nonatomic, copy) NSString *registerwu;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *vouchers;

@property (nonatomic, copy) NSString *wachat_openid;

@property (nonatomic, assign) NSInteger shopivipstat;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, assign) NSInteger shopivipendt;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, copy) NSString *weixin;

@property (nonatomic, assign) NSInteger userivipstat;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *identitynum;

@property (nonatomic, copy) NSString *payvouchers;

@property (nonatomic, assign) NSInteger groupid;

@property (nonatomic, copy) NSString *qualifications;

@property (nonatomic, assign) NSInteger userivipendt;

@property (nonatomic, strong) NSString *association;

@property (nonatomic, assign) NSInteger follownumber;

@end

//@interface CertificationNew : NSObject
//
//
//@end


