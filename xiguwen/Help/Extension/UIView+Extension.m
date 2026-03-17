//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setBrokenCircleWithCornerRadius:(CGFloat)cornerRadius lineColor:(UIColor *)color lineDashPattern:(NSArray<NSNumber *> *)lineDashPattern lineWidth:(CGFloat)lineWidth{

    CAShapeLayer *border = [CAShapeLayer layer];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect frame = self.bounds;
    
    //drawing a border around a view
    CGPathMoveToPoint(path, NULL, 0, frame.size.height - cornerRadius);
    CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
    CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, -M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width - cornerRadius, 0);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, cornerRadius, cornerRadius, -M_PI_2, 0, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height - cornerRadius);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, cornerRadius, frame.size.height);
    CGPathAddArc(path, NULL, cornerRadius, frame.size.height - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);
    
    //path is set as the _shapeLayer object's path
    border.path = path;
    CGPathRelease(path);
    
    border.masksToBounds = NO;
    
    border.strokeColor = color.CGColor;
    
    border.backgroundColor = [[UIColor clearColor] CGColor];
    
    border.fillColor = [[UIColor clearColor] CGColor];
    
    border.frame = self.bounds;
    
    border.lineWidth = lineWidth ? lineWidth : 0.5;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = lineDashPattern;
    
    [border setValue:[NSNumber numberWithBool:NO] forKey:@"isCircle"];
    
    border.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:border];
}

@end
