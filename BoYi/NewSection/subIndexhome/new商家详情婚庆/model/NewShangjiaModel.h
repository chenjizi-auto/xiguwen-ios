//
//  NewShangjiaModel.h
//  BoYi
//
//  Created by heng on 2017/12/21.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserinfonewShangjia,Usernew,Zuopingnew,Zuopinnewfen,Photou,Baojianewtou,Baojiashangjiafen,Tuijiantd,Xinyu;
@interface NewShangjiaModel : NSObject

// custom code

@property (nonatomic, strong) UserinfonewShangjia *userinfo;

@property (nonatomic, strong) Baojianewtou *baojia;

@property (nonatomic, strong) NSArray<Tuijiantd *> *tuijiantd;

@property (nonatomic, assign) NSInteger userf;

@property (nonatomic, strong) Zuopingnew *zuoping;

@property (nonatomic, strong) Usernew *user;


@end
@interface UserinfonewShangjia : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger isshopvip;

@property (nonatomic, assign) NSInteger sincerity;

@property (nonatomic, copy) NSString *dizhi;

@property (nonatomic, copy) NSString *recommend;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSInteger team;

@property (nonatomic, assign) NSInteger college;

@property (nonatomic, assign) NSInteger shopivipstat;

@property (nonatomic, assign) NSInteger platform;


@property (nonatomic, assign) NSInteger shiming;

@property (nonatomic, assign) NSInteger xueyuan;

@property (nonatomic, assign) NSInteger team2;

@property (nonatomic, copy) NSString *background;

@property (nonatomic, copy) NSString *association;

@property (nonatomic, assign) NSInteger groupid;

@property (nonatomic, assign) NSInteger shopivipendt;

@property (nonatomic, copy) NSString *qualifications;

@property (nonatomic, copy) NSString *isshopviptoken;

@property (nonatomic, copy) NSString *shopimg;

@property (nonatomic, copy) NSString *content;

@end

@interface Xinyu : NSObject

@property (nonatomic, copy) NSString *a;

@property (nonatomic, copy) NSString *b;

@end

@interface Usernew : NSObject

@property (nonatomic, strong) Xinyu *xinyu;

@property (nonatomic, copy) NSString *sslmpid;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, copy) NSString *registerwu;

@property (nonatomic, copy) NSString *background;

@property (nonatomic, copy) NSString *sslmid;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger userivipstat;

@property (nonatomic, copy) NSString *payvouchers;

@property (nonatomic, copy) NSString *isuseriviptoken;

@property (nonatomic, assign) NSInteger authentication;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *wachat_openid;

@property (nonatomic, assign) NSInteger createtime;

@property (nonatomic, copy) NSString *vouchers;

@property (nonatomic, assign) NSInteger score;



@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *weixin;

@property (nonatomic, assign) NSInteger isuserivip;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, assign) NSInteger usertype;

@property (nonatomic, assign) NSInteger birthday;

@property (nonatomic, assign) NSInteger evaluate;

@property (nonatomic, copy) NSString *site;

@property (nonatomic, assign) NSInteger userivipendt;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *logintime;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *payword;

@property (nonatomic, assign) NSInteger sign;

@property (nonatomic, copy) NSString *pvouchers;

@property (nonatomic, copy) NSString *qq_openid;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, copy) NSString *weibo_openid;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger userid;

@end

@interface Zuopingnew : NSObject

@property (nonatomic, assign) NSInteger zongshu;

@property (nonatomic, strong) NSArray<Zuopinnewfen *> *zuopin;

@end

@interface Zuopinnewfen : NSObject



@property (nonatomic, copy) NSString *video_url;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger examinetime;

@property (nonatomic, assign) NSInteger putaway;

@property (nonatomic, copy) NSString *synopsis;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger create_ti;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, copy) NSString *update_ti;

@property (nonatomic, copy) NSString *statecontent;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSArray<Photou *> *photou;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger followed;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *weddingcover;

@property (nonatomic, copy) NSString *weddingdescribe;

@property (nonatomic, assign) NSInteger weddingexpenses;

@property (nonatomic, copy) NSString *title;

@end

@interface Photou : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger atlas_id;

@end

@interface Baojianewtou : NSObject

@property (nonatomic, assign) NSInteger zongshu;

@property (nonatomic, strong) NSArray<Baojiashangjiafen *> *baojia;

@end

@interface Baojiashangjiafen : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *rule3key;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger quotationid;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, copy) NSString *statecontent;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *temporarypay;

@property (nonatomic, copy) NSString *deposit;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, copy) NSString *imglist;

@property (nonatomic, copy) NSString *deductible;

@property (nonatomic, assign) NSInteger haopin;

@property (nonatomic, copy) NSString *rule1val;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger statetime;

@property (nonatomic, copy) NSString *rule2val;

@property (nonatomic, copy) NSString *rule1key;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger createtime;

@property (nonatomic, copy) NSString *rule3val;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *rule2key;

@end

@interface Tuijiantd : NSObject

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, assign) NSInteger shopcode;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *occupation;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *zuidijia;

@end

