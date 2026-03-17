//
//  UIButton+HNButton.h
//  sanwenguoxue
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 jianghaonan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HNButton)
/**
 *  垂直居中
 *
 *  @param spacing image与title的间隙
 */
- (void)verticalImageAndTitle:(CGFloat)spacing;


- (void)rightImageAndLeftTitle:(CGFloat)spacing;
@end
