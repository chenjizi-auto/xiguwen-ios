//
//  ShopNewCarModel.m
//  BoYi
//
//  Created by heng on 2018/1/6.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShopNewCarModel.h"

@implementation ShopNewCarModel

+ (NSDictionary *)objectClassInArray{
    return @{@"shopNewCarListarray" : [ShopNewCarListarray class]};
}

@end
@implementation ShopNewCarListarray

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [Goods class]};
}

@end

@implementation Goods

@end

@implementation Seller

@end
@implementation ShopCarTuiJian


@end

