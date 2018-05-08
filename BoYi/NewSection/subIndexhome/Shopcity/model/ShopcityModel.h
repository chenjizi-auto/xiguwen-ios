//
//  ShopcityModel.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>



@class Bimai,Rmhd3sc,Rmhd2sc,Rmhd5sc,Rmhd1sc,Rmhd4sc,Youhaohuosc,Youlove,Xiaoguanggaoyisc,Renmenpinpai,Remenshangpinsc,Guanggaolunbosc;
@interface ShopcityModel : NSObject

// custom code
@property (nonatomic, strong) NSArray<Renmenpinpai *> *renmenpinpai;

@property (nonatomic, strong) Bimai *bimai;

@property (nonatomic, strong) NSArray<Youlove *> *youlove;

@property (nonatomic, strong) NSArray<Guanggaolunbosc *> *guanggaolunbo;

@property (nonatomic, strong) NSArray<Remenshangpinsc *> *remenshangpin;

@property (nonatomic, strong) Youhaohuosc *youhaohuo;

@property (nonatomic, strong) NSArray<Xiaoguanggaoyisc *> *xiaoguanggaoyi;
@end

@interface Bimai : NSObject

@property (nonatomic, strong) Rmhd3sc *rmhd3;

@property (nonatomic, strong) Rmhd2sc *rmhd2;

@property (nonatomic, strong) Rmhd5sc *rmhd5;

@property (nonatomic, strong) Rmhd1sc *rmhd1;

@property (nonatomic, strong) Rmhd4sc *rmhd4;

@end

@interface Rmhd3sc : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Rmhd2sc : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Rmhd5sc : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Rmhd1sc : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Rmhd4sc : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Youhaohuosc : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Youlove : NSObject

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger follows;

@property (nonatomic, copy) NSString *shopimg;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *shopname;

@end

@interface Xiaoguanggaoyisc : NSObject

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

@interface Renmenpinpai : NSObject

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

@interface Remenshangpinsc : NSObject

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, assign) NSInteger follows;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, assign) NSInteger afollow;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, strong) NSArray<NSString *> *shopimg;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *shopname;

@end

@interface Guanggaolunbosc : NSObject

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

