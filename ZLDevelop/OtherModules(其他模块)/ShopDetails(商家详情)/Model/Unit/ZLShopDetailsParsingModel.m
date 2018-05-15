//
//  ZLShopDetailsParsingModel.m
//  BoYi
//
//  Created by zhaolei on 2018/5/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsParsingModel.h"
#import "ZLShopDetailsParsingUnitModel.h"

@implementation ZLShopDetailsParsingModel

///分发解析
+ (void)modelDataWithResponseObject:(NSDictionary *)responseObject Model:(ZLShopDetailsModel *)model {
    //解析商家资料
    if (!model.isDidGiveHeaderValues) {
        [self shopInfoWithResponseObject:responseObject Model:model];
    }
    //解析模块数据
    if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateHome) {
        //首页
        [self homeModelDataWithResponseObject:responseObject Model:model];
        return;
    }
    //其他模块
    [self otherModuleArrayWithResponseObject:responseObject Model:model];
}

+ (void)shopInfoWithResponseObject:(NSDictionary *)responseObject Model:(ZLShopDetailsModel *)model {
    model.didGiveHeaderValues = YES;
    
    NSDictionary *dataDict = responseObject[@"data"];
    
    NSDictionary *userinfoDict = dataDict[@"userinfo"];
    model.bgImageUrlPath = userinfoDict[@"background"];
    model.address = userinfoDict[@"dizhi"];
    
    NSDictionary *userDict = dataDict[@"user"];
    model.headImageUrlPath = userDict[@"head"];
    model.title = userDict[@"nickname"];
    model.position = userDict[@"association"];
    model.phoneNumber = userDict[@"mobile"];
    
    //认证情况
    NSMutableArray *honorsArray = [NSMutableArray new];
    BOOL shiming = [userDict[@"shiming"] boolValue];//实名认证
    if (shiming) {
        [honorsArray addObject:@"实名认证1"];
    }
    BOOL platform = [userDict[@"platform"] boolValue];//平台认证
    if (platform) {
        [honorsArray addObject:@"平台认证1"];
    }
    BOOL sincerity = [userDict[@"sincerity"] boolValue];//诚信认证
    if (sincerity) {
        [honorsArray addObject:@"诚信认证1"];
    }
    BOOL team = [userDict[@"team2"] boolValue];//学院认证   6初级 7中级 8高级 9总监 10大师 11皇冠 12金冠 13一星 14二星 15三星 16四星 17五星 18六星 19七星
    if (team) {
        NSInteger teamIndex = [userDict[@"xueyuan"] integerValue];
        NSDictionary *teamImageNames = @{@"6":@"认证1",
                                         @"7":@"认证2",
                                         @"8":@"认证3",
                                         @"9":@"认证4",
                                         @"10":@"认证5",
                                         @"11":@"认证6",
                                         @"12":@"认证7",
                                         @"13":@"1星",
                                         @"14":@"2星",
                                         @"15":@"3星",
                                         @"16":@"4星",
                                         @"17":@"5星",
                                         @"18":@"6星",
                                         @"19":@"7星"};
        [honorsArray addObject:teamImageNames[[NSString stringWithFormat:@"%ld",teamIndex]]];
    }
    model.honorsArray = honorsArray;
    
    //星级
    NSString *values = userDict[@"xinyu"][@"a"];
    NSInteger number = [userDict[@"xinyu"][@"b"] integerValue];
    if ([values isKindOfClass:[NSString class]]) {
        NSDictionary *gradesNames = @{@"q":@"旗子",
                                      @"x":@"星",
                                      @"z":@"钻石",
                                      @"h":@"皇冠",
                                      @"j":@"至尊"};
        NSMutableArray *gradesArray = [NSMutableArray new];
        for (NSInteger index = 0; index < number; index++) {
            [gradesArray addObject:gradesNames[values]];
        }
        model.gradesArray = gradesArray;
    }
    
    //列表展示项
    NSMutableArray *listArray = [NSMutableArray new];
    NSString *pv = [NSString stringWithFormat:@"浏览  %d",[userDict[@"pv"] intValue]];//浏览
    NSString *num = [NSString stringWithFormat:@"成交  %d",[userDict[@"num"] intValue]];//成交
    NSString *score = [NSString stringWithFormat:@"好评  %d",[userDict[@"score"] intValue]];//好评
    NSString *fans = [NSString stringWithFormat:@"粉丝  %d",[userDict[@"fans"] intValue]];//粉丝
    if (pv >= 0) {
        [listArray addObject:pv];
    }
    if (num >= 0) {
        [listArray addObject:num];
    }
    if (score >= 0) {
        [listArray addObject:score];
    }
    if (fans >= 0) {
        [listArray addObject:fans];
    }
    model.listArray = listArray;
}
///首页[混合模块]
+ (void)homeModelDataWithResponseObject:(NSDictionary *)responseObject Model:(ZLShopDetailsModel *)model {
    //当前模块容器
    NSMutableArray *modelArrayM = [NSMutableArray new];
    NSDictionary *dataDict = responseObject[@"data"];
    //报价
    [self sectionModelDataWithFooterTitle:@"更多报价 >" CellStrategy:ZLShopDetailsCellStrategyStatePrice HeaderHeight:50.0 FooterHeight:50.0 DataSource:dataDict[@"baojia"][@"baojia"] HeaderTitle:@"作品报价" InputArray:modelArrayM];
    //作品
    [self sectionModelDataWithFooterTitle:@"更多案例 >" CellStrategy:ZLShopDetailsCellStrategyStateSample HeaderHeight:50.0 FooterHeight:50.0 DataSource:dataDict[@"zuoping"][@"zuopin"] HeaderTitle:@"商品案例" InputArray:modelArrayM];
    //评价
    [self sectionModelDataWithFooterTitle:@"更多评价 >" CellStrategy:ZLShopDetailsCellStrategyStateComment HeaderHeight:50.0 FooterHeight:50.0 DataSource:dataDict[@"pinglun"] HeaderTitle:@"商品报价" InputArray:modelArrayM];
    //推荐团队
    [self sectionModelDataWithFooterTitle:@"-------- 没有更多内容 --------" CellStrategy:ZLShopDetailsCellStrategyStateTeam HeaderHeight:50.0 FooterHeight:50.0 DataSource:dataDict[@"tuijiantd"] HeaderTitle:@"推荐团队" InputArray:modelArrayM];
    //替换模块数据
    model.cellModelsArrayM[model.moduleStrategy] = modelArrayM;
}
///其他[单独模块](报价、作品、评价)
+ (void)otherModuleArrayWithResponseObject:(NSDictionary *)responseObject Model:(ZLShopDetailsModel *)model {
    //当前模块容器
    NSMutableArray *modelArrayM = [NSMutableArray new];
    
    NSArray *cellStrategys = @[@"0",@"1",@"2"];
    NSArray *headerHeights = @[@"30.0",@"30.0",@"30.0"];
    NSArray *footerHeights = @[@"50.0",@"50.0",@"50.0"];
    NSArray *dataSource = @[responseObject[@"data"][@"baojia"],
                            responseObject[@"data"],
                            responseObject[@"data"]];
    
    //赋值
    [self sectionModelDataWithFooterTitle:@"-------- 没有更多内容 --------" CellStrategy:[cellStrategys[model.moduleStrategy - 1] integerValue] HeaderHeight:[headerHeights[model.moduleStrategy - 1] floatValue] FooterHeight:[footerHeights[model.moduleStrategy - 1] floatValue] DataSource:dataSource[model.moduleStrategy - 1] HeaderTitle:@"全部报价" InputArray:modelArrayM];
    //替换模块数据
    model.cellModelsArrayM[model.moduleStrategy] = modelArrayM;
}

#pragma mark - Reuse
///报价区模型解析
+ (void)sectionModelDataWithFooterTitle:(NSString *)footerTitle CellStrategy:(ZLShopDetailsCellStrategyState)cellStrategy HeaderHeight:(CGFloat)headerHeight FooterHeight:(CGFloat)footerHeight DataSource:(NSArray *)array HeaderTitle:(NSString *)headerTitle InputArray:(NSMutableArray *)inputArray {
    ZLShopDetailsModel *baojiaModel = [self new];
    baojiaModel.sectionFooterTitle = footerTitle;
    baojiaModel.cellStrategy = cellStrategy;
    baojiaModel.sectionHeaderHeight = headerHeight;
    baojiaModel.sectionFooterHeight = footerHeight;
    if ([array isKindOfClass:[NSArray class]]) {
        if (array.count) {
            NSMutableArray *subModelsArrayM = nil;
            if (cellStrategy == ZLShopDetailsCellStrategyStatePrice) {
                //报价
                subModelsArrayM = [ZLShopDetailsParsingUnitModel rowPriceModelDataWithDataSource:array];
            }else if (cellStrategy == ZLShopDetailsCellStrategyStateSample) {
                //作品
                subModelsArrayM = [ZLShopDetailsParsingUnitModel rowSampleModelDataWithDataSource:array];
            }else if (cellStrategy == ZLShopDetailsCellStrategyStateComment) {
                //评价
                subModelsArrayM = [ZLShopDetailsParsingUnitModel rowCommentModelDataWithDataSource:array];
            }else if (cellStrategy == ZLShopDetailsCellStrategyStateDynamic) {
                //动态
            }else if (cellStrategy == ZLShopDetailsCellStrategyStateTime) {
                //档期
            }else if (cellStrategy == ZLShopDetailsCellStrategyStateInfo) {
                //资料
            }else {
                //团队
                subModelsArrayM = [ZLShopDetailsParsingUnitModel rowTeamModelDataWithDataSource:array];
            }
            baojiaModel.subModelsArrayM = subModelsArrayM;
        }
    }
    baojiaModel.cellCount = baojiaModel.subModelsArrayM.count;
    baojiaModel.sectionHeaderTitle = [NSString stringWithFormat:@"%@（%ld）",headerTitle,baojiaModel.cellCount];
    if (baojiaModel.subModelsArrayM) {
        [inputArray addObject:baojiaModel];
    }
}


@end
