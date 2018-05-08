//
//  sureDingdanSCmodel.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "sureDingdanSCmodel.h"

@implementation sureDingdanSCmodel


+ (NSDictionary *)objectClassInArray{
    return @{@"cartlist" : [CartlistSC class]};
}
@end
@implementation UserSC

@end


@implementation CartlistSC

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [GoodsSC class]};
}

@end


@implementation SellerSC

@end


@implementation GoodsSC

@end


