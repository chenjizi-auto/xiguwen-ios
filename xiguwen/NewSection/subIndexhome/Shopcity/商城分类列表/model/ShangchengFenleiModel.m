//
//  ShangchengFenleiModel.m
//  BoYi
//
//  Created by heng on 2018/2/28.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengFenleiModel.h"

@implementation ShangchengFenleiModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"shangChengFenlei" : [Shangchengfenlei class]};
}
@end



@implementation Shangchengfenlei

+ (NSDictionary *)objectClassInArray{
    return @{@"children" : [ChildrenshangChengfl class]};
}

@end


@implementation ChildrenshangChengfl

@end


