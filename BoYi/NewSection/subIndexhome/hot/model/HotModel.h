//
//  HotModel.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Remensjhot,Guanggaolunbohot;
@interface HotModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Remensjhot *> *remensj;

@property (nonatomic, strong) NSArray<Guanggaolunbohot *> *guanggaolunbo;

@end
@interface Remensjhot : NSObject

@property (nonatomic, assign) NSInteger isshopvip;


@property (nonatomic, assign) NSInteger shiming;

@property (nonatomic, assign) NSInteger sincerity;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger college;

@property (nonatomic, assign) NSInteger anlinum;

@property (nonatomic, assign) NSInteger evaluate;

@property (nonatomic, copy) NSString *occupationid;

@property (nonatomic, assign) NSInteger platform;

@property (nonatomic, assign) NSInteger team2;

@property (nonatomic, assign) NSInteger shopnum;

@property (nonatomic, copy) NSString *zuidijia;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger usertype;

@property (nonatomic, assign) NSInteger xueyuan;

@end

@interface Guanggaolunbohot : NSObject

@property (nonatomic, assign) NSInteger aptype;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, assign) NSInteger createtime;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, assign) NSInteger adtypeid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, copy) NSString *site;

@property (nonatomic, copy) NSString *wapimg;

@property (nonatomic, assign) NSInteger aptid;

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, assign) NSInteger status;

@end

