//
//  AnlieNewDetilModel.m
//  BoYi
//
//  Created by heng on 2017/12/24.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieNewDetilModel.h"

@implementation AnlieNewDetilModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"pinglun" : [Pinglunanlie class], @"gdanli" : [Gdanli class],@"team" : [teamWU class]};
}
@end
@implementation UsernewAnlie

@end


@implementation Infoanlie

+ (NSDictionary *)objectClassInArray{
    return @{@"photourl" : [Photourlanlie class]};
}

@end


@implementation Photourlanlie

@end


@implementation Pinglunanlie

@end


@implementation Gdanli

@end
@implementation teamWU

@end


