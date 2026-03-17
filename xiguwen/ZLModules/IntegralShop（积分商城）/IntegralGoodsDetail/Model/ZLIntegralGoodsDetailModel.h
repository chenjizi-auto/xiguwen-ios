//
//  ZLIntegralGoodsDetailModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/28.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

///单元格样式
typedef NS_ENUM (NSInteger , ZLIntegralGoodsDetailCellType){
    ///基本详情
    ZLIntegralGoodsDetailCellTypeBasicDetail = 1,
    ///图文详情
    ZLIntegralGoodsDetailCellTypeImageTextDetail ,
    ///猜你喜欢
    ZLIntegralGoodsDetailCellTypeGuessYouLike ,
};

@interface ZLIntegralGoodsDetailModel : NSObject

///下文主键
@property (nonatomic,strong) NSString *keyId;
///标题
@property (nonatomic,strong) NSString *title;
///标题高度
@property (nonatomic,unsafe_unretained) CGFloat titleHeight;
///单元格高度
@property (nonatomic,unsafe_unretained) CGFloat cellHeight;
///单元格样式
@property (nonatomic,unsafe_unretained) ZLIntegralGoodsDetailCellType cellType;
///积分
@property (nonatomic,strong) NSString *integral;
///库存量
@property (nonatomic,unsafe_unretained) NSInteger inventory;
///数量
@property (nonatomic,strong) NSString *number;
///图片地址
@property (nonatomic,strong) NSString *imageUrl;
///图片组数据
@property (nonatomic,strong) NSArray *urlsArray;
///单元模型
@property (nonatomic,strong) NSArray <ZLIntegralGoodsDetailModel *>*unitModels;

///积分商品详情
+ (void)integralGoodsDetailWithInfoModel:(ZLIntegralGoodsDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
