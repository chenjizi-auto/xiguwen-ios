//
//  allTpyeModel.m
//  BoYi
//
//  Created by heng on 2018/1/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "allTpyeModel.h"

@implementation allTpyeModel




+ (NSDictionary *)objectClassInArray{
    return @{@"allTypeArray" : [Alltypearray class]};
}
@end



@implementation Alltypearray

+ (NSDictionary *)objectClassInArray{
    return @{@"children" : [ChildrenAllType class]};
}

@end


@implementation ChildrenAllType

@end


