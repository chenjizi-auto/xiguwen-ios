//
//  SearchLsModel.m
//  BoYi
//
//  Created by heng on 2018/2/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SearchLsModel.h"

@implementation SearchLsModel


+ (NSDictionary *)objectClassInArray{
    return @{@"hot" : [HotSearch class], @"lishi" : [LishiSearch class]};
}
@end
@implementation HotSearch

@end


@implementation LishiSearch

@end


