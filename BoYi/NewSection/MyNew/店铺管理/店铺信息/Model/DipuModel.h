//
//  DipuModel.h
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DipuModel : NSObject
@property(nonatomic,copy)NSString * background;
@property(nonatomic,copy)NSString*  cityid;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString*  countyid;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString*  occupationid;
@property(nonatomic,assign)NSInteger  onlinestatus;
@property(nonatomic,copy)NSString*  provinceid;
@property(nonatomic,copy)NSArray<NSString*> * shopimg;
@property(nonatomic,copy)NSString * site;
@property(nonatomic,assign)NSInteger  team;
@property(nonatomic,assign)NSInteger  usertype;
@property(nonatomic,assign)NSInteger  userid;
@end

@interface DipuIficationObjc : NSObject
@property(nonatomic,copy)NSString * wapimg;
@property(nonatomic,copy)NSString*  proname;
@property(nonatomic,assign)NSInteger  occupationid;
@end




#pragma 省 市 县
@interface DipuCityModel :NSObject
@property(nonatomic,assign)NSUInteger cityid ;
@property(nonatomic,assign)NSUInteger id ;
@property(nonatomic,copy)NSString*  initial;
@property(nonatomic,assign)NSUInteger isnew;
@property(nonatomic,assign)NSUInteger lv ;
@property(nonatomic,copy)NSString* name ;
@property(nonatomic,assign)NSUInteger  pid ;
@property(nonatomic,copy)NSString* pinyin ;
@property(nonatomic,assign)NSUInteger status;
@property(nonatomic,assign)NSUInteger weigh ;
@property(nonatomic,copy)NSArray * city;//市级别
@property(nonatomic,copy)NSArray * county;//县级别
@property(nonatomic,copy)NSArray<DipuCityModel*> *cityModel;
@property(nonatomic,copy)NSArray<DipuCityModel*> *countyModel;
@end


