//
//  SearchLsModel.h
//  BoYi
//
//  Created by heng on 2018/2/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HotSearch,LishiSearch;
@interface SearchLsModel : NSObject

@property (nonatomic, strong) NSArray<HotSearch *> *hot;

@property (nonatomic, strong) NSArray<LishiSearch *> *lishi;

@end
@interface HotSearch : NSObject

@property (nonatomic, assign) NSInteger createt;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *leixin;

@end

@interface LishiSearch : NSObject

@property (nonatomic, assign) NSInteger createt;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *leixin;

@end

