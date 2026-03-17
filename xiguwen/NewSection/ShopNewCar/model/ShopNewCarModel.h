//
//  ShopNewCarModel.h
//  BoYi
//
//  Created by heng on 2018/1/6.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShopNewCarListarray,Goods,Seller;

@interface ShopNewCarModel : NSObject

@property (nonatomic, strong) NSArray<ShopNewCarListarray *> *shopNewCarListarray;

@end

@interface ShopNewCarListarray : NSObject

@property (nonatomic, assign) NSInteger store_id;

@property (nonatomic, strong) NSArray<Goods *> *goods;

@property (nonatomic, strong) Seller *seller;

@property (nonatomic, assign) NSInteger kinds;

@property (nonatomic, assign) BOOL isSele;

@end

@interface Goods : NSObject

@property (nonatomic, assign) BOOL isSele;

@property (nonatomic, assign) NSInteger rec_id;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger store_id;

@property (nonatomic, assign) NSInteger baojia_id;

@property (nonatomic, assign) NSInteger baojia_time;

@property (nonatomic, assign) NSInteger dikoutotal;

@property (nonatomic, assign) NSInteger paytype;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger subtotal;

@property (nonatomic, copy) NSString *goods_image;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *baojia_date;

@property (nonatomic, copy) NSString *baojia_image;

@property (nonatomic, copy) NSString *baojia_name;

@property (nonatomic, copy) NSString *dikou;

@property (nonatomic, copy) NSString *partprice;

@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *session_id;
@property (nonatomic, copy) NSString *specification;


@end
@interface Seller : NSObject


@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *nickname;

@end

@interface ShopCarTuiJian : NSObject

@property (nonatomic, copy) NSString *xueyuanname;

@property (nonatomic, assign) NSInteger isshopvip;

@property (nonatomic, assign) NSInteger sincerity;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger xueyuan;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger team;

@property (nonatomic, assign) NSInteger college;

@property (nonatomic, assign) NSInteger evaluate;

@property (nonatomic, copy) NSString *occupationid;

@property (nonatomic, assign) NSInteger platform;

@property (nonatomic, assign) NSInteger team2;

@property (nonatomic, assign) NSInteger shopnum;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger anlinum;

@property (nonatomic, copy) NSString *zuidijia;

@property (nonatomic, assign) NSInteger shiming;

@end
