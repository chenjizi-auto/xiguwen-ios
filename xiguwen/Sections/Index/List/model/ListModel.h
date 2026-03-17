//
//  ListModel.h
//  BoYi
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Userlist;

@interface ListModel : NSObject

@property (nonatomic, assign) NSInteger pageSum;

@property (nonatomic, assign) NSInteger numSum;

@property (nonatomic, strong) NSArray<Userlist *> *UserList;

@end
@interface Userlist : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *cn_name;

@property (nonatomic, copy) NSString *startPrice;

@property (nonatomic, copy) NSString *biz_star;

@property (nonatomic, copy) NSString *endPrice;

@property (nonatomic, copy) NSString *biz_price;

@property (nonatomic, copy) NSString *role_name;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *biz_view_count;

@property (nonatomic, copy) NSString *reputation;

@property (nonatomic, copy) NSString *biz_cover;

@property (nonatomic, copy) NSString *order;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *wedding;

@property (nonatomic, copy) NSString *price_type;

@property (nonatomic, copy) NSString *role_type_id;

@property (nonatomic, copy) NSString *follow;

@end

