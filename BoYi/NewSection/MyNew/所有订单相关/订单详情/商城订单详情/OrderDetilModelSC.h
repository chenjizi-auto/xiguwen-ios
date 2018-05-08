//
//  OrderDetilModelSC.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataSCDetil,GoodsSCDetil,YoulikeSCdetil;
@interface OrderDetilModelSC : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) DataSCDetil *data;

@property (nonatomic, strong) NSArray<YoulikeSCdetil *> *youlike;

@end
@interface DataSCDetil : NSObject

@property (nonatomic, assign) NSInteger fukuantime;

@property (nonatomic, assign) NSInteger anonymous;

@property (nonatomic, copy) NSString *buyer_email;

@property (nonatomic, copy) NSString *seller_name;

@property (nonatomic, copy) NSString *postname;

@property (nonatomic, assign) NSInteger tuihuo;

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

@property (nonatomic, copy) NSString *published;

@property (nonatomic, copy) NSString *comment_time;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *received_time;

@property (nonatomic, copy) NSString *payment_code;

@property (nonatomic, strong) NSArray<GoodsSCDetil *> *goods;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *postmobile;

@property (nonatomic, copy) NSString *extension;

@property (nonatomic, assign) NSInteger seller_id;

@property (nonatomic, copy) NSString *goods_amount;

@property (nonatomic, assign) NSInteger shouqian;

@property (nonatomic, copy) NSString *kuaidicode;

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger shop_id;

@property (nonatomic, assign) NSInteger buyer_id;

@property (nonatomic, copy) NSString *user_mobile;
@property (nonatomic, copy) NSString *shop_mobile;

@end

@interface GoodsSCDetil : NSObject

@property (nonatomic, assign) NSInteger status;

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

@interface YoulikeSCdetil : NSObject

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

