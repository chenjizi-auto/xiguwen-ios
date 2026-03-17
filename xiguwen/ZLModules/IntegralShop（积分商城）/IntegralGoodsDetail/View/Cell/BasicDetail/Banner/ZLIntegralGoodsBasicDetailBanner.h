//
//  ZLIntegralGoodsBasicDetailBanner.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/30.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralGoodsBasicDetailBanner : UIView

///图片地址
@property (nonatomic,strong) NSArray *imageUrlsArray;
///点击图片
@property (nonatomic,copy) void (^clickItem)(UIImageView *imageView, NSInteger index);

@end
