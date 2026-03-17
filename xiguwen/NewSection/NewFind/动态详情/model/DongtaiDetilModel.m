//
//  DongtaiDetilModel.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "DongtaiDetilModel.h"

@implementation DongtaiDetilModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"zanlist" : [Zanlist class], @"photourl" : [PhotourldongtaiD class], @"commentlist" : [CommentlistDongtai class]};
}
@end
@implementation Zanlist

@end


@implementation PhotourldongtaiD

@end


@implementation CommentlistDongtai

+ (NSDictionary *)objectClassInArray{
    return @{@"xiaji" : [Xiaji class]};
}

@end


@implementation Xiaji

@end


