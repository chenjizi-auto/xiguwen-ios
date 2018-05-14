//
//  ZLShopDetailsStrategyCell.h
//  BoYi
//
//  Created by zhaolei on 2018/5/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLShopDetailsModel.h"

///策略模式
@interface ZLShopDetailsStrategyCell : UITableViewCell

///区数
+ (NSInteger)numberOfSectionsInModel:(ZLShopDetailsModel *)model;
///行数
+ (NSInteger)numberOfRowsInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model;
///区尾高度
+ (CGFloat)heightForFooterInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model;
///区头高度
+ (CGFloat)heightForHeaderInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model;
///区尾
+ (UIView *)viewForFooterInSection:(NSInteger)section SectionFooters:(NSMutableArray *)sectionFooters Model:(ZLShopDetailsModel *)model;
///区头
+ (UIView *)viewForHeaderInSection:(NSInteger)section SectionHeaders:(NSMutableArray *)sectionHeaders Model:(ZLShopDetailsModel *)model;
///单元格高度
+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model;
///单元格对象对象
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model;

@end
