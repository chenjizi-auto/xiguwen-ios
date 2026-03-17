//
//  AnlieNewDetilModel.h
//  BoYi
//
//  Created by heng on 2017/12/24.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UsernewAnlie,Infoanlie,Photourlanlie,Pinglunanlie,Gdanli,teamWU;
@interface AnlieNewDetilModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Gdanli *> *gdanli;

@property (nonatomic, strong) UsernewAnlie *user;

@property (nonatomic, strong) NSArray<Pinglunanlie *> *pinglun;

@property (nonatomic, assign) NSInteger pinglunshu;

@property (nonatomic, strong) NSArray<teamWU *> *team;

@property (nonatomic, assign) NSInteger userf;

@property (nonatomic, strong) Infoanlie *info;

@end
@interface UsernewAnlie : NSObject

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

@property (nonatomic, copy) NSString *mobile;

@end

@interface Infoanlie : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *weddingcover;
@property (nonatomic, strong) UIImage *weddingcoverImage;

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

@property (nonatomic, strong) NSArray<Photourlanlie *> *photourl;

@property (nonatomic, assign) NSInteger weddingenvironmentid;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, copy) NSString *username;

@end

@interface Photourlanlie : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *photourl;

///图片
@property (nonatomic, strong) UIImageView *imageView;


@property (nonatomic, assign) NSInteger mycase_id;

@end

@interface Pinglunanlie : NSObject

@property (nonatomic, copy) NSString *touxiang;

@property (nonatomic, copy) NSString *ssj;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger mycaseid;

@property (nonatomic, strong) NSArray *commphoto;

@property (nonatomic, assign) NSInteger pingfen;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger anx;

@end

@interface Gdanli : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *weddingcover;
@property (nonatomic, strong) UIImage *weddingcoverImage;

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


@interface teamWU : NSObject



@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger zuidiqijia;

@property (nonatomic, copy) NSString *occupationid;

@property (nonatomic, copy) NSString *nickname;



@end
