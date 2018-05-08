//
//  shangjiaPinglunModel.h
//  BoYi
//
//  Created by heng on 2018/2/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shangjiapinglun;
@interface shangjiaPinglunModel : NSObject

@property (nonatomic, strong) NSArray<Shangjiapinglun *> *shangjiaPinglun;

@end
@interface Shangjiapinglun : NSObject

@property (nonatomic, assign) NSInteger sign;

@property (nonatomic, copy) NSString *replay_time;

@property (nonatomic, copy) NSString *parent_id;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger comment_id;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *site;

@property (nonatomic, copy) NSString *inviter;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger logintime;

@property (nonatomic, assign) NSInteger createtime;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger order_score;

@property (nonatomic, assign) NSInteger isuserivip;

@property (nonatomic, assign) NSInteger anonymous;

@property (nonatomic, assign) NSInteger usertype;

@property (nonatomic, strong) NSArray *pictures;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *replay_content;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger seller_id;

@property (nonatomic, assign) NSInteger authentication;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger evaluate;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *pvouchers;

//@property (nonatomic, copy) NSString *register;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger birthday;

@property (nonatomic, copy) NSString *vouchers;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, copy) NSString *rec_id;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, copy) NSString *isuseriviptoken;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, copy) NSString *weixin;

@property (nonatomic, assign) NSInteger userivipstat;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *identitynum;

@property (nonatomic, copy) NSString *payvouchers;

@property (nonatomic, assign) NSInteger onlinestatus;

@property (nonatomic, assign) NSInteger userivipendt;

@property (nonatomic, copy) NSString *replay_user_id;

@end

