//
//  ShangchengOrderModel.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataShangcheng,Buyer_Infoshangcheng,Goodsshangcheng;
@interface ShangchengOrderModel : NSObject

// custom code



@property (nonatomic, assign) NSInteger current_page;

@property (nonatomic, assign) NSInteger last_page;

@property (nonatomic, assign) NSInteger per_page;

@property (nonatomic, strong) NSArray<DataShangcheng *> *data;

@property (nonatomic, assign) NSInteger total;


@end
@interface DataShangcheng : NSObject

@property (nonatomic, assign) NSInteger evaluation;

@property (nonatomic, assign) NSInteger zonji;

@property (nonatomic, assign) NSInteger fukuantime;

@property (nonatomic, assign) NSInteger jiedantime;

@property (nonatomic, assign) NSInteger anonymous;

@property (nonatomic, copy) NSString *buyer_email;

@property (nonatomic, copy) NSString *seller_name;

@property (nonatomic, copy) NSString *postname;

@property (nonatomic, assign) NSInteger tuihuo;

@property (nonatomic, strong) Buyer_Infoshangcheng *buyer_info;

@property (nonatomic, copy) NSString *pay_message;

@property (nonatomic, copy) NSString *postaddress;

@property (nonatomic, copy) NSString *postaddressid;

@property (nonatomic, copy) NSString *invoice_no;

@property (nonatomic, copy) NSString *kuaiditime;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *payment_name;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, copy) NSString *payment_id;

@property (nonatomic, copy) NSString *kuaidinum;

@property (nonatomic, assign) NSInteger source;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, copy) NSString *buyer_name;

@property (nonatomic, copy) NSString *out_trade_no;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger finished_time;

@property (nonatomic, assign) NSInteger published;

@property (nonatomic, copy) NSString *comment_time;

@property (nonatomic, assign) NSInteger pay_time;

@property (nonatomic, copy) NSString *received_time;

@property (nonatomic, copy) NSString *payment_code;

@property (nonatomic, strong) NSArray<Goodsshangcheng *> *goods;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *postmobile;

@property (nonatomic, copy) NSString *extension;

@property (nonatomic, assign) NSInteger seller_id;

@property (nonatomic, copy) NSString *goods_amount;

@property (nonatomic, assign) NSInteger shouqian;

@property (nonatomic, copy) NSString *kuaidicode;

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, assign) NSInteger buyer_id;

@end

@interface Buyer_Infoshangcheng : NSObject

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

@property (nonatomic, copy) NSString *registersc;

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

@interface Goodsshangcheng : NSObject

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *specification;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger is_valid;

@property (nonatomic, copy) NSString *goods_image;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, assign) NSInteger evaluation;

@property (nonatomic, assign) NSInteger is_approve;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger spec_id;

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, assign) NSInteger credit_value;

@property (nonatomic, assign) NSInteger rec_id;

@end

