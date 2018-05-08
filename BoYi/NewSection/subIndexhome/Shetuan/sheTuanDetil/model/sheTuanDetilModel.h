//
//  ShetuanDetilModel.h
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Infoshetuan,Dynamiclist,Pics;
@interface ShetuanDetilModel : NSObject

// custom code

@property (nonatomic, assign) NSInteger quanbudongtai;

@property (nonatomic, strong) Infoshetuan *info;

@property (nonatomic, strong) NSArray<Dynamiclist *> *dynamiclist;

@end
@interface Infoshetuan : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *logourl;

@property (nonatomic, copy) NSString *profile;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *appphotourl;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger create_ti;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger update_ti;

@property (nonatomic, assign) NSInteger clicked;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *name;

@end

@interface Dynamiclist : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, assign) NSInteger myzan;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *create_ti;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger pls;

@property (nonatomic, assign) NSInteger zan;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSArray<Pics *> *pics;

@property (nonatomic, copy) NSString *content;

@end

@interface Pics : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger mydynamicid;

@property (nonatomic, copy) NSString *photourl;

@end

