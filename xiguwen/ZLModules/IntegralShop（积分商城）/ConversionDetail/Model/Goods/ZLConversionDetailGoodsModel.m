//
//  ZLConversionDetailGoodsModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/24.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLConversionDetailGoodsModel.h"

@implementation ZLConversionDetailGoodsModel

#pragma mark - 解析 - 商品兑换
+ (NSMutableArray *)conversionDetailGoodsModelWithArray:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]]) {
        if (array.count) {
            NSMutableArray *arrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < array.count; index++) {
                ZLConversionDetailGoodsModel *model = [self new];
                NSDictionary *dict = array[index];
                model.title = dict[@"name"];
                CGFloat height = [model.title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 155.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
                height = height > 20.0 ? height : 20.0;
                model.titleHeight = height > 55.0 ? 55.0 : height;
                model.keyId = dict[@"id"];
                model.imageUrl = dict[@"img"];
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
