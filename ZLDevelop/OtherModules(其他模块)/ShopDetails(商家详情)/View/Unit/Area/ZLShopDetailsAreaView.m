//
//  ZLShopDetailsAreaView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/16.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsAreaView.h"
#import "ZLShopDetailsAreaHeaderView.h"
#import "ZLShopDetailsAreaFooterView.h"

@implementation ZLShopDetailsAreaView

#pragma mark - 区数
+ (NSInteger)numberOfSectionsInModel:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    return modelsArray.count;
}

#pragma mark - 区尾高度
+ (CGFloat)heightForFooterInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.sectionFooterHeight;
}

#pragma mark - 区头高度
+ (CGFloat)heightForHeaderInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    return sectionModel.sectionHeaderHeight;
}

#pragma mark - 区尾
+ (UIView *)viewForFooterInSection:(NSInteger)section SectionFooters:(NSMutableArray *)sectionFooters Model:(ZLShopDetailsModel *)model {
    //创建
    ZLShopDetailsAreaFooterView * shopDetailsAreaFooterView = [self loadFooterViewInSection:section SectionFooters:sectionFooters Model:model];
    if (shopDetailsAreaFooterView) {
        //赋值操作
        [self giveValueForFooterInSection:section SectionFooters:sectionFooters Model:model FooterView:shopDetailsAreaFooterView];
    }
    return shopDetailsAreaFooterView;
}

#pragma mark - 区头
+ (UIView *)viewForHeaderInSection:(NSInteger)section SectionHeaders:(NSMutableArray *)sectionHeaders Model:(ZLShopDetailsModel *)model {
    //创建
    ZLShopDetailsAreaHeaderView * shopDetailsAreaHeaderView = [self loadHeaderViewInSection:section SectionHeaders:sectionHeaders Model:model];
    if (shopDetailsAreaHeaderView) {
        //赋值操作
        [self giveValueForHeaderInSection:section SectionHeaders:sectionHeaders Model:model HeaderView:shopDetailsAreaHeaderView];
    }
    return shopDetailsAreaHeaderView;
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
+ (void)giveValueForHeaderInSection:(NSInteger)section SectionHeaders:(NSMutableArray *)sectionHeaders Model:(ZLShopDetailsModel *)model HeaderView:(ZLShopDetailsAreaHeaderView *)shopDetailsAreaHeaderView {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    shopDetailsAreaHeaderView.title = sectionModel.sectionHeaderTitle;
    shopDetailsAreaHeaderView.titleHeight = sectionModel.sectionHeaderHeight;
    if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateHome ||//首页
        model.moduleStrategy == ZLShopDetailsModuleStrategyStateTime) {//档期
        shopDetailsAreaHeaderView.titleBackgroundColor = UIColor.whiteColor;
        shopDetailsAreaHeaderView.titleColor = (model.moduleStrategy == ZLShopDetailsModuleStrategyStateHome)
        ? UIColor.blackColor
        : [UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0];
        shopDetailsAreaHeaderView.font = 16.0;
    }else if (model.moduleStrategy == ZLShopDetailsModuleStrategyStatePrice ||//报价
              model.moduleStrategy == ZLShopDetailsModuleStrategyStateSample ||//作品
              model.moduleStrategy == ZLShopDetailsModuleStrategyStateComment ||//评价
              model.moduleStrategy == ZLShopDetailsModuleStrategyStateDynamic) {//动态
        shopDetailsAreaHeaderView.titleBackgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        shopDetailsAreaHeaderView.titleColor = UIColor.lightGrayColor;
        shopDetailsAreaHeaderView.font = 13.0;
    }else {//资料
        shopDetailsAreaHeaderView.titleBackgroundColor = UIColor.clearColor;
        shopDetailsAreaHeaderView.titleColor = UIColor.whiteColor;
        shopDetailsAreaHeaderView.font = 0;
    }
}
+ (void)giveValueForFooterInSection:(NSInteger)section SectionFooters:(NSMutableArray *)sectionFooters Model:(ZLShopDetailsModel *)model FooterView:(ZLShopDetailsAreaFooterView *)shopDetailsAreaFooterView {
    NSArray *modelsArray = model.cellModelsArrayM[model.moduleStrategy];
    ZLShopDetailsModel *sectionModel = modelsArray[section];
    shopDetailsAreaFooterView.title = sectionModel.sectionFooterTitle;
    shopDetailsAreaFooterView.titleHeight = sectionModel.sectionFooterHeight;
    shopDetailsAreaFooterView.font = 14.0;
    if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateHome ||//首页
        model.moduleStrategy == ZLShopDetailsModuleStrategyStatePrice ||//报价
        model.moduleStrategy == ZLShopDetailsModuleStrategyStateSample ||//作品
        model.moduleStrategy == ZLShopDetailsModuleStrategyStateComment ||//评价
        model.moduleStrategy == ZLShopDetailsModuleStrategyStateDynamic) {//动态
        //推荐团队
        if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateHome
            && (sectionModel.cellStrategy == ZLShopDetailsCellStrategyStatePrice
                || sectionModel.cellStrategy == ZLShopDetailsCellStrategyStateSample
                || sectionModel.cellStrategy == ZLShopDetailsCellStrategyStateComment)) {
                shopDetailsAreaFooterView.titleColor = [UIColor colorWithRed:232/255.0 green:83/255.0 blue:131/255.0 alpha:1.0];
                shopDetailsAreaFooterView.titleBackgroundColor = UIColor.whiteColor;
                shopDetailsAreaFooterView.lineHeight = 5.0;
                return;
        }else {
            shopDetailsAreaFooterView.titleColor = UIColor.lightGrayColor;
            shopDetailsAreaFooterView.titleBackgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        }
    }else if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateTime) {//档期
        shopDetailsAreaFooterView.titleColor = nil;
        shopDetailsAreaFooterView.titleBackgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        
    }else {//资料
        shopDetailsAreaFooterView.titleColor = nil;
        shopDetailsAreaFooterView.titleBackgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    }
    shopDetailsAreaFooterView.lineHeight = 0;
}

@end
