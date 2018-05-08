//
//  HunqinModel.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "HunqinModel.h"

@implementation HunqinModel

// custom code



+ (NSDictionary *)objectClassInArray{
    return @{@"youlike" : [Youlike class], @"xiaoguanggaoyi" : [Xiaoguanggaoyi class], @"guanggaolunbo" : [Guanggaolunbo class]};
}
@end

@implementation Remengeren

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [Dataone class]};
}

@end


@implementation Dataone

@end


@implementation Rementuandui

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [Datatwo class]};
}

@end


@implementation Datatwo

@end


@implementation Remenhuodong

@end


@implementation Rmhd3

@end


@implementation Rmhd2

@end


@implementation Rmhd5

@end


@implementation Rmhd1

@end


@implementation Rmhd4

@end


@implementation Youlike

+ (NSDictionary *)objectClassInArray{
    return @{@"photourl" : [Photourl class]};
}
@end


@implementation Xiaoguanggaoyi

@end


@implementation Guanggaolunbo

@end

@implementation Photourl

@end


