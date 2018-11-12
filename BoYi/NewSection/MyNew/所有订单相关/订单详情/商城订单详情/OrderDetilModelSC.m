//
//  OrderDetilModelSC.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OrderDetilModelSC.h"

@implementation OrderDetilModelSC


+ (NSDictionary *)objectClassInArray{
    return @{@"youlike" : [YoulikeSCdetil class]};
}
@end
@implementation DataSCDetil

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [GoodsSCDetil class]};
}

@end


@implementation GoodsSCDetil

@end


@implementation YoulikeSCdetil

@end


