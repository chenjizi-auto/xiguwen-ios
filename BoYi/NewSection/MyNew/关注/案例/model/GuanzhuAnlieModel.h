//
//  GuanzhuAnlieModel.h
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnliGuanzhuModel;
@interface GuanzhuAnlieModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<AnliGuanzhuModel *> *anli;

@end
@interface AnliGuanzhuModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger commented;

@property (nonatomic, copy) NSString *weddingdescribe;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *weddingcover;

@property (nonatomic, copy) NSString *titlea;

@property (nonatomic, assign) NSInteger followed;

@property (nonatomic, copy) NSString *weddingdescribea;

@property (nonatomic, assign) NSInteger weddingexpenses;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger follow;

@end

