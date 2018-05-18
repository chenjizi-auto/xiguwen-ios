//
//  ZLShopDetailsParsingUnitModel.m
//  BoYi
//
//  Created by zhaolei on 2018/5/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsParsingUnitModel.h"

@implementation ZLShopDetailsParsingUnitModel

#pragma mark - 报价
+ (NSMutableArray *)rowPriceModelDataWithDataSource:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        rowModel.headImageUrlPath = dict[@"imglist"];
        rowModel.title = dict[@"name"];
        rowModel.price = [NSString stringWithFormat:@"￥%d起",[dict[@"price"] intValue]];
        rowModel.number = [NSString stringWithFormat:@"已售 %d",[dict[@"num"] intValue]];
        rowModel.cellHeight = 190.0;
        [arrayM addObject:rowModel];
    }
    return arrayM;
}

#pragma mark - 作品
+ (NSMutableArray *)rowSampleModelDataWithDataSource:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        if ([dict[@"type"] isEqualToString:@"al"]) {
            rowModel.headImageUrlPath = dict[@"weddingcover"];
            rowModel.title = dict[@"title"];
            rowModel.intro = dict[@"weddingdescribe"];
            rowModel.price = [NSString stringWithFormat:@"￥%d",[dict[@"weddingexpenses"] intValue]];
        }else if ([dict[@"type"] isEqualToString:@"sp"]) {
            rowModel.headImageUrlPath = dict[@"cover"];
            rowModel.videoPath = dict[@"video_url"];
            rowModel.title = dict[@"title"];
            rowModel.intro = @"<暂无婚礼描述>";
            rowModel.price = @"";
        }else {
            rowModel.headImageUrlPath = dict[@"cover"];
            rowModel.title = dict[@"name"];
            rowModel.intro = dict[@"synopsis"];
            rowModel.price = @"";
        }
        rowModel.browse = [NSString stringWithFormat:@"%d",[dict[@"clicked"] intValue]];
        //type值  ->  al:案例   sp:视频   tc:图册
        rowModel.showPlayView = [dict[@"type"] isEqualToString:@"sp"] ? YES : NO;
        rowModel.cellHeight = 225.0;
        [arrayM addObject:rowModel];
    }
    return arrayM;
}

#pragma mark - 评价
+ (NSMutableArray *)rowCommentModelDataWithDataSource:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        rowModel.headImageUrlPath = dict[@"head"];
        rowModel.title = dict[@"name"];
        rowModel.time = dict[@"created_at"];
        rowModel.grades = [NSString stringWithFormat:@"%d",[dict[@"order_score"] intValue]];
        rowModel.content = dict[@"content"];
        rowModel.reply = dict[@"replay_content"];
        //图片集
        rowModel.imageUrlsArray = [NSArray new];
        NSArray *picturesArray = dict[@"pictures"];
        if ([picturesArray isKindOfClass:[NSArray class]]) {
            if (picturesArray.count) {
                rowModel.imageUrlsArray = picturesArray;
            }
        }
        //计算行高
        rowModel.contentHeight = [rowModel.content boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
        rowModel.replyHeight = [rowModel.reply boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 50.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
        rowModel.contentHeight = rowModel.contentHeight > 20.0 ? rowModel.contentHeight : 20.0;
        CGFloat replyHeight = rowModel.replyHeight;
        if (rowModel.reply.length) {
            replyHeight = replyHeight > 20.0 ? replyHeight + 30.0 : 50.0;
        }else {
            replyHeight = 0;
        }
        NSInteger count = ceil(rowModel.imageUrlsArray.count / 3.0);
        CGFloat imagesHeight = count * 110.0 + (count - 1) * 10.0;
        //头部55 + 间距 + 内容高度 + 间距 + 图片集高度 + 回复高度 + 间距
        CGFloat height = 55.0 + 15.0 + rowModel.contentHeight + 15.0 + imagesHeight + replyHeight + 15.0;
        rowModel.cellHeight = height;
        [arrayM addObject:rowModel];
    }
    return arrayM;
}

#pragma mark - 动态
+ (NSMutableArray *)rowDynamicModelDataWithDataSource:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        rowModel.headImageUrlPath = dict[@"head"];
        rowModel.title = dict[@"nickname"];
        NSString *time = dict[@"create_ti"];
        NSString *team = dict[@"theteam"];
        if ([team isKindOfClass:[NSString class]]) {
            if (team.length) {
                time = [NSString stringWithFormat:@"%@    %@",time,team];
            }
        }
        rowModel.time = time;
        rowModel.position = dict[@"occupation"];
        rowModel.content = dict[@"content"];
        //图片集
        NSMutableArray *imageUrlsArray = [NSMutableArray new];
        NSArray *picturesArray = dict[@"photourl"];
        if ([picturesArray isKindOfClass:[NSArray class]]) {
            if (picturesArray.count) {
                for (NSInteger value = 0; value < picturesArray.count; value++) {
                    NSDictionary *picturesDict = picturesArray[value];
                    [imageUrlsArray addObject:picturesDict[@"photourl"]];
                }
                rowModel.imageUrlsArray = imageUrlsArray;
            }
        }
        //计算行高
        rowModel.contentHeight = [rowModel.content boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
        rowModel.contentHeight = rowModel.contentHeight > 20.0 ? rowModel.contentHeight : 20.0;
        NSInteger count = ceil(rowModel.imageUrlsArray.count / 3.0);
        CGFloat imagesHeight = count * 110.0 + (count - 1) * 10.0;
        //头部55 + 间距 + 内容高度 + 间距 + 图片集高度 + 间距 + 功能条高度
        CGFloat height = 55.0 + 15.0 + rowModel.contentHeight + 15.0 + imagesHeight + 15.0 + 50.0;
        rowModel.cellHeight = height;
        [arrayM addObject:rowModel];
    }
    return arrayM;
}

#pragma mark - 档期
+ (NSMutableArray *)rowTimeModelDataWithDataSource:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]]) {
        if (array.count) {
            NSMutableArray *rowArray = [NSMutableArray new];
            for (NSInteger value = 0; value < array.count; value++) {
                ZLShopDetailsModel *rowModel = [self new];
                NSDictionary *rowDict = array[value];
                rowModel.title = rowDict[@"date"];
                rowModel.intro = rowDict[@"timeslot"];
                rowModel.cellHeight = 150.0;
                [rowArray addObject:rowModel];
            }
            return rowArray;
        }
    }
    return nil;
}

#pragma mark - 资料
+ (NSMutableArray *)rowInfoModelDataWithDataSource:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        if (dict.count) {
            NSMutableArray *rowArray = [NSMutableArray new];
            ZLShopDetailsModel *rowModel = [self new];
            NSMutableArray *arrayM = [NSMutableArray new];
            [self inputInfoWithObject:dict[@"sex"] InputArray:arrayM Key:@"性别"];
            [self inputInfoWithObject:dict[@"mobile"] InputArray:arrayM Key:@"联系电话"];
            [self inputInfoWithObject:dict[@"addr"] InputArray:arrayM Key:@"城市"];
            [self inputInfoWithObject:dict[@"age"] InputArray:arrayM Key:@"年龄"];
            [self inputInfoWithObject:dict[@"height"] InputArray:arrayM Key:@"身高"];
            [self inputInfoWithObject:dict[@"weight"] InputArray:arrayM Key:@"体重"];
            rowModel.infoArray = arrayM;
            rowModel.cellHeight = 50.0;
            [rowArray addObject:rowModel];
            return rowArray;
        }
    }
    return nil;
}

#pragma mark - 团队
+ (NSMutableArray *)rowTeamModelDataWithDataSource:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        rowModel.bgImageUrlPath = dict[@"head"];
        rowModel.title = dict[@"nickname"];
        rowModel.position = dict[@"occupation"];
        rowModel.price = [NSString stringWithFormat:@"￥%d起",[dict[@"zuidijia"] intValue]];
        rowModel.cellHeight = 150.0;
        [arrayM addObject:rowModel];
    }
    return arrayM;
}

#pragma mark - Separate
+ (void)inputInfoWithObject:(id)object InputArray:(NSMutableArray *)inputArray Key:(NSString *)key {
    if ([object isKindOfClass:[NSString class]]) {
        if (((NSString *)object).length) {
            [inputArray addObject:@{key:object}];
        }
    }else {
        if ([object isKindOfClass:[NSNumber class]]) {
            object = [NSString stringWithFormat:@"%@",object];
            //递归一次
            [self inputInfoWithObject:object InputArray:inputArray Key:key];
        }
    }
}

#pragma mark - Separate
+ (NSString *)changeUrlString:(NSString *)urlString {
    urlString=[urlString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *URLString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    return URLString;
}

@end
