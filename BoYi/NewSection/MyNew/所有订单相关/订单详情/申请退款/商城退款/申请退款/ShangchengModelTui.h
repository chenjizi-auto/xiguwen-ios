//
//  ShangchengModelTui.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Goodsinfotui,Orderinfotui,Refundinfo;
@interface ShangchengModelTui : NSObject

@property (nonatomic, strong) Goodsinfotui *goodsinfo;

@property (nonatomic, strong) Orderinfotui *orderinfo;

@property (nonatomic, strong) Refundinfo *refundinfo;

@end

@interface Refundinfo : NSObject

@property (nonatomic, copy) NSString *tuihuo_image;

@property (nonatomic, copy) NSString *tuikuan_yuanyin;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) NSInteger fund_id;

@property (nonatomic, assign) NSInteger refund_status;

@end

@interface Goodsinfotui : NSObject

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

@interface Orderinfotui : NSObject


@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger anonymous;

@property (nonatomic, copy) NSString *buyer_email;

@property (nonatomic, copy) NSString *seller_name;

@property (nonatomic, copy) NSString *postname;

@property (nonatomic, assign) NSInteger tuihuo;

@property (nonatomic, copy) NSString *pay_message;

@property (nonatomic, copy) NSString *postaddress;

@property (nonatomic, assign) NSInteger postaddressid;

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

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *received_time;

@property (nonatomic, copy) NSString *payment_code;

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

