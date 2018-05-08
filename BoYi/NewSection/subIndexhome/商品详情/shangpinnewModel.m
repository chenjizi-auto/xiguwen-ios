//
//  shangpinnewModel.m
//  BoYi
//
//  Created by heng on 2018/2/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "shangpinnewModel.h"

@implementation shangpinnewModel
+ (NSDictionary *)objectClassInArray{
    return @{@"tebietuijian" : [TebietuijianSP class]};
}
@end

@implementation GuigeSP
+ (NSDictionary *)objectClassInArray{
    return @{@"sku" : [SkuSP class]};
}
@end
@implementation SkuSP

@end
@implementation UserSP

@end
@implementation ShangpinSP

@end

@implementation TebietuijianSP

@end
