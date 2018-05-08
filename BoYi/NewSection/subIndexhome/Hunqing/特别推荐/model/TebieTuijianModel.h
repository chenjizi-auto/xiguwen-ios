//
//  TebieTuijianModel.h
//  BoYi
//
//  Created by heng on 2018/1/4.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Guanggaoarray;
@interface TebieTuijianModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Guanggaoarray *> *guanggaoArray;

@end
@interface Guanggaoarray : NSObject

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

