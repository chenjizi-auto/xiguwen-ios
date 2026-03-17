//
//  fenLeiModel.h
//  BoYi
//
//  Created by heng on 2018/1/26.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Fenleiarray;
@interface fenLeiModel : NSObject

@property (nonatomic, strong) NSArray<Fenleiarray *> *fenleiArray;

@end
@interface Fenleiarray : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, copy) NSString *wapname;

@property (nonatomic, copy) NSString *proname;

@property (nonatomic, copy) NSString *wapimg;

@property (nonatomic, assign) BOOL isSelete;

@end

