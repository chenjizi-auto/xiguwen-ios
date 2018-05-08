//
//  commonTool.m
//  ThreeAsk_New
//
//  Created by apple on 2017/6/29.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import "commonTool.h"

@implementation commonTool

/**
 *  获取缩放比
 */
+ (CGFloat)getScale {
    
    return [UIScreen mainScreen].bounds.size.width / 320.0;
}
CGFloat Scale() {
    
    return [UIScreen mainScreen].bounds.size.width / 320.0;
}


/**
 *  获取缩放比之后的字体
 */
+ (UIFont *)getScaleFont:(CGFloat)fontFloat {
    
    return [UIFont systemFontOfSize:fontFloat * [self getScale]];
}

UIFont *ScaleFont(CGFloat fontFloat) {
    
    return [UIFont systemFontOfSize:fontFloat * Scale()];
}


/**
 *  获取缩放之后的数值
 */
CGFloat ScaleFloat(CGFloat oldFloat) {
    
    return oldFloat * Scale();
}
+ (CGFloat)getScaleFloat:(CGFloat)oldFloat {
    
    return oldFloat * [self getScale];
}

/**
 *  根据文字和字体获取size
 */
CGSize SizeWithString(NSString *string, UIFont *font) {
    
    if (!font || !string.length) return CGSizeZero;
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil].size;
    
    return size;
}

CGSize SizeWithStringAndMaxSize(NSString *string, UIFont *font, CGSize MaxSize) {
    
    if (!font || !string.length) return CGSizeZero;
    
    CGSize size = [string boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil].size;
    
    return size;
}

+ (CGSize)getSizeWithString:(NSString *)string andFont:(UIFont *)font {
    
    if (!font || !string.length) return CGSizeZero;
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil].size;
    
    return size;
}


/**
 *  获取颜色图片
 */
UIImage* ImageWithColor(UIColor *color, CGSize size) {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


NSMutableAttributedString* HNAttributedString(NSString *baseString, NSString *subString, NSString *AttributeName, id value) {
    
    NSMutableAttributedString *attributedString= [[NSMutableAttributedString alloc]initWithString:baseString];
    NSRange titltRange = [baseString rangeOfString:[NSString stringWithFormat:@"%@", subString]];
    [attributedString addAttribute:AttributeName value:value range:titltRange];
    
    return attributedString;
}

@end
