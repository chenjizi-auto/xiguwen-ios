//
//  ZLShopDetailsHeaderView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLShopDetailsDynamicSuspendBar;
@interface ZLShopDetailsHeaderView : UIView

/*------------------------------input--------------------------------输入*/
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
//地址文本
@property (nonatomic,strong) NSString *address;
//电话号码
@property (nonatomic,strong) NSString *phoneNumber;
//单元按钮的标题
@property (nonatomic,strong) NSArray <NSString *>*titlesArray;


/*------------------------------output--------------------------------输出*/
//item的点击（需要写在titlesArray赋值前才能主动调用一次）
@property (nonatomic,copy) void (^itemsClick)(NSInteger index);


///功能条动态悬浮（注：滑动时高频调用）
- (void)functionBarDynamicSuspend;
///图片变焦（缩放）
- (void)imageZoomWithOffsetY:(CGFloat)offsetY;

@end
