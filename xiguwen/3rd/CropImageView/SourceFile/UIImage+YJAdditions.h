//
//  UIImage+YJAdditions.h
//  Base
//
//  Created by junzong on 2016/9/22.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJAdditions)

/*垂直翻转*/
- (UIImage *)flipVertical;

/*水平翻转*/
- (UIImage *)flipHorizontal;

/*改变size*/
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;

/*裁切*/
- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

@end
