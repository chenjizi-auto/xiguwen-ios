//
//  ZLIntegralGoodsDetailModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/28.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsDetailModel.h"

@implementation ZLIntegralGoodsDetailModel

#pragma mark - 积分商品详情
+ (void)integralGoodsDetailWithInfoModel:(ZLIntegralGoodsDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"id"] = infoModel.keyId;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/integral/jifenxiangqing" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            //数据解析
            [self integralGoodsDetailModelWithInfoModel:infoModel ResponseObject:responseObject];
            //处理下文
            complete(sessionErrorState);
            return;
        }
        complete(sessionErrorState);
    }];
}

#pragma mark - 解析 - 积分商品详情
+ (void)integralGoodsDetailModelWithInfoModel:(ZLIntegralGoodsDetailModel *)infoModel ResponseObject:(NSDictionary *)responseObject {
    NSDictionary *dataDict = responseObject[@"data"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        if (dataDict.count) {
            NSDictionary *dict = dataDict[@"data"];
            ZLIntegralGoodsDetailModel *basicDetailModel = nil;
            ZLIntegralGoodsDetailModel *imageTextModel = nil;
            if ([dict isKindOfClass:[NSDictionary class]]) {
                if (dict.count) {
                    basicDetailModel = [self new];
                    basicDetailModel.cellType = ZLIntegralGoodsDetailCellTypeBasicDetail;
                    ZLIntegralGoodsDetailModel *rowModel = [self new];
                    rowModel.inventory = [dict[@"kucuun"] integerValue];
                    NSLog(@"%ld",rowModel.inventory);
                    NSMutableArray *arrayM = [NSMutableArray new];
                    rowModel.title = dict[@"name"];
                    CGFloat height = [rowModel.title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil].size.height;
                    height = height > 20.0 ? height : 20.0;
                    rowModel.titleHeight = height;
                    basicDetailModel.cellHeight = UIScreen.mainScreen.bounds.size.width + height + 70.0;
                    NSString *integral = dict[@"jifen"];
                    NSString *money = dict[@"jiage"];
                    integral = [money floatValue] > 0 ? [NSString stringWithFormat:@"%@积分+%@元",integral,money] : [NSString stringWithFormat:@"%@积分",integral];
                    rowModel.integral = integral;
                    rowModel.number = [NSString stringWithFormat:@"已兑换%@单",dict[@"yiduinum"]];
                    //轮播
                    NSArray *array = dict[@"tupian"];
                    if ([array isKindOfClass:[NSArray class]]) {
                        if (array.count) {
                            rowModel.urlsArray = array;
                        }
                    }
                    [arrayM addObject:rowModel];
                    basicDetailModel.unitModels = arrayM;
                    
                    //图文详情
                    array = dict[@"miaoshu"];
                    if ([array isKindOfClass:[NSArray class]]) {
                        if (array.count) {
                            imageTextModel = [self new];
                            imageTextModel.cellType = ZLIntegralGoodsDetailCellTypeImageTextDetail;
                            imageTextModel.cellHeight = 300.0;
                            imageTextModel.title = @"图文详情";
                            NSMutableArray *arrayM = [NSMutableArray new];
                            NSMutableArray *imageUrls = [NSMutableArray new];
                            for (NSInteger index = 0; index < array.count; index++) {
                                ZLIntegralGoodsDetailModel *rowModel = [ZLIntegralGoodsDetailModel new];
                                rowModel.imageUrl = array[index];
                                CGSize size = [self getImageSizeWithURL:[NSURL URLWithString:rowModel.imageUrl]];
                                CGFloat height = 0;
                                if (size.width > UIScreen.mainScreen.bounds.size.width) {
                                    height = UIScreen.mainScreen.bounds.size.width / size.width * size.height;
                                }else {
                                    height = size.width / UIScreen.mainScreen.bounds.size.width * size.height;
                                }
                                rowModel.cellHeight = height;
                                [arrayM addObject:rowModel];
                                [imageUrls addObject:rowModel.imageUrl];
                            }
                            imageTextModel.unitModels = arrayM;
                            imageTextModel.urlsArray = imageUrls;
                        }
                    }
                    
                }
            }
            //猜你喜欢
            ZLIntegralGoodsDetailModel *guessYouLikeModel = nil;
            NSArray *array = dataDict[@"youlike"];
            if ([array isKindOfClass:[NSArray class]]) {
                if (array.count) {
                    NSMutableArray  *arrayM = [NSMutableArray new];
                    guessYouLikeModel = [self new];
                    guessYouLikeModel.cellType = ZLIntegralGoodsDetailCellTypeGuessYouLike;
                    guessYouLikeModel.cellHeight = (UIScreen.mainScreen.bounds.size.width - 5.0) / 2 + 76.0;
                    guessYouLikeModel.title = @"猜你喜欢";
                    for (NSInteger index = 0; index < array.count; index++) {
                        ZLIntegralGoodsDetailModel *rowModel = [self new];
                        NSDictionary *unitDict = array[index];
                        rowModel.imageUrl = unitDict[@"tupian"];
                        rowModel.keyId = unitDict[@"id"];
                        rowModel.title = unitDict[@"name"];
                        rowModel.number = [NSString stringWithFormat:@"已兑%@",unitDict[@"yiduinum"]];
                        NSString *integral = unitDict[@"jifen"];
                        NSString *money = unitDict[@"jiage"];
                        integral = [money floatValue] > 0 ? [NSString stringWithFormat:@"%@积分+%@元",integral,money] : [NSString stringWithFormat:@"%@积分",integral];
                        rowModel.integral = integral;
                        [arrayM addObject:rowModel];
                    }
                    guessYouLikeModel.unitModels = arrayM;
                }
            }
            if (basicDetailModel || imageTextModel || guessYouLikeModel) {
                infoModel.unitModels = [NSMutableArray new];
            }
            if ([infoModel.unitModels isKindOfClass:[NSArray class]]) {
                [((NSMutableArray *)infoModel.unitModels) addObject:basicDetailModel];
                [((NSMutableArray *)infoModel.unitModels) addObject:imageTextModel];
                [((NSMutableArray *)infoModel.unitModels) addObject:guessYouLikeModel];
            }
        }
    }
}

/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

@end
