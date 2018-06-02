//
//  ZLConversionDetailModel.h
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

///兑换类型
typedef NS_ENUM (NSInteger , ZLConversionType){
    ///商品兑换
    ZLConversionTypeGoods = 1,
    ///红包兑换
    ZLConversionTypeRedPacket ,
};

@interface ZLConversionDetailModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///服务器数据页码
@property (nonatomic,unsafe_unretained) NSInteger page;
///服务器数据单页个数
@property (nonatomic,unsafe_unretained) NSInteger count;
///加载更多（YES：加载更多  NO：下拉刷新）
@property (nonatomic,unsafe_unretained) BOOL more;
///展示无更多
@property (nonatomic,unsafe_unretained) BOOL showNoMore;


///兑换类型
@property (nonatomic,unsafe_unretained) ZLConversionType conversionType;
///商品模型
@property (nonatomic,strong) NSArray <ZLConversionDetailModel *>*goodsModelsArray;
///红包模型
@property (nonatomic,strong) NSArray <ZLConversionDetailModel *>*redPacketModelsArray;
///商品模型
@property (nonatomic,strong) ZLConversionDetailModel *goodsModel;
///红包模型
@property (nonatomic,strong) ZLConversionDetailModel *redPacketModel;


///下文主键
@property (nonatomic,strong) NSString *keyId;
///标题
@property (nonatomic,strong) NSString *title;
///标题高度(仅商品标题使用该属性)
@property (nonatomic,unsafe_unretained) CGFloat titleHeight;
///时间
@property (nonatomic,strong) NSString *time;
///积分
@property (nonatomic,strong) NSString *integral;
///状态
@property (nonatomic,strong) NSString *state;
///状态颜色
@property (nonatomic,strong) UIColor *stateColor;
///图片地址
@property (nonatomic,strong) NSString *imageUrl;



///兑换详情
+ (void)conversionDetailWithInfoModel:(ZLConversionDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
