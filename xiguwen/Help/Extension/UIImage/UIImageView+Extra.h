//
//  UIImageView+Extra.h
//  XinxunIOS
//
//  Created by sunny on 14-10-29.
//  Copyright (c) 2014年 zy168. All rights reserved.
//
typedef void(^ClickBlock)(void);
#import <UIKit/UIKit.h>

@interface UIImageView (Extra)
/**
 * 设置视图为圆形
 */
-(void)setRadius;

/**
 * 请求网络图片的URL
 */

-(void)loadImageURL:(NSString *)url;

/**
 *  @brief  截屏
 *
 *  @return image
 */
- (UIImage *)captureScreen;

- (void)sd_setImageWithActivityAndURL:(NSString *)url PlaceHolder:(UIImage *)image;
- (void)sd_setImageWithActivityAndURLStringForProduct:(NSString *)url;

- (void)sd_setImageWithActivityAndURLString:(NSString *)url width:(CGFloat)width height:(CGFloat)height;
- (void)sd_setImageWithActivityAndURLString:(NSString *)url percent:(NSInteger)percent;
//加载完成回调
- (void)sd_setImageWithActivityAndURLString:(NSString *)url complete:(void(^)())loadImageFilish;
- (void)sd_setImageWithActivityAndURLStringForProduct:(NSString *)url complete:(void(^)())loadImageFilish;



//头像
- (void)sd_setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image;
//其他图片才这么处理
- (void)sd_setImageWithUrl:(NSString *)url;

- (void)addTap_click:(ClickBlock)block;
//
@property (nonatomic, copy) ClickBlock block;
@end
