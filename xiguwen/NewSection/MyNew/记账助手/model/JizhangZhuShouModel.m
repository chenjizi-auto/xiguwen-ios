//
//  JizhangZhuShouModel.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "JizhangZhuShouModel.h"

@implementation JizhangZhuShouModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ListJizhang class]};
}
@end
@implementation ListJizhang

+ (NSDictionary *)objectClassInArray{
    return @{@"tian" : [Tianjizhang class]};
}

@end


@implementation Tianjizhang

@end


