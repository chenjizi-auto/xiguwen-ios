//
//  ZLShopDetailsModel.h
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

///模块方案
typedef NS_ENUM (NSInteger , ZLShopDetailsModuleStrategyState){
    ///首页
    ZLShopDetailsModuleStrategyStateHome = 0,
    ///报价
    ZLShopDetailsModuleStrategyStatePrice ,
    ///作品
    ZLShopDetailsModuleStrategyStateSample ,
    ///评价
    ZLShopDetailsModuleStrategyStateComment ,
    ///动态
    ZLShopDetailsModuleStrategyStateDynamic ,
    ///档期
    ZLShopDetailsModuleStrategyStateTime ,
    ///资料
    ZLShopDetailsModuleStrategyStateInfo ,
};

///单元格方案
typedef NS_ENUM (NSInteger , ZLShopDetailsCellStrategyState){
    ///报价
    ZLShopDetailsCellStrategyStatePrice = 0,
    ///作品
    ZLShopDetailsCellStrategyStateSample ,
    ///评价
    ZLShopDetailsCellStrategyStateComment ,
    ///动态
    ZLShopDetailsCellStrategyStateDynamic ,
    ///档期
    ZLShopDetailsCellStrategyStateTime ,
    ///资料
    ZLShopDetailsCellStrategyStateInfo ,
    ///团队
    ZLShopDetailsCellStrategyStateTeam
};

@interface ZLShopDetailsModel : NSObject

///是否已经给header赋值（避免重复/多次赋值）
@property (nonatomic,unsafe_unretained,getter=isDidGiveHeaderValues) BOOL didGiveHeaderValues;


///导航栏标题
@property (nonatomic,strong) NSString *navTitle;
///背景图片地址
@property (nonatomic,strong) NSString *bgImageUrlPath;
///荣誉（内含图标名称）
@property (nonatomic,strong) NSArray <NSString *>*honorsArray;
///等级（内含图标名称）
@property (nonatomic,strong) NSArray <NSString *>*gradesArray;
///列表展示项（浏览、成交、好评等）
@property (nonatomic,strong) NSArray <NSString *>*listArray;
///地址文本
@property (nonatomic,strong) NSString *address;
///电话号码
@property (nonatomic,strong) NSString *phoneNumber;
///单元按钮的标题
@property (nonatomic,strong) NSArray <NSString *>*titlesArray;
///区头方案值（子模型复用）
@property (nonatomic,unsafe_unretained) ZLShopDetailsModuleStrategyState moduleStrategy;

///单元格模型数据
@property (nonatomic,strong) NSMutableArray <NSMutableArray *>*cellModelsArrayM;


///子模型容器值（子模型复用）
@property (nonatomic,strong) NSMutableArray *subModelsArrayM;
///头像值（子模型复用）
@property (nonatomic,strong) NSString *headImageUrlPath;
///标题值（子模型复用）
@property (nonatomic,strong) NSString *title;
///职位（子模型复用）
@property (nonatomic,strong) NSString *position;
///价格值（子模型复用）
@property (nonatomic,strong) NSString *price;
///数量值（子模型复用）
@property (nonatomic,strong) NSString *number;
///简介值（子模型复用）
@property (nonatomic,strong) NSString *intro;
///浏览值（子模型复用）
@property (nonatomic,strong) NSString *browse;
///浏览值（子模型复用）
@property (nonatomic,unsafe_unretained,getter=isShowPlayView) BOOL showPlayView;
///时间值（子模型复用）
@property (nonatomic,strong) NSString *time;
///等级、分数值（子模型复用）
@property (nonatomic,strong) NSString *grades;
///内容值（子模型复用）
@property (nonatomic,strong) NSString *content;
///内容高度值（子模型复用）
@property (nonatomic,unsafe_unretained) CGFloat contentHeight;
///图片容器（内含图片地址，子模型复用）
@property (nonatomic,strong) NSArray <NSString *>*imageUrlsArray;
///回复值（子模型复用）
@property (nonatomic,strong) NSString *reply;
///回复高度值（子模型复用）
@property (nonatomic,unsafe_unretained) CGFloat replyHeight;
///时间段值（子模型复用）
@property (nonatomic,strong) NSString *timeSection;
///视频地址值（子模型复用）
@property (nonatomic,strong) NSString *videoPath;
///资料键值对容器值（子模型复用）
@property (nonatomic,strong) NSArray <NSDictionary *>*infoArray;


///区头标题值（子模型复用）
@property (nonatomic,strong) NSString *sectionHeaderTitle;
///区尾标题值（子模型复用）
@property (nonatomic,strong) NSString *sectionFooterTitle;
///区头高度值（子模型复用）
@property (nonatomic,unsafe_unretained) CGFloat sectionHeaderHeight;
///区尾高度值（子模型复用）
@property (nonatomic,unsafe_unretained) CGFloat sectionFooterHeight;
///单元格方案值（子模型复用）
@property (nonatomic,unsafe_unretained) ZLShopDetailsCellStrategyState cellStrategy;
///单元格个数值（子模型复用）
@property (nonatomic,unsafe_unretained) NSInteger cellCount;
///单元格高度值（子模型复用）
@property (nonatomic,unsafe_unretained) CGFloat cellHeight;

///加载静态数据
+ (instancetype)loadStaticDataWithShopId:(NSNumber *)shopId;

///请求数据
+ (void)requestShopDetailsWithModel:(ZLShopDetailsModel *)model Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
