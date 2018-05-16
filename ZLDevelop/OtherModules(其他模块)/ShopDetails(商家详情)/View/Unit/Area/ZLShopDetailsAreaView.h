//
//  ZLShopDetailsAreaView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/16.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLShopDetailsModel.h"

@interface ZLShopDetailsAreaView : UIView

//标题
@property (nonatomic,strong) NSString *title;
//颜色
@property (nonatomic,strong) UIColor *titleColor;
///字号
@property (nonatomic,unsafe_unretained) CGFloat font;
///分割线高度
@property (nonatomic,unsafe_unretained) CGFloat lineHeight;
///高度
@property (nonatomic,unsafe_unretained) CGFloat titleHeight;
//背景颜色
@property (nonatomic,strong) UIColor *titleBackgroundColor;
//区尾的点击
@property (nonatomic,copy) void (^sectionFootersClick)();

///区数
+ (NSInteger)numberOfSectionsInModel:(ZLShopDetailsModel *)model;
///区尾高度
+ (CGFloat)heightForFooterInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model;
///区头高度
+ (CGFloat)heightForHeaderInSection:(NSInteger)section Model:(ZLShopDetailsModel *)model;
///区尾
+ (UIView *)viewForFooterInSection:(NSInteger)section SectionFooters:(NSMutableArray *)sectionFooters Model:(ZLShopDetailsModel *)model;
///区头
+ (UIView *)viewForHeaderInSection:(NSInteger)section SectionHeaders:(NSMutableArray *)sectionHeaders Model:(ZLShopDetailsModel *)model;

@end
