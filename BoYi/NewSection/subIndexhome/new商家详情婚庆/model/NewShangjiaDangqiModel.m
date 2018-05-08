//
//  NewShangjiaDangqiModel.m
//  BoYi
//
//  Created by heng on 2018/2/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NewShangjiaDangqiModel.h"

@implementation NewShangjiaDangqiModel



+ (NSDictionary *)objectClassInArray{
    return @{@"dangqinNewArray" : [Dangqinnewarray class]};
}
@end



@implementation Dangqinnewarray

+ (NSDictionary *)objectClassInArray{
    return @{@"dangqi" : [DangqiNew class]};
}

@end


@implementation DangqiNew

@end


