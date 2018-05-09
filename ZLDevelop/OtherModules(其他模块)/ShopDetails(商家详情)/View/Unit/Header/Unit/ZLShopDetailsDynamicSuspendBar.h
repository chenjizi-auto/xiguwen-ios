//
//  ZLShopDetailsDynamicSuspendBar.h
//  BoYi
//
//  Created by zhaolei on 2018/5/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

///动态悬浮按钮
@interface ZLShopDetailsDynamicSuspendBar : UIView

//单元按钮的标题
@property (nonatomic,strong) NSArray <NSString *>*titlesArray;
//item的点击（需要写在titlesArray赋值前才能主动调用一次）
@property (nonatomic,copy) void (^itemsClick)(NSInteger index);

@end
