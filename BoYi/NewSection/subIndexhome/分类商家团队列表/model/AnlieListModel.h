//
//  AnlieListModel.h
//  BoYi
//
//  Created by heng on 2017/12/18.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shangjiatuanduilist;
@interface AnlieListModel : NSObject


@property (nonatomic, strong) NSArray<Shangjiatuanduilist *> *shangjiaTuanduiList;


@end
@interface Shangjiatuanduilist : NSObject

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, assign) NSInteger isshopvip;

@property (nonatomic, assign) NSInteger sincerity;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger college;

@property (nonatomic, assign) NSInteger anlinum;

@property (nonatomic, assign) NSInteger evaluate;

@property (nonatomic, copy) NSString *occupationid;

@property (nonatomic, assign) NSInteger platform;

@property (nonatomic, assign) NSInteger shiming;

@property (nonatomic, assign) NSInteger team;

@property (nonatomic, assign) NSInteger team2;

@property (nonatomic, assign) NSInteger shopnum;

@property (nonatomic, assign) NSInteger zuidijia;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger xueyuan;

@property (nonatomic, copy) NSString *xueyuanname;


@end

