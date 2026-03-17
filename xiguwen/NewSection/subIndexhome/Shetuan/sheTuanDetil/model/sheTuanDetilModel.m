//
//  ShetuanDetilModel.m
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShetuanDetilModel.h"

@implementation ShetuanDetilModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"dynamiclist" : [Dynamiclist class]};
}
@end
@implementation Infoshetuan

@end


@implementation Dynamiclist

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [Pics class]};
}

@end


@implementation Pics

@end


