//
//  ZLShopDetailsArcBgView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLShopDetailsArcBgView : UIImageView

//头像路径
@property (nonatomic,strong) NSString *iconPath;
//标题（名称）
@property (nonatomic,strong) NSString *title;
//荣誉
@property (nonatomic,strong) NSArray *honorsArray;
//职位（归属）
@property (nonatomic,strong) NSString *position;
//等级
@property (nonatomic,strong) NSArray *gradesArray;
//列表展示项（浏览、成交、好评等）
@property (nonatomic,strong) NSArray *listArray;

@end
