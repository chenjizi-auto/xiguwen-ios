//
//  UIImage+Helper.h
//  BoYi
//
//  Created by Niklaus on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetImageUrlBlock)(BOOL isSuccess,NSString *urlStr);// 请求是否成功回调

@interface UIImage (Helper)


/**
 获取图片地址

 @param image 图片类型
 @param complete 是否回调
 */
+ (void)urlWithBase64Image:(UIImage *)image complete:(GetImageUrlBlock)complete;


/**
 获取视频地址

 @return 回调
 */
#pragma mark - 将视频地址转为URL
+ (void)urlWithNSURL:(NSURL *)url complete:(GetImageUrlBlock)complete;

@end
