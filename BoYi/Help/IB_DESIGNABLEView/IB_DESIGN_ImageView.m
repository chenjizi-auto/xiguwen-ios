//
//  IB_DESIGN_ImageView.m
//  Base
//
//  Created by bodecn on 16/3/23.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "IB_DESIGN_ImageView.h"

IB_DESIGNABLE

@implementation IB_DESIGN_ImageView

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor{
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}

@end
