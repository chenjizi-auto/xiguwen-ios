//
//  ZLIntegralGoodsDetailLookImageView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/30.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralGoodsDetailLookImageView : UIView

///快要退出时
@property (nonatomic,copy) void (^willDismiss)(void);

///展示图片
- (void)showImagesWithFrame:(CGRect)frame Image:(UIImage *)image ImageUrls:(NSArray *)imageUrls CurrentIndex:(NSInteger)index;

@end
