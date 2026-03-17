//
//  IB_DESIGN_Button.m
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "IB_DESIGN_Button.h"
IB_DESIGNABLE
@implementation IB_DESIGN_Button

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
- (void)setType:(NSString *)type {
    _type = type;
}
- (void)setDelay:(CGFloat)delay {
    _delay = delay;
}
- (void)setDuration:(CGFloat)duration {
    _duration = duration;
}


//-(void)awakeFromNib {
//    [super awakeFromNib];
//    if (self.type && self.duration) {
//        [self startCanvasAnimation];
//    }
//}
//- (void)startCanvasAnimation {
//
//    Class <CSAnimation> class = [CSAnimation classForAnimationType:self.type];
//
//    [class performAnimationOnView:self duration:self.duration delay:self.delay];
//
//    [super startCanvasAnimation];
//}

@end
