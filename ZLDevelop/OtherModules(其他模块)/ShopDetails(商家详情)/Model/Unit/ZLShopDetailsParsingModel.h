//
//  ZLShopDetailsParsingModel.h
//  BoYi
//
//  Created by zhaolei on 2018/5/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsModel.h"

@interface ZLShopDetailsParsingModel : ZLShopDetailsModel

///分发解析
+ (void)modelDataWithResponseObject:(NSDictionary *)responseObject Model:(ZLShopDetailsModel *)model;

@end
