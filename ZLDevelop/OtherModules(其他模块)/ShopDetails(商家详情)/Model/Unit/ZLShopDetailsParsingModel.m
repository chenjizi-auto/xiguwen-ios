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

#pragma mark - 分发解析（入口）
+ (void)modelDataWithResponseObject:(NSDictionary *)responseObject Model:(ZLShopDetailsModel *)model {
    //解析商家资料
    if (!model.isDidGiveHeaderValues) {
        [self shopInfoWithResponseObject:responseObject Model:model];
    }
    //解析首页模块数据
    if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateHome) {
        [self homeModelDataWithResponseObject:responseObject Model:model];
        return;
    }
    //解析档期、资料模块数据
    if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateTime ||
        model.moduleStrategy == ZLShopDetailsModuleStrategyStateInfo) {
        [self timeAndInfoModelDataWithResponseObject:responseObject Model:model];
        return;
    }
    //其他模块
    [self otherModuleArrayWithResponseObject:responseObject Model:model];
}

#pragma mark - 区头解析
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
    model.honorsArray = [self certificationInfoWithDict:userDict];
    
    //星级
    model.gradesArray = [self gradesInfoWithDict:userDict];
    
    //列表展示项
    model.listArray = [self listInfoWithDict:userDict];
}

#pragma mark - 首页
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

#pragma mark - 档期、资料
+ (void)timeAndInfoModelDataWithResponseObject:(NSDictionary *)responseObject Model:(ZLShopDetailsModel *)model {
    //当前模块容器
    NSMutableArray *modelArrayM = [NSMutableArray new];
    
    //解析区头
    model.moduleStrategy == ZLShopDetailsModuleStrategyStateTime
    ? [self sectionTimeModelDataWithDataSource:responseObject[@"data"] InputArrayM:modelArrayM]
    : [self sectionInfoModelDataWithDataSource:responseObject[@"data"] InputArrayM:modelArrayM];
 
    //替换模块数据
    model.cellModelsArrayM[model.moduleStrategy] = modelArrayM;
}

#pragma mark - 报价、作品、评价、动态
+ (void)otherModuleArrayWithResponseObject:(NSDictionary *)responseObject Model:(ZLShopDetailsModel *)model {
    //当前模块容器
    NSMutableArray *modelArrayM = [NSMutableArray new];
    
    //配置静态值
    NSArray *cellStrategys = @[@"0",@"1",@"2",@"3"];
    NSArray *headerHeights = @[@"30.0",@"30.0",@"30.0",@"30.0"];
    NSArray *footerHeights = @[@"50.0",@"50.0",@"50.0",@"50.0"];
    NSArray *array = @[];
    if (!(model.moduleStrategy - 1)) {//报价
        array = responseObject[@"data"][@"baojia"];
    }else if (model.moduleStrategy - 1 == 3) {//动态
        array = responseObject[@"data"][@"dongtai"];
    }
    NSArray *dataSource = @[array,
                            responseObject[@"data"],//作品
                            responseObject[@"data"],//评价
                            array];
    
    //赋值
    [self sectionModelDataWithFooterTitle:@"-------- 没有更多内容 --------" CellStrategy:[cellStrategys[model.moduleStrategy - 1] integerValue] HeaderHeight:[headerHeights[model.moduleStrategy - 1] floatValue] FooterHeight:[footerHeights[model.moduleStrategy - 1] floatValue] DataSource:dataSource[model.moduleStrategy - 1] HeaderTitle:@"全部报价" InputArray:modelArrayM];
    
    //替换模块数据
    model.cellModelsArrayM[model.moduleStrategy] = modelArrayM;
}

#pragma mark - Separate
+ (NSMutableArray *)certificationInfoWithDict:(NSDictionary *)dict {
    NSMutableArray *honorsArray = [NSMutableArray new];
    [self certificationStateWithObject:dict[@"shiming"] InputArrayM:honorsArray inputValue:@"实名认证1"];//实名认证
    [self certificationStateWithObject:dict[@"platform"] InputArrayM:honorsArray inputValue:@"平台认证1"];//平台认证
    [self certificationStateWithObject:dict[@"sincerity"] InputArrayM:honorsArray inputValue:@"诚信认证1"];//诚信认证
    //6初级 7中级 8高级 9总监 10大师 11皇冠 12金冠 13一星 14二星 15三星 16四星 17五星 18六星 19七星
    BOOL team = [dict[@"team2"] boolValue];//学院认证
    if (team) {
        NSInteger teamIndex = [dict[@"xueyuan"] integerValue];
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
    return honorsArray;
}
+ (void)certificationStateWithObject:(id)object InputArrayM:(NSMutableArray *)inputArray inputValue:(NSString *)value {
    BOOL shiming = [object boolValue];
    if (shiming) {
        [inputArray addObject:value];
    }
}
+ (NSMutableArray *)gradesInfoWithDict:(NSDictionary *)dict {
    NSString *values = dict[@"xinyu"][@"a"];
    NSInteger number = [dict[@"xinyu"][@"b"] integerValue];
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
        return gradesArray;
    }
    return nil;
}
+ (NSMutableArray *)listInfoWithDict:(NSDictionary *)dict {
    NSMutableArray *listArray = [NSMutableArray new];
    NSString *pv = [NSString stringWithFormat:@"浏览  %d",[dict[@"pv"] intValue]];//浏览
    NSString *num = [NSString stringWithFormat:@"成交  %d",[dict[@"num"] intValue]];//成交
    NSString *score = [NSString stringWithFormat:@"好评  %d",[dict[@"score"] intValue]];//好评
    NSString *fans = [NSString stringWithFormat:@"粉丝  %d",[dict[@"fans"] intValue]];//粉丝
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
    return listArray;
}
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
                subModelsArrayM = [ZLShopDetailsParsingUnitModel rowDynamicModelDataWithDataSource:array];
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
+ (void)sectionTimeModelDataWithDataSource:(NSArray *)array InputArrayM:(NSMutableArray *)inputArrayM {
    if ([array isKindOfClass:[NSArray class]]) {
        if (array.count) {
            for (NSInteger index = 0; index < array.count; index++) {
                ZLShopDetailsModel *sectionModel = [self new];
                NSDictionary *dict = array[index];
                sectionModel.sectionHeaderTitle = dict[@"dateye"];
                sectionModel.sectionFooterTitle = nil;
                sectionModel.cellStrategy = ZLShopDetailsCellStrategyStateTime;
                sectionModel.sectionHeaderHeight = 50.0;
                sectionModel.sectionFooterHeight = 10.0;
                NSArray *dangqiArray = dict[@"dateye"];
                sectionModel.subModelsArrayM = [ZLShopDetailsParsingUnitModel rowTimeModelDataWithDataSource:dangqiArray];
                sectionModel.cellCount = sectionModel.subModelsArrayM.count;
                [inputArrayM addObject:sectionModel];
            }
        }
    }
}
+ (void)sectionInfoModelDataWithDataSource:(NSDictionary *)dict InputArrayM:(NSMutableArray *)inputArrayM {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        if (dict.count) {
            ZLShopDetailsModel *sectionModel = [self new];
            sectionModel.sectionHeaderTitle = nil;
            sectionModel.sectionFooterTitle = nil;
            sectionModel.cellStrategy = ZLShopDetailsCellStrategyStateInfo;
            sectionModel.sectionHeaderHeight = 0;
            sectionModel.sectionFooterHeight = 0;
            sectionModel.subModelsArrayM = [ZLShopDetailsParsingUnitModel rowInfoModelDataWithDataSource:dict];
            sectionModel.cellCount = ((ZLShopDetailsParsingUnitModel *)[sectionModel.subModelsArrayM firstObject]).infoArray.count;
            [inputArrayM addObject:sectionModel];
        }
    }
}

@end
