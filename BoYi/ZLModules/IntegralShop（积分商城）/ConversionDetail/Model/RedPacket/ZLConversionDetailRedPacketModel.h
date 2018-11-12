//
//  ZLConversionDetailRedPacketModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/24.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLConversionDetailModel.h"

@interface ZLConversionDetailRedPacketModel : ZLConversionDetailModel

///解析 - 红包兑换
+ (NSMutableArray *)conversionDetailRedPacketModelWithArray:(NSArray *)array;

@end
