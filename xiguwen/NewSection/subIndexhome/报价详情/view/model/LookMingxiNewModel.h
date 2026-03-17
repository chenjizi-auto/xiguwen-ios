//
//  LookMingxiNewModel.h
//  BoYi
//
//  Created by heng on 2018/2/27.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Lookmingxi,Datamingxilook;
@interface LookMingxiNewModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Lookmingxi *> *lookMingxi;

@end
@interface Lookmingxi : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<Datamingxilook *> *data;

@property (nonatomic, assign) NSInteger xiaoji;

@end

@interface Datamingxilook : NSObject

@property (nonatomic, copy) NSString *a;

@property (nonatomic, assign) NSInteger b;

@end

