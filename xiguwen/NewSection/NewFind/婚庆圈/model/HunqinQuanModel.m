//
//  HunqinQuanModel.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinQuanModel.h"

@implementation HunqinQuanModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"hunqinNewArray" : [Hunqinnewarray class]};
}
@end
@implementation Hunqinnewarray

+ (NSDictionary *)objectClassInArray{
    return @{@"photourl" : [PhotourlFaxian class]};
}

@end


@implementation PhotourlFaxian

@end


