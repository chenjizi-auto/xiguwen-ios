//
//  NewShangjiaDongtaiModel.m
//  BoYi
//
//  Created by heng on 2018/2/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NewShangjiaDongtaiModel.h"

@implementation NewShangjiaDongtaiModel


+ (NSDictionary *)objectClassInArray{
    return @{@"dongtaiArray" : [Dongtaiarray class]};
}
@end
@implementation Dongtaiarray

+ (NSDictionary *)objectClassInArray{
    return @{@"photourl" : [Photourldongtai class]};
}

@end


@implementation Photourldongtai

@end


