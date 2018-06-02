//
//  ZLConversionDetailRedPacketModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/24.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLConversionDetailRedPacketModel.h"

@implementation ZLConversionDetailRedPacketModel

#pragma mark - 解析 - 红包兑换
+ (NSMutableArray *)conversionDetailRedPacketModelWithArray:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]]) {
        if (array.count) {
            NSMutableArray *arrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < array.count; index++) {
                ZLConversionDetailRedPacketModel *model = [self new];
                NSDictionary *dict = array[index];
                model.title = dict[@"name"];
                model.imageUrl = dict[@"img"];
                model.time = dict[@"date"];
                model.integral = [NSString stringWithFormat:@"%@积分",dict[@"jifen"]];
                NSInteger status = [dict[@"status"] integerValue];
                if (status == 1) {
                    model.state = @"待付款";
                    model.stateColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
                }else if (status == 2) {
                    model.state = @"待发货";
                    model.stateColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
                }else if (status == 3) {
                    model.state = @"待收货";
                    model.stateColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
                }else if (status == 4) {
                    model.state = @"交易成功";
                    model.stateColor = [UIColor colorWithRed:31/255.0 green:170/255.0 blue:105/255.0 alpha:1.0];
                }else {
                    model.state = @"交易关闭";
                    model.stateColor = [UIColor colorWithRed:255/255.0 green:55/255.0 blue:55/255.0 alpha:1.0];
                }
                [arrayM addObject:model];
            }
            return arrayM;
        }
    }
    return nil;
}

@end
