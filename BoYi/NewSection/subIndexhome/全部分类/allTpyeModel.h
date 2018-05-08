//
//  allTpyeModel.h
//  BoYi
//
//  Created by heng on 2018/1/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Alltypearray,ChildrenAllType;
@interface allTpyeModel : NSObject

@property (nonatomic, strong) NSArray<Alltypearray *> *allTypeArray;



@end

@interface Alltypearray : NSObject

@property (nonatomic, strong) NSArray<ChildrenAllType *> *children;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *wapname;

@property (nonatomic, copy) NSString *wapimg;

@end

@interface ChildrenAllType : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *wapname;

@end

