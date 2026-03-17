//
//  ZLRedPacketGoodsDetailModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/29.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

///单元格样式
typedef NS_ENUM (NSInteger , ZLRedPacketGoodsDetailCellType){
    ///基本详情
    ZLRedPacketGoodsDetailCellTypeBasicDetail = 1,
    ///猜你喜欢
    ZLRedPacketGoodsDetailCellTypeGuessYouLike ,
};

@interface ZLRedPacketGoodsDetailModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;

///下文主键
@property (nonatomic,strong) NSString *keyId;
///标题
@property (nonatomic,strong) NSString *title;
///标题高度
@property (nonatomic,unsafe_unretained) CGFloat titleHeight;
///单元格高度
@property (nonatomic,unsafe_unretained) CGFloat cellHeight;
///单元格样式
@property (nonatomic,unsafe_unretained) ZLRedPacketGoodsDetailCellType cellType;
///积分
@property (nonatomic,strong) NSString *integral;
///数量
@property (nonatomic,strong) NSString *number;
///图片地址
@property (nonatomic,strong) NSString *imageUrl;
///单元模型
@property (nonatomic,strong) NSArray <ZLRedPacketGoodsDetailModel *>*unitModels;

///支付密码
@property (nonatomic,strong) NSString *password;

///红包商品详情
+ (void)redPacketGoodsDetailWithInfoModel:(ZLRedPacketGoodsDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

///红包商品兑换
+ (void)redPacketGoodsConversionWithInfoModel:(ZLRedPacketGoodsDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

@end
