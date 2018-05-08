//
//  shetuanZuppinModel.h
//  BoYi
//
//  Created by heng on 2018/2/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Chuangshirenzuopin,Chengyuanzuopin;
@interface shetuanZuppinModel : NSObject

@property (nonatomic, strong) NSArray<Chengyuanzuopin *> *chengyuan;

@property (nonatomic, strong) Chuangshirenzuopin *chuangshiren;


@end


@interface Chuangshirenzuopin : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *weddingcover;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *weddingplace;

@property (nonatomic, assign) NSInteger create_ti;

@property (nonatomic, assign) NSInteger commented;

@property (nonatomic, copy) NSString *statecontent;

@property (nonatomic, assign) NSInteger weddingtypeid;

@property (nonatomic, assign) NSInteger followed;

@property (nonatomic, assign) NSInteger update_ti;

@property (nonatomic, copy) NSString *weddingdescribe;

@property (nonatomic, assign) NSInteger evnum;

@property (nonatomic, assign) NSInteger examinetime;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, assign) NSInteger weddingexpenses;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger putaway;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *weddingtime;

@property (nonatomic, assign) NSInteger weddingenvironmentid;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, copy) NSString *username;

@end

@interface Chengyuanzuopin : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *weddingcover;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *weddingplace;

@property (nonatomic, assign) NSInteger create_ti;

@property (nonatomic, assign) NSInteger commented;

@property (nonatomic, copy) NSString *statecontent;

@property (nonatomic, assign) NSInteger weddingtypeid;

@property (nonatomic, assign) NSInteger followed;

@property (nonatomic, assign) NSInteger update_ti;

@property (nonatomic, copy) NSString *weddingdescribe;

@property (nonatomic, assign) NSInteger evnum;

@property (nonatomic, assign) NSInteger examinetime;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, assign) NSInteger weddingexpenses;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger putaway;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *weddingtime;

@property (nonatomic, assign) NSInteger weddingenvironmentid;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, copy) NSString *username;

@end

