//
//  ZLShopDetailsStrategyCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsStrategyCell.h"
#import "ZLShopDetailsPriceCell.h"
#import "ZLShopDetailsSampleCell.h"
#import "ZLShopDetailsCommentCell.h"
#import "ZLShopDetailsDynamicCell.h"
#import "ZLShopDetailsTimeCell.h"
#import "ZLShopDetailsInfoCell.h"
#import "ZLShopDetailsTeamCell.h"
#import "ZLShopDetailsAreaHeaderView.h"
#import "ZLShopDetailsAreaFooterView.h"

@implementation ZLShopDetailsStrategyCell

#pragma mark - Public
+ (NSInteger)numberOfSectionsInModel:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    return modelsArray.count;
}
+ (NSInteger)numberOfRowsInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.subModelsArrayM.count;
}
+ (CGFloat)heightForFooterInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.sectionFooterHeight;
}
+ (CGFloat)heightForHeaderInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.sectionHeaderHeight;
}
+ (UIView *)viewForFooterInSection:(NSInteger)section SectionFooters:(NSMutableArray *)sectionFooters Model:(ZLShopDetailsModel *)model {
    ZLShopDetailsAreaFooterView * shopDetailsAreaFooterView = [self loadFooterViewInSection:section SectionFooters:sectionFooters Model:model];
    if (shopDetailsAreaFooterView) {
        shopDetailsAreaFooterView.title = @"更多报价 >";
    }
    return shopDetailsAreaFooterView;
}
+ (UIView *)viewForHeaderInSection:(NSInteger)section SectionHeaders:(NSMutableArray *)sectionHeaders Model:(ZLShopDetailsModel *)model {
    ZLShopDetailsAreaHeaderView * shopDetailsAreaHeaderView = [self loadHeaderViewInSection:section SectionHeaders:sectionHeaders Model:model];
    if (shopDetailsAreaHeaderView) {
        //赋值
    }
    return shopDetailsAreaHeaderView;
}
+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[indexPath.section];
    ZLShopDetailsModel *rowModel = sectionModel.subModelsArrayM[indexPath.row];
    return rowModel.cellHeight;
}
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model {
    NSArray *classNames = @[@"ZLShopDetailsPriceCell",
                            @"ZLShopDetailsSampleCell",
                            @"ZLShopDetailsCommentCell",
                            @"ZLShopDetailsDynamicCell",
                            @"ZLShopDetailsTimeCell",
                            @"ZLShopDetailsInfoCell",
                            @"ZLShopDetailsTeamCell"];
    return [NSClassFromString(classNames[model.moduleStrategy]) reuseCellWithTableView:tableView IndexPath:indexPath Model:model];
}

#pragma mark - Separate
+ (ZLShopDetailsAreaHeaderView *)loadHeaderViewInSection:(NSInteger)section SectionHeaders:(NSMutableArray *)sectionHeaders Model:(ZLShopDetailsModel *)model {
    ZLShopDetailsAreaHeaderView * shopDetailsAreaHeaderView = nil;
    if (model.moduleStrategy < sectionHeaders.count) {
        sectionHeaders = sectionHeaders[model.moduleStrategy];
    }
    if (section < sectionHeaders.count) {
        shopDetailsAreaHeaderView = sectionHeaders[section];
    }
    if (!shopDetailsAreaHeaderView) {
        shopDetailsAreaHeaderView = [[ZLShopDetailsAreaHeaderView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        [sectionHeaders addObject:shopDetailsAreaHeaderView];
    }
    shopDetailsAreaHeaderView.title = @"区头（22222）";
    return shopDetailsAreaHeaderView;
}
+ (ZLShopDetailsAreaFooterView *)loadFooterViewInSection:(NSInteger)section SectionFooters:(NSMutableArray *)sectionFooters Model:(ZLShopDetailsModel *)model {
    ZLShopDetailsAreaFooterView * shopDetailsAreaFooterView = nil;
    if (model.moduleStrategy < sectionFooters.count) {
        sectionFooters = sectionFooters[model.moduleStrategy];
    }
    if (section < sectionFooters.count) {
        shopDetailsAreaFooterView = sectionFooters[section];
    }
    if (!shopDetailsAreaFooterView) {
        shopDetailsAreaFooterView = [[ZLShopDetailsAreaFooterView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        [sectionFooters addObject:shopDetailsAreaFooterView];
        shopDetailsAreaFooterView.sectionFootersClick = ^{//区尾的点击
            NSLog(@"------clickSection:%ld-------",section);
        };
    }
    return shopDetailsAreaFooterView;
}

@end
