//
//  JizhangZhuShouModel.h
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ListJizhang,Tianjizhang;
@interface JizhangZhuShouModel : NSObject

// custom code

@property (nonatomic, assign) NSInteger dshuru;

@property (nonatomic, assign) NSInteger dzhichu;

@property (nonatomic, strong) NSArray<ListJizhang *> *list;



@end


@interface ListJizhang : NSObject

//@property (nonatomic, copy) NSString *occurrence;
//
//@property (nonatomic, assign) NSInteger zhichu;
//
//@property (nonatomic, assign) NSInteger shouru;

// 日期区分的记账列表数组
@property (nonatomic, strong) NSArray<Tianjizhang *> *tian;
// 日期
@property (nonatomic, strong) NSString *riqi;
// 收支统计
@property (nonatomic, assign) NSInteger ritongji;

@end

@interface Tianjizhang : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger create;

@property (nonatomic, strong) NSString *occurrence;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, assign) NSInteger aftermoney;

@property (nonatomic, assign) NSInteger type;


@end

