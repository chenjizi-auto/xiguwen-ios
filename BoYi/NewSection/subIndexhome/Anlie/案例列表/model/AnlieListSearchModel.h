//
//  AnlieListSearchModel.h
//  BoYi
//
//  Created by heng on 2017/12/27.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Anlielistsearcharray;
@interface AnlieListSearchModel : NSObject

@property (nonatomic, strong) NSArray<Anlielistsearcharray *> *anlielistsearcharray;

@end

@interface Anlielistsearcharray : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *weddingcover;

@property (nonatomic, copy) NSString *weddingplace;

@property (nonatomic, assign) NSInteger create_ti;

@property (nonatomic, assign) NSInteger commented;

@property (nonatomic, assign) NSInteger followed;

@property (nonatomic, assign) NSInteger weddingtypeid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *weddingdescribe;

@property (nonatomic, assign) NSInteger goodscore;

@property (nonatomic, assign) NSInteger weigh;

@property (nonatomic, assign) NSInteger weddingexpenses;

@property (nonatomic, copy) NSString *occupationid;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *weddingtime;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger weddingenvironmentid;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, assign) NSInteger follow;

@end

