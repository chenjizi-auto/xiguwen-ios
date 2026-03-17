//
//  ShouHuodizhiModel.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Addressarray;
@interface ShouHuodizhiModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Addressarray *> *addressArray;

@end
@interface Addressarray : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger provinceid;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) NSInteger hot;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger countyid;

@property (nonatomic, copy) NSString *county;

@property (nonatomic, copy) NSString *site;

@end

