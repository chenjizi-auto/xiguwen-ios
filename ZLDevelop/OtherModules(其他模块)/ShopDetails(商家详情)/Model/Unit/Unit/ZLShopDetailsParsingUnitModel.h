//
//  ZLShopDetailsParsingUnitModel.h
//  BoYi
//
//  Created by zhaolei on 2018/5/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsParsingModel.h"

@interface ZLShopDetailsParsingUnitModel : ZLShopDetailsParsingModel

///报价行模型解析
+ (NSMutableArray *)rowPriceModelDataWithDataSource:(NSArray *)array;
///作品行模型解析
+ (NSMutableArray *)rowSampleModelDataWithDataSource:(NSArray *)array;
///评价行模型解析
+ (NSMutableArray *)rowCommentModelDataWithDataSource:(NSArray *)array;
///动态行模型解析
+ (NSMutableArray *)rowDynamicModelDataWithDataSource:(NSArray *)array;
///档期行模型解析
+ (NSMutableArray *)rowTimeModelDataWithDataSource:(NSArray *)array;
///资料行模型解析
+ (NSMutableArray *)rowInfoModelDataWithDataSource:(NSDictionary *)dict;
///团队行模型解析
+ (NSMutableArray *)rowTeamModelDataWithDataSource:(NSArray *)array;

@end
