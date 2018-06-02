//
//  ZLIntegralShopHomeTableHeaderBanner.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/21.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralShopHomeTableHeaderBanner : UIView

///图片数据源
@property (nonatomic,strong) NSArray *imageUrlsArray;
///单元点击
@property (nonatomic,copy) void (^unitsClick)(NSInteger index);

/**无线轮播页
 
 @param frame 当前对象的尺寸大小
 @param pagingFrame 内容分页的尺寸大小
 @param space 间距
 */
+ (instancetype)integralShopHomeTableHeaderBannerWithFrame:(CGRect)frame
                                               PagingFrame:(CGRect)pagingFrame
                                                     Space:(CGFloat)space;

///释放定时器
- (void)removeTimer;
///重新启动
- (void)startTimer;
///暂停
- (void)stopTimer;

@end
