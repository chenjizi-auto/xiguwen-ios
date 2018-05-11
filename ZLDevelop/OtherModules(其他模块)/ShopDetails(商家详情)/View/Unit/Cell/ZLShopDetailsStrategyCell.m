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

CGFloat const ZLShopDetailsViewSectionHeight = 50.0;

#pragma mark - Public
+ (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView Strategy:(ZLShopDetailsModuleStrategyState)state {
    return 3;
}
+ (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state {
    return 2;
}
+ (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state {
    return ZLShopDetailsViewSectionHeight;
}
+ (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state {
    return ZLShopDetailsViewSectionHeight + 5.0;
}
+ (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state SectionFooters:(NSMutableArray *)sectionFooters {
    ZLShopDetailsAreaFooterView * shopDetailsAreaFooterView = nil;
    if (state < sectionFooters.count) {
        sectionFooters = sectionFooters[state];
    }
    if (section < sectionFooters.count) {
        shopDetailsAreaFooterView = sectionFooters[section];
    }
    if (!shopDetailsAreaFooterView) {
        shopDetailsAreaFooterView = [[ZLShopDetailsAreaFooterView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, ZLShopDetailsViewSectionHeight)];
        [sectionFooters addObject:shopDetailsAreaFooterView];
        shopDetailsAreaFooterView.sectionFootersClick = ^{//区尾的点击
            NSLog(@"------clickSection:%ld-------",section);
        };
    }
    shopDetailsAreaFooterView.title = @"更多报价 >";
    return shopDetailsAreaFooterView;
}
+ (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state SectionHeaders:(NSMutableArray *)sectionHeaders {
    ZLShopDetailsAreaHeaderView * shopDetailsAreaHeaderView = nil;
    if (state < sectionHeaders.count) {
        sectionHeaders = sectionHeaders[state];
    }
    if (section < sectionHeaders.count) {
        shopDetailsAreaHeaderView = sectionHeaders[section];
    }
    if (!shopDetailsAreaHeaderView) {
        shopDetailsAreaHeaderView = [[ZLShopDetailsAreaHeaderView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, ZLShopDetailsViewSectionHeight)];
        [sectionHeaders addObject:shopDetailsAreaHeaderView];
    }
    shopDetailsAreaHeaderView.title = @"区头（22222）";
    return shopDetailsAreaHeaderView;
}
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath Strategy:(ZLShopDetailsModuleStrategyState)state {
    NSArray *strategyHeights = @[@"185.0",//首页
                                 @"185.0",//报价
                                 @"215.0",//作品
                                 @"370.0",//评价
                                 @"370.0",//动态
                                 @"50.0",//档期
                                 @"50.0"];//资料
    return [strategyHeights[state] floatValue];
}
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Strategy:(ZLShopDetailsCellStrategyState)state {
    NSArray *classNames = @[@"ZLShopDetailsPriceCell",
                            @"ZLShopDetailsSampleCell",
                            @"ZLShopDetailsCommentCell",
                            @"ZLShopDetailsDynamicCell",
                            @"ZLShopDetailsTimeCell",
                            @"ZLShopDetailsInfoCell",
                            @"ZLShopDetailsTeamCell"];
    return [NSClassFromString(classNames[state]) reuseCellWithTableView:tableView IndexPath:indexPath Strategy:state];
}

#pragma mark - Separate


@end
