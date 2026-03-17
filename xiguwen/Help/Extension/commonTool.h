//
//  commonTool.h
//  ThreeAsk_New
//
//  Created by apple on 2017/6/29.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface commonTool : NSObject

/**
 *  获取缩放比
 */
+ (CGFloat)getScale;
/**
 *  获取缩放比
 */
CGFloat Scale();

/**
 *  获取缩放比之后的字体
 */
+ (UIFont *)getScaleFont:(CGFloat)fontFloat;
/**
 *  获取缩放比之后的字体
 */
UIFont *ScaleFont(CGFloat fontFloat);

/**
 *  获取缩放之后的数值
 */
+ (CGFloat)getScaleFloat:(CGFloat)oldFloat;
/**
 *  获取缩放之后的数值
 */
CGFloat ScaleFloat(CGFloat oldFloat);


/**
 *  根据文字和字体获取size
 */
+ (CGSize)getSizeWithString:(NSString *)string andFont:(UIFont *)font;
/**
 *  根据文字和字体获取size
 */
CGSize SizeWithString(NSString *string, UIFont *font);

/**
 *  根据文字和字体和最大尺寸获取size
 */
CGSize SizeWithStringAndMaxSize(NSString *string, UIFont *font, CGSize MaxSize);

/**
 *  获取颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  获取颜色图片
 */
UIImage* ImageWithColor(UIColor *color, CGSize size);


/**
 *  获取NSMutableAttributedString
 */
NSMutableAttributedString* AttributedString(NSString *baseString, NSString *subString, NSString *AttributeName, id value);

@end
