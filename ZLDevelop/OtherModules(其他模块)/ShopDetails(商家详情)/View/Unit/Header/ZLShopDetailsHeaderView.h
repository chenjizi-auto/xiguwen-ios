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

//动态悬浮条
@property (nonatomic,strong) ZLShopDetailsDynamicSuspendBar *dynamicSuspendBar;

///功能条动态悬浮（注：滑动时高频调用）
- (void)functionBarDynamicSuspend;
///图片变焦（缩放）
- (void)imageZoomWithOffsetY:(CGFloat)offsetY;

@end
