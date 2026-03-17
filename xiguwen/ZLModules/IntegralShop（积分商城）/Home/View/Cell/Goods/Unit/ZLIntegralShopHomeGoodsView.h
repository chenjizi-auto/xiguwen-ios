//
//  ZLIntegralShopHomeGoodsView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralShopHomeGoodsView : UIView

//图片地址
@property (nonatomic,strong) NSString *imagePath;
//标题
@property (nonatomic,strong) NSString *title;
//价格
@property (nonatomic,strong) NSString *price;

//点击
@property (nonatomic,copy) void (^click)(void);

@end
