//
//  OrderDetilModelNew.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataorderDe,HunqingOrderm,YoulikeOrderDm;
@interface OrderDetilModelNew : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) DataorderDe *data;

@property (nonatomic, strong) NSArray<YoulikeOrderDm *> *youlike;

@end
@interface DataorderDe : NSObject

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *yingfuzonge;

@property (nonatomic, copy) NSString *yingfujine;

@property (nonatomic, copy) NSString *yifuzonge;

@property (nonatomic, copy) NSString *dindanzongge;

@property (nonatomic, copy) NSString *fanjifen;

@property (nonatomic, copy) NSString *shangpingjongjia;

@property (nonatomic, copy) NSString *voucher;

@property (nonatomic, copy) NSString *dikouzongge;

@property (nonatomic, copy) NSString *yuandingjin;

@property (nonatomic, assign) NSInteger user_im;

@property (nonatomic, assign) NSInteger shop_im;

@property (nonatomic, assign) NSInteger fukuantime;

@property (nonatomic, copy) NSString *baojia_price;

@property (nonatomic, copy) NSString *baojia_image;

@property (nonatomic, copy) NSString *specification;

@property (nonatomic, assign) NSInteger paytype;

@property (nonatomic, copy) NSString *order_lastamount;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *wkpay_name;

@property (nonatomic, copy) NSString *seller_name;

@property (nonatomic, copy) NSString *wkpay_code;

@property (nonatomic, strong) NSArray<HunqingOrderm *> *hunqing;

@property (nonatomic, assign) NSInteger tuihuo;

@property (nonatomic, copy) NSString *pay_message;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *order_lastmethod;

@property (nonatomic, copy) NSString *payment_name;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, copy) NSString *snickname;

@property (nonatomic, copy) NSString *wkpay_time;

@property (nonatomic, assign) NSInteger source;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, copy) NSString *order_snwk;

@property (nonatomic, copy) NSString *buyer_name;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *published;

@property (nonatomic, copy) NSString *out_trade_no;

@property (nonatomic, copy) NSString *sureok_time;

@property (nonatomic, copy) NSString *baojia_name;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *received_time;

@property (nonatomic, copy) NSString *comment_time;

@property (nonatomic, copy) NSString *wkout_trade_no;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *baojia_date;

@property (nonatomic, copy) NSString *payment_code;

@property (nonatomic, assign) NSInteger baojia_time;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *dingjin;

@property (nonatomic, copy) NSString *extension;

@property (nonatomic, assign) NSInteger seller_id;

@property (nonatomic, copy) NSString *goods_amount;

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, assign) NSInteger baojia_id;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, assign) NSInteger buyer_id;

@end

@interface HunqingOrderm : NSObject

@property (nonatomic, copy) NSString *baojia_name;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, copy) NSString *baojia_price;

@property (nonatomic, copy) NSString *specification;

@property (nonatomic, copy) NSString *goods_amount;

@property (nonatomic, copy) NSString *baojia_image;

@property (nonatomic, copy) NSString *dingjin;

@property (nonatomic, copy) NSString *url;

@end

@interface YoulikeOrderDm : NSObject

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

@property (nonatomic, strong) NSArray *imglist;

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

