//
//  IsfuyanModel.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Fuyan;
@interface IsfuyanModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Fuyan *> *fuyan;

@end
@interface Fuyan : NSObject

@property (nonatomic, assign) NSInteger fuyannum;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *fuyan;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *createti;

@end

