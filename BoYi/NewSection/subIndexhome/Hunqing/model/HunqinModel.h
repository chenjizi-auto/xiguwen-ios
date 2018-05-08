//
//  HunqinModel.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Remengeren,Dataone,Rementuandui,Datatwo,Remenhuodong,Rmhd3,Rmhd2,Rmhd5,Rmhd1,Rmhd4,Youlike,Xiaoguanggaoyi,Guanggaolunbo,Photourl;
@interface HunqinModel : NSObject


@property (nonatomic, strong) Remengeren *remengeren;

@property (nonatomic, strong) Rementuandui *rementuandui;

@property (nonatomic, strong) NSArray<Youlike *> *youlike;

@property (nonatomic, strong) Remenhuodong *remenhuodong;

@property (nonatomic, strong) NSArray<Xiaoguanggaoyi *> *xiaoguanggaoyi;

@property (nonatomic, strong) NSArray<Guanggaolunbo *> *guanggaolunbo;


@end

@interface Remengeren : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<Dataone *> *data;

@end

@interface Dataone : NSObject

@property (nonatomic, assign) NSInteger aptype;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *createtime;

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

@interface Rementuandui : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<Datatwo *> *data;

@end

@interface Datatwo : NSObject

@property (nonatomic, assign) NSInteger aptype;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *createtime;

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

@interface Remenhuodong : NSObject

@property (nonatomic, strong) Rmhd3 *rmhd3;

@property (nonatomic, strong) Rmhd2 *rmhd2;

@property (nonatomic, strong) Rmhd5 *rmhd5;

@property (nonatomic, strong) Rmhd1 *rmhd1;

@property (nonatomic, strong) Rmhd4 *rmhd4;

@end

@interface Rmhd3 : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Rmhd2 : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Rmhd5 : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Rmhd1 : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Rmhd4 : NSObject

@property (nonatomic, assign) NSInteger adid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *miaoshu;

@property (nonatomic, copy) NSString *src;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface Youlike : NSObject



@property (nonatomic, copy) NSString *shopimg;

@property (strong, nonatomic) UIImage *bigImageurl;

@property (nonatomic, copy) NSString *video_url;

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, strong) NSArray<Photourl *> *photourl;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *weddingdescribe;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, copy) NSString *weddingcover;

@property (nonatomic, copy) NSString *occupationid;

@property (nonatomic, assign) NSInteger followed;

@property (nonatomic, copy) NSString *typee;

@property (nonatomic, assign) NSInteger weddingexpenses;

@property (nonatomic, assign) NSInteger pinluns;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *price;

@end

@interface Xiaoguanggaoyi : NSObject

@property (nonatomic, assign) NSInteger aptype;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *createtime;

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

@interface Guanggaolunbo : NSObject

@property (nonatomic, assign) NSInteger aptype;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, copy) NSString *createtime;

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



@interface Photourl : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger atlas_id;

@property (nonatomic, copy) NSString *photo;

@end
