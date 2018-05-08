//
//  LookMingxiNewModel.m
//  BoYi
//
//  Created by heng on 2018/2/27.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "LookMingxiNewModel.h"

@implementation LookMingxiNewModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"lookMingxi" : [Lookmingxi class]};
}
@end
@implementation Lookmingxi

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [Datamingxilook class]};
}

@end


@implementation Datamingxilook

@end


