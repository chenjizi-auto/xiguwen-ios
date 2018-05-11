//
//  ZLShopDetailsStrategyCell.h
//  BoYi
//
//  Created by zhaolei on 2018/5/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

///模块方案
typedef NS_ENUM (NSInteger , ZLShopDetailsModuleStrategyState){
    ///首页
    ZLShopDetailsModuleStrategyStateTeam = 0,
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

///策略模式
@interface ZLShopDetailsStrategyCell : UITableViewCell

///区数
+ (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView Strategy:(ZLShopDetailsModuleStrategyState)state;
///行数
+ (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state;
///区尾高度
+ (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state;
///区头高度
+ (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state;
///区尾
+ (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state SectionFooters:(NSMutableArray *)sectionFooters;
///区头
+ (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section Strategy:(ZLShopDetailsModuleStrategyState)state SectionHeaders:(NSMutableArray *)sectionHeaders;
///单元格高度
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath Strategy:(ZLShopDetailsModuleStrategyState)state;
///单元格对象对象
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Strategy:(ZLShopDetailsCellStrategyState)state;

@end
