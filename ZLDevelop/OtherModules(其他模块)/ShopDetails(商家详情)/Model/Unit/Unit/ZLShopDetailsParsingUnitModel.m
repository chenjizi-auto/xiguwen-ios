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
    NSMutableArray *baojiaArrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        rowModel.headImageUrlPath = dict[@"imglist"];
        rowModel.title = dict[@"name"];
        rowModel.price = [NSString stringWithFormat:@"￥%d起",[dict[@"price"] intValue]];
        rowModel.number = [NSString stringWithFormat:@"已售 %d",[dict[@"num"] intValue]];
        rowModel.cellHeight = 185.0;
        [baojiaArrayM addObject:rowModel];
    }
    return baojiaArrayM;
}

#pragma mark - 作品
+ (NSMutableArray *)rowSampleModelDataWithDataSource:(NSArray *)array {
    NSMutableArray *zuopinArrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        if ([dict[@"type"] isEqualToString:@"al"]) {
            rowModel.headImageUrlPath = dict[@"weddingcover"];
            rowModel.title = dict[@"title"];
            rowModel.position = dict[@"weddingdescribe"];
            rowModel.price = [NSString stringWithFormat:@"￥%d",[dict[@"weddingexpenses"] intValue]];
        }else if ([dict[@"type"] isEqualToString:@"sp"]) {
            rowModel.headImageUrlPath = dict[@"cover"];
            rowModel.videoPath = dict[@"video_url"];
            rowModel.title = dict[@"title"];
            rowModel.position = @"<暂无婚礼描述>";
            rowModel.price = @"";
        }else {
            rowModel.headImageUrlPath = dict[@"cover"];
            rowModel.title = dict[@"name"];
            rowModel.position = dict[@"synopsis"];
            rowModel.price = @"";
        }
        rowModel.browse = [NSString stringWithFormat:@"%d",[dict[@"clicked"] intValue]];
        //type值  ->  al:案例   sp:视频   tc:图册
        rowModel.showPlayView = [dict[@"type"] isEqualToString:@"sp"] ? YES : NO;
        rowModel.cellHeight = 220.0;
        [zuopinArrayM addObject:rowModel];
    }
    return zuopinArrayM;
}

#pragma mark - 评价
+ (NSMutableArray *)rowCommentModelDataWithDataSource:(NSArray *)array {
    NSMutableArray *pinglunArrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        rowModel.bgImageUrlPath = dict[@"head"];
        rowModel.title = dict[@"name"];
        rowModel.time = dict[@"created_at"];
        rowModel.grades = [NSString stringWithFormat:@"%d分",[dict[@"order_score"] intValue]];
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
        [pinglunArrayM addObject:rowModel];
    }
    return pinglunArrayM;
}

#pragma mark - 团队
+ (NSMutableArray *)rowTeamModelDataWithDataSource:(NSArray *)array {
    NSMutableArray *tuijiantdArrayM = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        ZLShopDetailsModel *rowModel = [self new];
        NSDictionary *dict = array[index];
        rowModel.bgImageUrlPath = dict[@"head"];
        rowModel.title = dict[@"nickname"];
        rowModel.position = dict[@"occupation"];
        rowModel.price = [NSString stringWithFormat:@"￥%d起",[dict[@"zuidijia"] intValue]];
        rowModel.cellHeight = 150.0;
        [tuijiantdArrayM addObject:rowModel];
    }
    return tuijiantdArrayM;
}

@end
