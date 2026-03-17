//
//  UIImage+Extend.h
//  CDHN
//
//  Created by muxi on 14-10-14.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImage+GIF.h>
@interface UIImage (Extend)





/**
 *  拉伸图片:自定义比例
 */
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;


+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;


/**
 *  拉伸图片
 */
+(UIImage *)resizeWithImageName:(NSString *)name;


/**
 *  按指定大小压缩图片
 */
+ (UIImage *)compressImage:(UIImage *)imgSrc size:(CGSize)size;

//指定宽度按比例缩放
- (UIImage *)imageCompressWithTargetWidth:(CGFloat)defineWidth;

/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param failBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock;
- (UIImage *)addlogoImage:(UIImage *)resizedImage;


@end
