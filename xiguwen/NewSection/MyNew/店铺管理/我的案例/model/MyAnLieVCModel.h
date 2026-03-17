//
//  MyAnLieVCModel.h
//  BoYi
//
//  Created by heng on 2018/1/20.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAnLieVCModel : NSObject

// custom code
@property (nonatomic, assign) NSInteger clicked;
@property (nonatomic, assign) NSInteger commented;
@property (nonatomic, assign) NSInteger create_ti;
@property (nonatomic, assign) NSInteger evnum;
@property (nonatomic, strong) NSString *examinetime;
@property (nonatomic, assign) NSInteger followed;
@property (nonatomic, assign) NSInteger goodscore;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger putaway;
@property (nonatomic, assign) NSInteger pv;
@property (nonatomic, strong) NSString *statecontent;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger update_ti;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *weddingcover;
@property (nonatomic, strong) NSString *weddingdescribe;
@property (nonatomic, assign) NSInteger weddingenvironmentid;
@property (nonatomic, assign) NSInteger weddingexpenses;
@property (nonatomic, strong) NSString *weddingplace;
@property (nonatomic, strong) NSString *weddingtime;
@property (nonatomic, assign) NSInteger weddingtypeid;
@property (nonatomic, assign) NSInteger weigh;
@property (nonatomic, strong) NSMutableArray *imglist;

@property (nonatomic, strong) NSString *weddingtype;
@property (nonatomic, strong) NSString *weddingenvironment;

@end
