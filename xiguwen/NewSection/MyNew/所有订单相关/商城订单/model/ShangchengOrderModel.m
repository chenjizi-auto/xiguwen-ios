//
//  ShangchengOrderModel.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengOrderModel.h"

@implementation ShangchengOrderModel

// custom code


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DataShangcheng class]};
}
@end
@implementation DataShangcheng

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [Goodsshangcheng class]};
}

@end


@implementation Buyer_Infoshangcheng

@end


@implementation Goodsshangcheng

@end


