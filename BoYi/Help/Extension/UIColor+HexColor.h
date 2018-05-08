//
//  UIColor+HexColor.h
//
//  Created by ChangweiZhang on 15/3/30.
//  Copyright (c) 2015 ChangweiZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)
//将16进制颜色字符串转成UIColor
+(UIColor *) getColorFromHex:(NSString*)hexString;
+ (UIColor *)colorWithHex:(NSString *)string;
@end
