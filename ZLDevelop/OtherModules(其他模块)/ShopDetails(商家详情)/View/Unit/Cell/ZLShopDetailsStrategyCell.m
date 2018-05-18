//
//  ZLShopDetailsStrategyCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsStrategyCell.h"

@implementation ZLShopDetailsStrategyCell

#pragma mark - Public

///单元格个数
+ (NSInteger)numberOfRowsInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.cellCount;
}

///单元格高度
+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[indexPath.section];
    NSInteger index = model.moduleStrategy == ZLShopDetailsModuleStrategyStateInfo ? 0 : indexPath.row;
    ZLShopDetailsModel *rowModel = nil;
    if (sectionModel.cellStrategy == ZLShopDetailsCellStrategyStatePrice
        || sectionModel.cellStrategy == ZLShopDetailsCellStrategyStateSample
        || sectionModel.cellStrategy == ZLShopDetailsCellStrategyStateTeam) {
        NSInteger count = sectionModel.cellStrategy == ZLShopDetailsCellStrategyStateTeam ? 3 : 2;
        //只获取每行中的第一个单元模型（每行的单元模型的高度是等值的）
        rowModel = sectionModel.subModelsArrayM[index * count];
    }else {
        //逐步获取每个单元模型
        rowModel = sectionModel.subModelsArrayM[index];
    }
    return rowModel.cellHeight;
}
///复用/创建单元格
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model {
    NSArray *classNames = @[@"ZLShopDetailsPriceCell",
                            @"ZLShopDetailsSampleCell",
                            @"ZLShopDetailsCommentCell",
                            @"ZLShopDetailsDynamicCell",
                            @"ZLShopDetailsTimeCell",
                            @"ZLShopDetailsInfoCell",
                            @"ZLShopDetailsTeamCell"];
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[indexPath.section];
    NSInteger index = model.moduleStrategy == ZLShopDetailsModuleStrategyStateInfo ? 0 : indexPath.row;
    ZLShopDetailsModel *rowModel = nil;
    if (sectionModel.cellStrategy == ZLShopDetailsCellStrategyStatePrice
        || sectionModel.cellStrategy == ZLShopDetailsCellStrategyStateSample
        || sectionModel.cellStrategy == ZLShopDetailsCellStrategyStateTeam) {
        //将区域模型传入内部
        rowModel = sectionModel;
    }else {
        //将单元模型传入内部
        rowModel = sectionModel.subModelsArrayM[index];
    }
    
    return [NSClassFromString(classNames[sectionModel.cellStrategy]) reuseCellWithTableView:tableView IndexPath:indexPath Model:rowModel];
}

#pragma mark - Separate


@end
