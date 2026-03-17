//
//  NewShangjiaModel.m
//  BoYi
//
//  Created by heng on 2017/12/21.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewShangjiaModel.h"

@implementation NewShangjiaModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"tuijiantd" : [Tuijiantd class]};
}
@end





@implementation UserinfonewShangjia

@end


@implementation Usernew

@end


@implementation Zuopingnew

+ (NSDictionary *)objectClassInArray{
    return @{@"zuopin" : [Zuopinnewfen class]};
}

@end


@implementation Zuopinnewfen

+ (NSDictionary *)objectClassInArray{
    return @{@"photou" : [Photou class]};
}

@end


@implementation Photou

@end


@implementation Baojianewtou

+ (NSDictionary *)objectClassInArray{
    return @{@"baojia" : [Baojiashangjiafen class]};
}

@end


@implementation Baojiashangjiafen

@end


@implementation Tuijiantd

@end

@implementation Xinyu

@end

