//
//  ZLIntegralShopHomeModel.h
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

///商品类型
typedef NS_ENUM (NSInteger , ZLIntegralShopHomeGoodsType){
    ///积分
    ZLIntegralShopHomeGoodsTypeGoods = 1,
    ///红包
    ZLIntegralShopHomeGoodsTypeRedPacket ,
};
///轮播类型
typedef NS_ENUM (NSInteger , ZLIntegralShopHomeBannerType){
    ///婚庆商家
    ZLIntegralShopHomeBannerTypeWeddingBossPage = 1,
    ///商城商家
    ZLIntegralShopHomeBannerTypeShopBossPage = 2,
    ///案例
    ZLIntegralShopHomeBannerTypeExample = 3,
    ///商品
    ZLIntegralShopHomeBannerTypeGoods = 5,
    ///报价
    ZLIntegralShopHomeBannerTypePrice = 6,
};

@interface ZLIntegralShopHomeModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;

///下文主键
@property (nonatomic,strong) NSString *keyId;
///不间断的签到天数
@property (nonatomic,strong) NSString *ongoingSignDayNumber;
///签到状态
@property (nonatomic,unsafe_unretained,getter=isDidSign) BOOL signState;
///当前总积分
@property (nonatomic,strong) NSString *currentTotalIntegral;
///兑换记录总数
@property (nonatomic,strong) NSString *currentConversionTotalNumber;
///今日获得积分数
@property (nonatomic,strong) NSString *todayObtainIntegralNumber;
///轮播地址
@property (nonatomic,strong) NSArray *bannerUrlsArray;
///轮播对象
@property (nonatomic,strong) NSArray *bannerModelsArray;
///h5地址
@property (nonatomic,strong) NSString *bannerSrc;
///轮播类型（除去h5加载外，可根据轮播类型进行跳转，需要传给子界面主键id）
@property (nonatomic,unsafe_unretained) ZLIntegralShopHomeBannerType bannerType;
///单元模型
@property (nonatomic,strong) NSArray <ZLIntegralShopHomeModel *>*unitModels;
///区头标题
@property (nonatomic,strong) NSString *sectionTitle;
///不间断签到积分值
@property (nonatomic,strong) NSArray <NSString *>*ongoingSignIntegralsArray;
///商品名称
@property (nonatomic,strong) NSString *goodsName;
///商品价格
@property (nonatomic,strong) NSString *goodsPrice;
///商品图片
@property (nonatomic,strong) NSString *goodsUrl;
///商品类型
@property (nonatomic,unsafe_unretained) ZLIntegralShopHomeGoodsType goodsType;


///签到
+ (void)signWithResults:(void (^)(ZLSessionManagerErrorState sessionErrorState, ZLIntegralShopHomeModel *signModel))complete;

///积分商城首页数据
+ (void)integralShopHomeWithInfoModel:(ZLIntegralShopHomeModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
