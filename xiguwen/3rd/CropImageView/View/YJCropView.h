//
//  YJCropView.h
//  Base
//
//  Created by junzong on 2016/9/22.
//  Copyright © 2016年 bodecn. All rights reserved.
//


/**
 *  View剪切页面（也可以进入控制器剪切页面，两个页面都一样）
 *
 */

#import <UIKit/UIKit.h>

typedef void(^CropImageBlock)(UIImage *image);

@interface YJCropView : UIView

@property (nonatomic, copy) CropImageBlock cropImageBlock;


/**
 *  图片剪切
 *
 *  @param frame          剪切视图frame
 *  @param originalImage  原图片
 *  @param imageType      图片格式（暂支持png、jpg）
 *  @param cropSize       剪切框大小
 *  @param cropImageBlock 剪切后的图片回调
 *
 *  @return 初始化
 */
- (instancetype)initWithFrame:(CGRect)frame originalImage:(UIImage *)originalImage imageType:(NSString *)imageType cropSize:(CGSize)cropSize cropImageBlock:(CropImageBlock)cropImageBlock;

@end
