//
//  NewShangjiaDongtaiModel.h
//  BoYi
//
//  Created by heng on 2018/2/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dongtaiarray,Photourldongtai;
@interface NewShangjiaDongtaiModel : NSObject

@property (nonatomic, strong) NSArray<Dongtaiarray *> *dongtaiArray;

@end
@interface Dongtaiarray : NSObject


@property (nonatomic, assign) NSInteger dianzan;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *theteam;

@property (nonatomic, copy) NSString *create_ti;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger commentnum;

@property (nonatomic, copy) NSString *contentm;

@property (nonatomic, assign) NSInteger zan;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSArray<Photourldongtai *> *photourl;

@property (nonatomic, copy) NSString *content;

@end

@interface Photourldongtai : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger mydynamicid;

@property (nonatomic, copy) NSString *photourl;

@end

