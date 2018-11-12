//
//  OrderDetilModelNew.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OrderDetilModelNew.h"

@implementation OrderDetilModelNew


+ (NSDictionary *)objectClassInArray{
    return @{@"youlike" : [YoulikeOrderDm class]};
}
@end
@implementation DataorderDe

+ (NSDictionary *)objectClassInArray{
    return @{@"hunqing" : [HunqingOrderm class]};
}

@end


@implementation HunqingOrderm

@end


@implementation YoulikeOrderDm

@end


