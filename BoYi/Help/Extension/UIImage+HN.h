//
//  UIImage+HN.h
//  HaonanWeibo
//
//  Created by 蒋昊南 on 15/7/14.
//  Copyright (c) 2015年 蒋昊南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HN)

+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
