//
//  SureDingdanNewModel.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "SureDingdanNewModel.h"

@implementation SureDingdanNewModel

// custom code
+ (NSDictionary *)objectClassInArray{
    return @{@"cartlist" : [Cartlist class]};
}
@end

@implementation Usersure

@end

@implementation Cartlist

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [Goodssure class]};
}

@end

@implementation Sellersure

@end

@implementation Goodssure

@end



