//
//  HunqinQuanModel.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hunqinnewarray,PhotourlFaxian;
@interface HunqinQuanModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Hunqinnewarray *> *hunqinNewArray;






@end
@interface Hunqinnewarray : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger commentnum;


@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger shifouzan;

@property (nonatomic, copy) NSString *create_ti;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSArray<PhotourlFaxian *> *photourl;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *theteam;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, assign) NSInteger zan;

@end

@interface PhotourlFaxian : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger mydynamicid;

@property (nonatomic, copy) NSString *photourl;

@end

