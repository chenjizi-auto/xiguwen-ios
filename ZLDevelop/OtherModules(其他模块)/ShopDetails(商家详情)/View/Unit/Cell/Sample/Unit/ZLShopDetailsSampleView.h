//
//  ZLShopDetailsSampleView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLShopDetailsSampleView : UIView

//图片地址
@property (nonatomic,strong) NSString *imagePath;
//标题
@property (nonatomic,strong) NSString *title;
//简介
@property (nonatomic,strong) NSString *intro;
//价格
@property (nonatomic,strong) NSString *price;
//浏览
@property (nonatomic,strong) NSString *browse;
//点击
@property (nonatomic,copy) void (^click)();

@end
