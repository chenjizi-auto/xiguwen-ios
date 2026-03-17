

//
//  typeModel.h
//  BoYi
//
//  Created by apple on 2017/8/28.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Esarray;

@interface typeModel : NSObject
@property (nonatomic, strong) NSArray<Esarray *> *esArray;
@end

@interface Esarray : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger type;

@end

