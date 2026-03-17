//
//  BaojiaDetilModel.h
//  BoYi
//
//  Created by heng on 2017/12/23.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UsernewbaojiaDetil,BaojianewDetil,Youlikebaojia;
@interface BaojiaDetilModel : NSObject

// custom code

@property (nonatomic, strong) BaojianewDetil *baojia;

@property (nonatomic, strong) UsernewbaojiaDetil *user;

@property (nonatomic, strong) NSArray<Youlikebaojia *> *youlike;

@property (nonatomic, assign) NSInteger userf;

@end
@interface UsernewbaojiaDetil : NSObject

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger sincerity;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *occupation;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *addr;

@property (nonatomic, assign) NSInteger college;

@property (nonatomic, assign) NSInteger evaluate;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger platform;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger team2;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, assign) NSInteger xueyuan;

@property (nonatomic, assign) NSInteger shiming;


@end

@interface BaojianewDetil : NSObject

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

@property (nonatomic, strong) NSArray<NSString *> *imglist;

@property (nonatomic, strong) NSArray<UIImageView *> *zl_imgviews;

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

@interface Youlikebaojia : NSObject

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) NSArray<NSString *> *imglist;

@property (nonatomic, assign) NSInteger quotationid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *price;

@end

