//
//  HunQinOrderModel.h
//  BoYi
//
//  Created by heng on 2018/1/13.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hunqinordernew,Seller_Info;
@interface HunQinOrderModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Hunqinordernew *> *hunqinOrderNew;


@end
@interface Hunqinordernew : NSObject


@property (nonatomic, copy) NSString *yuandingjin;

@property (nonatomic, copy) NSString *deductible;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger zquantity;

@property (nonatomic, copy) NSString *zongjine;

@property (nonatomic, copy) NSString *zongdingjin;

@property (nonatomic, copy) NSString *zongdikou;

@property (nonatomic, copy) NSString *shifukuan;


@property (nonatomic, assign) NSInteger fukuantime;

@property (nonatomic, assign) NSInteger jiedantime;

@property (nonatomic, copy) NSString *baojia_price;

@property (nonatomic, copy) NSString *baojia_image;

@property (nonatomic, copy) NSString *specification;

@property (nonatomic, assign) NSInteger paytype;

@property (nonatomic, copy) NSString *order_lastamount;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *wkpay_name;

@property (nonatomic, copy) NSString *seller_name;

@property (nonatomic, copy) NSString *wkpay_code;

@property (nonatomic, strong) Seller_Info *seller_info;

@property (nonatomic, assign) NSInteger tuihuo;

@property (nonatomic, copy) NSString *pay_message;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *order_lastmethod;

@property (nonatomic, copy) NSString *payment_name;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, assign) NSInteger payment_dis;

@property (nonatomic, strong) NSString *amount_balance;

@property (nonatomic, assign) NSInteger confirm_completion;

@property (nonatomic, copy) NSString *wkpay_time;

@property (nonatomic, assign) NSInteger source;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, copy) NSString *order_snwk;

@property (nonatomic, copy) NSString *buyer_name;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger published;

@property (nonatomic, copy) NSString *out_trade_no;

@property (nonatomic, copy) NSString *sureok_time;

@property (nonatomic, copy) NSString *baojia_name;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *received_time;

@property (nonatomic, copy) NSString *comment_time;

@property (nonatomic, copy) NSString *wkout_trade_no;

@property (nonatomic, copy) NSString *baojia_date;

@property (nonatomic, copy) NSString *payment_code;

@property (nonatomic, assign) NSInteger baojia_time;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *extension;

@property (nonatomic, assign) NSInteger seller_id;

@property (nonatomic, copy) NSString *goods_amount;

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, assign) NSInteger baojia_id;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, assign) NSInteger buyer_id;

@end

@interface Seller_Info : NSObject

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

@property (nonatomic, copy) NSString *registernew;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger birthday;

@property (nonatomic, copy) NSString *vouchers;

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

