//
//  ShangchengFenleiModel.h
//  BoYi
//
//  Created by heng on 2018/2/28.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Shangchengfenlei,ChildrenshangChengfl;
@interface ShangchengFenleiModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Shangchengfenlei *> *shangChengFenlei;

@end


@interface Shangchengfenlei : NSObject

@property (nonatomic, assign) BOOL isselete;

@property (nonatomic, strong) NSArray<ChildrenshangChengfl *> *children;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *wapname;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface ChildrenshangChengfl : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *wapname;

@property (nonatomic, copy) NSString *wapimg;

@end

