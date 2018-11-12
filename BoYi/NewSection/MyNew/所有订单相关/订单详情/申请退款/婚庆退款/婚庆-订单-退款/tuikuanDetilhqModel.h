//
//  tuikuanDetilhqModel.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/29.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TuikuanHunqin,OrderinfoHunqin;
@interface tuikuanDetilhqModel : NSObject

@property (nonatomic, strong) TuikuanHunqin *tuikuan;

@property (nonatomic, strong) OrderinfoHunqin *orderinfo;

@end
@interface TuikuanHunqin : NSObject

@property (nonatomic, assign) NSInteger shenyushijian;

@property (nonatomic, assign) NSInteger fund_id;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, copy) NSString *shangjajj_yuanyin;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *tui_amount;

@property (nonatomic, assign) NSInteger seller_id;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *cldated_at;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, copy) NSString *tui_yuanyin;

@end

@interface OrderinfoHunqin : NSObject

@property (nonatomic, copy) NSString *baojia_price;

@property (nonatomic, copy) NSString *baojia_image;

@property (nonatomic, copy) NSString *specification;

@property (nonatomic, assign) NSInteger paytype;

@property (nonatomic, copy) NSString *order_lastamount;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *wkpay_name;

@property (nonatomic, copy) NSString *seller_name;

@property (nonatomic, copy) NSString *wkpay_code;

@property (nonatomic, assign) NSInteger tuihuo;

@property (nonatomic, copy) NSString *pay_message;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *order_lastmethod;

@property (nonatomic, copy) NSString *payment_name;

@property (nonatomic, copy) NSString *order_sn;

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

@property (nonatomic, assign) NSInteger pay_time;

@property (nonatomic, assign) NSInteger received_time;

@property (nonatomic, copy) NSString *comment_time;

@property (nonatomic, copy) NSString *wkout_trade_no;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *baojia_date;

@property (nonatomic, copy) NSString *payment_code;

@property (nonatomic, assign) NSInteger baojia_time;

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *jine;

@property (nonatomic, copy) NSString *extension;

@property (nonatomic, assign) NSInteger seller_id;

@property (nonatomic, copy) NSString *goods_amount;

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, assign) NSInteger baojia_id;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, assign) NSInteger buyer_id;

@end

