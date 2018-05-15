//
//  ZLShopDetailsAreaFooterView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLShopDetailsAreaFooterView : UIView

//标题
@property (nonatomic,strong) NSString *title;
//标题颜色
@property (nonatomic,strong) UIColor *titleColor;
//标题背景颜色
@property (nonatomic,strong) UIColor *titleBackgroundColor;
//区尾的点击
@property (nonatomic,copy) void (^sectionFootersClick)();

@end
