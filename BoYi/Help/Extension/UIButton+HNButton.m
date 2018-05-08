//
//  UIButton+HNButton.m
//  sanwenguoxue
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 jianghaonan. All rights reserved.
//

#import "UIButton+HNButton.h"

@implementation UIButton (HNButton)
- (void)verticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil] context:nil].size;
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

- (void)rightImageAndLeftTitle:(CGFloat)spacing {

    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.width, 0, self.imageView.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.width, 0, -self.titleLabel.width)];
}

@end
