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
///区数
+ (NSInteger)numberOfSectionsInModel:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    return modelsArray.count;
}
///单元格个数
+ (NSInteger)numberOfRowsInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.subModelsArrayM.count;
}
///区尾高度
+ (CGFloat)heightForFooterInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.sectionFooterHeight;
}
///区头高度
+ (CGFloat)heightForHeaderInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.sectionHeaderHeight;
}
///创建、复用、赋值区尾
+ (UIView *)viewForFooterInSection:(NSInteger)section SectionFooters:(NSMutableArray *)sectionFooters Model:(ZLShopDetailsModel *)model {
    //创建
    ZLShopDetailsAreaFooterView * shopDetailsAreaFooterView = [self loadFooterViewInSection:section SectionFooters:sectionFooters Model:model];
    if (shopDetailsAreaFooterView) {
        //赋值操作
        [self giveValueForFooterInSection:section SectionFooters:sectionFooters Model:model FooterView:shopDetailsAreaFooterView];
    }
    return shopDetailsAreaFooterView;
}
///创建、复用、赋值区头
+ (UIView *)viewForHeaderInSection:(NSInteger)section SectionHeaders:(NSMutableArray *)sectionHeaders Model:(ZLShopDetailsModel *)model {
    //创建
    ZLShopDetailsAreaHeaderView * shopDetailsAreaHeaderView = [self loadHeaderViewInSection:section SectionHeaders:sectionHeaders Model:model];
    if (shopDetailsAreaHeaderView) {
        //赋值操作
        [self giveValueForHeaderInSection:section SectionHeaders:sectionHeaders Model:model HeaderView:shopDetailsAreaHeaderView];
    }
    return shopDetailsAreaHeaderView;
}
///单元格高度
+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[indexPath.section];
    ZLShopDetailsModel *rowModel = sectionModel.subModelsArrayM[indexPath.row];
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
    ZLShopDetailsModel *rowModel = sectionModel.subModelsArrayM[indexPath.row];
    return [NSClassFromString(classNames[sectionModel.cellStrategy]) reuseCellWithTableView:tableView IndexPath:indexPath Model:rowModel];
}

#pragma mark - Separate
///创建/加载区头
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
    return shopDetailsAreaHeaderView;
}
///创建/加载区尾
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
///区头赋值
+ (void)giveValueForHeaderInSection:(NSInteger)section SectionHeaders:(NSMutableArray *)sectionHeaders Model:(ZLShopDetailsModel *)model HeaderView:(ZLShopDetailsAreaHeaderView *)shopDetailsAreaHeaderView {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    shopDetailsAreaHeaderView.title = sectionModel.sectionHeaderTitle;
    shopDetailsAreaHeaderView.titleHeight = sectionModel.sectionHeaderHeight;
    if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateHome ||//首页
        model.moduleStrategy == ZLShopDetailsModuleStrategyStateTime) {//档期
        shopDetailsAreaHeaderView.titleBackgroundColor = UIColor.whiteColor;
        shopDetailsAreaHeaderView.titleColor = UIColor.blackColor;
        shopDetailsAreaHeaderView.font = 16.0;
    }else if (model.moduleStrategy == ZLShopDetailsModuleStrategyStatePrice ||//报价
              model.moduleStrategy == ZLShopDetailsModuleStrategyStateSample ||//作品
              model.moduleStrategy == ZLShopDetailsModuleStrategyStateComment ||//评价
              model.moduleStrategy == ZLShopDetailsModuleStrategyStateDynamic) {//动态
        shopDetailsAreaHeaderView.titleBackgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        shopDetailsAreaHeaderView.titleColor = UIColor.lightGrayColor;
        shopDetailsAreaHeaderView.font = 13.0;
    }else {//资料
        
    }
}
///区尾赋值
+ (void)giveValueForFooterInSection:(NSInteger)section SectionFooters:(NSMutableArray *)sectionFooters Model:(ZLShopDetailsModel *)model FooterView:(ZLShopDetailsAreaFooterView *)shopDetailsAreaFooterView {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    shopDetailsAreaFooterView.title = sectionModel.sectionFooterTitle;
    switch (model.moduleStrategy) {
        case ZLShopDetailsModuleStrategyStateHome:{//首页
            
            break;
        }
        case ZLShopDetailsModuleStrategyStatePrice:{//报价
            
            break;
        }
        case ZLShopDetailsModuleStrategyStateSample:{//作品
            
            break;
        }
        case ZLShopDetailsModuleStrategyStateComment:{//评价
            
            break;
        }
        case ZLShopDetailsModuleStrategyStateDynamic:{//动态
            
            break;
        }
        case ZLShopDetailsModuleStrategyStateTime:{//档期
            
            break;
        }
        default:{//资料
            
            break;
        }
    }
}

@end
