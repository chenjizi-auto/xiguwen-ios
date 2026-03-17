//
//  UIView+Animation.m
//  CardioCycle
//
//  Created by 酷蜂ios on 15/11/26.
//  Copyright © 2015年 酷蜂ios. All rights reserved.
//

#import "UIView+Animation.h"



@implementation UIView (Animation)

- (void)showAnimationWithType:(animationType)type
{
    switch (type) {
        case animationTypeAirBallFourSide:
            [self animationfourSide];
            break;
        case animationTypeAirBallUpAndDown:
            [self animationUpAndDown];
            break;
        case animationTypeAirBallLeftToRight:
            
            break;
        case animationTypeAirBallRightToLeft:
            
            break;
         case animationTypeCircle:
            [self animationWithCircle];
            break;
        default:
            break;
    }
   
}

- (void)animationWithHeartRecoverBySmallCircle
{
    CGRect frame = self.superview.bounds;
    CGPoint center = self.center;
    CGFloat radius = frame.size.height*0.5-2;
    
    if(ScreenHeight == 568 || ScreenHeight == 480){
        radius = radius*568/667;
        UIBezierPath*path=[UIBezierPath bezierPath];
        
        [path addArcWithCenter:CGPointMake(center.x-16, center.y-16) radius:radius startAngle:M_PI_2 endAngle:-M_PI_2*3 clockwise:NO];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.path = path.CGPath;
        animation.duration = 60.0;
        [self.layer addAnimation:animation forKey:nil];

    }else if (ScreenHeight == 667 || ScreenHeight == 736){
        UIBezierPath*path=[UIBezierPath bezierPath];
        
        [path addArcWithCenter:CGPointMake(center.x, center.y) radius:radius startAngle:M_PI_2 endAngle:-M_PI_2*3 clockwise:NO];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.path = path.CGPath;
        animation.duration = 60.0;
        [self.layer addAnimation:animation forKey:nil];
        
    }

    
}


- (void)animationWithCircle
{
    CGPoint center = self.center;
    //
    CGFloat magrin = 3;
    if(ScreenHeight == 568 || ScreenHeight == 480){
        magrin = 1.5;
    }
    
    UIBezierPath*path=[UIBezierPath bezierPath];
    
     [path addArcWithCenter:center radius:magrin startAngle:0 endAngle:M_PI_2*4 clockwise:YES];
    CAKeyframeAnimation*moveAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path=path.CGPath;
    moveAnimation.duration=2;
    moveAnimation.removedOnCompletion=NO;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:moveAnimation forKey:nil];
    
    
}
- (void)animationWithCircleByRightMargin:(CGFloat)rightMargin andBottomMargin:(CGFloat)bottomMargin
{
    CGSize size = self.frame.size;
    //CGPoint center = self.center;
    CGFloat rightInset = ScreenWidth- rightMargin - size.width*0.5;
    CGFloat bottomInset = ScreenHeight - bottomMargin-size.height*0.5;
    
    //KFLog(@"center:%@",NSStringFromCGPoint(center));
    
    UIBezierPath*path=[UIBezierPath bezierPath];
    
     [path addArcWithCenter:CGPointMake(rightInset, bottomInset) radius:3 startAngle:0 endAngle:M_PI_2*4 clockwise:YES];
    
    CAKeyframeAnimation*moveAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path=path.CGPath;
    moveAnimation.duration=2;
    moveAnimation.removedOnCompletion=NO;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:moveAnimation forKey:nil];
    
}




- (void)animationfourSide
{
    CGPoint center = self.center;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    // 设置动画属性
    anim.keyPath = @"position";
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y-5)];
    
    NSValue *v2 = [NSValue valueWithCGPoint:center];
    
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y+5)];
   
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(center.x-5, center.y)];
    
    NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(center.x+5, center.y)];
    
    
    anim.values = @[v1,v2,v3,v2,v4,v2,v5,v2,v1];
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 4;
    
    [self.layer addAnimation:anim forKey:nil];
    
    
}

- (void)animationUpAndDown
{
    CGPoint center = self.center;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    // 设置动画属性
    anim.keyPath = @"position";
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y-5)];
    
    NSValue *v2 = [NSValue valueWithCGPoint:center];
    
    anim.values = @[v1,v2,v1];
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1.5;
    
    [self.layer addAnimation:anim forKey:nil];
    
 }

/**从左往右移直到左边离屏幕的距离*/
- (void)showAnimationLeftToRight:(CGFloat)leftInset BottomInset:(CGFloat)bottomInset
{
    
    CGFloat transX;
    CGFloat tramsY;
    
    CGPoint center = self.center;
    CGSize size = self.bounds.size;
    
    transX = (leftInset +size.width*0.5) - center.x ;
    tramsY = (ScreenHeight - bottomInset - size.height*0.5) - center.y;
    
    
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
//    // 设置动画属性
//    anim.keyPath = @"position";
//    
//    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)];
//    
//    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(leftInset+(size.width)/2, self.superview.bounds.size.height-(size.height)/2-bottomInset)];
//    
//    anim.values = @[v1,v2];
//    anim.fillMode = kCAFillModeForwards;
//    anim.removedOnCompletion = NO;
//    anim.duration = 1.5;
//    
//    [self.layer addAnimation:anim forKey:nil];
    
    
    
    [UIView animateWithDuration:1 animations:^{
       self.transform = CGAffineTransformMakeTranslation(transX, tramsY);
        
     }];
    
    
}

- (void)strengthViewMakeIdentity
{
    self.transform = CGAffineTransformIdentity;
    
}

- (void)exerciseViewMakeIdentity
{
    self.transform = CGAffineTransformIdentity;
    
}

-(void)showAnimationRightToLeft:(CGFloat)rightInset BottomInset:(CGFloat)bottomInset success:(void (^)())success
{
    CGFloat transX;
    CGFloat tramsY;
    CGPoint center = self.center;
    CGSize size = self.bounds.size;
    transX = (ScreenWidth - rightInset - size.width*0.5) - center.x;//得到的是负数
    tramsY = (ScreenHeight - size.height - bottomInset)-(center.y-size.height*0.5);
    
   
    [UIView animateWithDuration:1.0 animations:^{
         self.transform = CGAffineTransformMakeTranslation(transX, tramsY);
    } completion:^(BOOL finished) {
        if(success){
            success();
        }
        
    }];
    
}



/**从右往做移直到右边离屏幕的距离*/
- (void)showAnimationRightToLeft:(CGFloat)rightInset TopInset:(CGFloat)topInset
{
    CGFloat transX;
    CGFloat tramsY;
    
    CGPoint center = self.center;
    CGSize size = self.bounds.size;
    
    transX = (ScreenWidth - rightInset - size.width*0.5) - center.x;//得到的是负数
    tramsY =  topInset +size.height *0.5 -center.y;//的到的事正数
    
    
//    CGPoint center = self.center;
//    CGSize size = self.bounds.size;
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
//    // 设置动画属性
//    anim.keyPath = @"position";
//    
//    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)];
//    
//    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(self.superview.bounds.size.width-(size.width)/2-rightInset, topInset+size.height*0.5)];
//    
//    anim.values = @[v1,v2];
//    anim.fillMode = kCAFillModeForwards;
//    anim.removedOnCompletion = NO;
//    anim.duration = 1.5;
//    
//    [self.layer addAnimation:anim forKey:nil];
    
    [UIView animateWithDuration:1 animations:^{
        
        self.transform = CGAffineTransformMakeTranslation(transX, tramsY);
        
        //self.center = CGPointMake(self.superview.bounds.size.width-(size.width)/2-rightInset, topInset+size.height*0.5);
        
    }];
    
}

- (void)showAnimationFromBottom:(CGFloat)bottomInset
{
    CGPoint center = self.center;
      [UIView animateWithDuration:0.8 animations:^{
        self.center = CGPointMake(center.x, center.y- bottomInset);
     }];
    
}

- (void)showAnimationLeftToRightWithDistance:(CGFloat)distance success:(void (^)())success
{
    CGPoint center = self.center;
    
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.center = CGPointMake(center.x+distance, center.y);
    } completion:^(BOOL finished) {
        if(success){
            success();
        }
        
    }];
 }

- (void)showAnimationWithScaleAndgotoTop:(CGFloat)topInset
{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -topInset);
        if([self isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel*)self;
            label.font = [UIFont systemFontOfSize:9];
            
        }
    }];
    
}

- (void)directionFirstLeftThenGoRightFinish:(void (^)())success{
  
    [UIView animateWithDuration:0.5 animations:^{
         self.transform = CGAffineTransformMakeTranslation(-50, 0);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
           self.transform = CGAffineTransformMakeTranslation(300, 0);
        } completion:^(BOOL finished) {
            if(success){
                success();
            }
         }];
         
    }];
  }


- (void)showBack
{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
        if([self isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel *)self;
            label.font = [UIFont systemFontOfSize:15];
        }
     }];
    
}

- (void)showAnimationWithOffsetByWidthOfSelfWidthMiddle
{
    CGFloat insetMargin = self.bounds.size.width;
    CGPoint center = self.center;
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.center = CGPointMake(center.x+insetMargin*0.5, center.y);
        
    }];
    
     
}


- (void)showAnimationFromBottomWithTopInset:(CGFloat)topInset leftInset:(CGFloat)leftInset finish:(void (^)())finish
{
    CGPoint center = self.center;
    CGSize size = self.bounds.size;
    
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    // 设置动画属性
    anim.keyPath = @"position";
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)];
    
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake((size.width)/2+leftInset, topInset+size.height*0.5)];
    
    anim.values = @[v1,v2];
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.duration = 1.0;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.2];
    
    
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    scaleAnimation.duration = 0.5f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
   
    
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 2.0;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    animation.values = values;
    
    
      
    CAAnimationGroup*group=[CAAnimationGroup animation];
    group.animations=@[anim,scaleAnimation];
    group.duration = MAXFLOAT;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [self.layer addAnimation:group forKey:nil];
    if(finish){
        finish();
    }
 }

- (void)animationKeepScale:(CGFloat)scale duration:(CGFloat)duration
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    //[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, scale)]];
    //[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    animation.values = values;
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)narrowViewWithScale:(CGFloat)scale
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}


- (void)showAnimationWithRotation:(CGFloat)rotation
{
  
    CGFloat angle = 1.0*(M_PI +M_PI_4)*rotation;
    if(angle >M_PI ){
        [UIView animateWithDuration:1 animations:^{
            self.transform = CGAffineTransformRotate(self.transform, angle-M_PI_2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
            } completion:nil];
         }];
    } else if (angle < -M_PI){
        [UIView animateWithDuration:1 animations:^{
            self.transform = CGAffineTransformRotate(self.transform, angle+M_PI_2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                self.transform = CGAffineTransformRotate(self.transform, -M_PI_2);
            } completion:nil];
        }];
        
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            self.transform = CGAffineTransformRotate(self.transform, angle);
            
        } completion:nil];
    }
    

    
}

-(void)ligthHaloAnimation
{
    
    CGFloat duration = 2;
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];
    animationGroup.fillMode = kCAFillModeBackwards;
    animationGroup.duration = duration;
    animationGroup.repeatCount = HUGE;
    animationGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [[CABasicAnimation alloc]init];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.fromValue = 0;
    if(ScreenHeight == 480 ||ScreenHeight == 568){
        scaleAnimation.toValue = @3;
    }else{
        scaleAnimation.toValue = @2.5;
    }
    
    CAKeyframeAnimation *opacityAnimation = [[CAKeyframeAnimation alloc]init];
    opacityAnimation.keyPath = @"opacity";
    opacityAnimation.values = @[@1.0,@0.5,@0.1];
    opacityAnimation.keyTimes = @[@0,@0.5,@1];
    animationGroup.animations = @[scaleAnimation,opacityAnimation];
    
    [self.layer addAnimation:animationGroup forKey:nil];
    
    
}


/**运动设置界面中的两个往外消失动画*/
- (void)moveToLeftWithAnimationByFirstViewToUpAndScale
{
    //第一两个都先缩小
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //scaleAnimation.removedOnCompletion = NO;
    //scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.85];
    //scaleAnimation.duration = 0.25f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //往上移动一点距离 再往右移动一点距离 再迅速往左移动
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    // 设置动画属性
    anim.keyPath = @"position";
    CGPoint center = self.center;
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)];
    
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y-40)];
    
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(center.x-10, center.y-39)];
    
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(center.x+60, center.y-37)];
    
    NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(center.x-300, center.y-36)];
    
    
    anim.values = @[v1,v2,v3,v4,v5];
    
    CAAnimationGroup*group=[CAAnimationGroup animation];
    //group.fillMode = kCAFillModeForwards;
    group.animations = @[scaleAnimation,anim];
    group.duration = 2.5;
    //group.removedOnCompletion = NO;
    
    [self.layer addAnimation:group forKey:nil];
    
    
}



/**运动设置界面中的两个往外消失动画 之 往上移动  */
- (void)moveToRightWithAnimationBySecondViewToUpAndScale
{
    //第一两个都先缩小
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //scaleAnimation.removedOnCompletion = NO;
    //scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.85];
    //scaleAnimation.duration = 0.25f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //往上移动一点距离 再往右移动一点距离 再迅速往左移动
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    // 设置动画属性
    anim.keyPath = @"position";
    CGPoint center = self.center;
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)];
    
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y-35)];
    
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(center.x+10, center.y-35)];
    
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(center.x-60, center.y-35)];
    
    NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(center.x+200, center.y-35)];
    
    
    anim.values = @[v1,v2,v3,v4,v5];
    
    CAAnimationGroup*group=[CAAnimationGroup animation];
    group.animations = @[scaleAnimation,anim];
    group.duration = 2.5;
    
    [self.layer addAnimation:group forKey:nil];
    
}

- (void)homeAnimationithTop:(CGFloat)topInset time:(NSTimeInterval)time
{
    CGPoint center = self.center;
    CGSize size = self.frame.size;
    CGFloat magrinX;
    CGFloat magrinY;
    if(ScreenHeight == 480 ||ScreenHeight == 568){
        magrinX = 1.5;
        magrinY = 1.5;
    }else if (ScreenHeight == 667){
        magrinX = 3.0;
        magrinY = -4;
    }else if (ScreenHeight == 736){
        magrinX = 3.0;
        magrinY = -7.0;
    }
    center.x += magrinX;
    center.y = topInset+size.height*0.5-magrinY;
    
    
    [UIView animateWithDuration:time animations:^{
        self.center = center;
        
    } completion:^(BOOL finished) {
        
    }];
    
}




- (void)sportToRightFromLeftWithLeftInset:(CGFloat)left andTopInset:(CGFloat)top
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.4];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    // 设置动画属性
    anim.keyPath = @"position";
    CGPoint center = self.center;
    CGSize size = self.frame.size;
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(size.width*0.5+left, top + size.height*0.5)];
    
    anim.values = @[v1,v2];
    
    CAAnimationGroup*group=[CAAnimationGroup animation];
    group.animations = @[scaleAnimation,anim];
    group.duration = 2.0;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [self.layer addAnimation:group forKey:nil];
    
    
}
- (void)sportToLeftFromRightWithRightInset:(CGFloat)right andBottomInset:(CGFloat)bottomInset
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.4];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    // 设置动画属性
    anim.keyPath = @"position";
    CGPoint center = self.center;
    CGSize size = self.frame.size;
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(ScreenWidth-right-size.width*0.5,ScreenHeight-bottomInset-size.height*0.5)];
    
    anim.values = @[v1,v2];
    
    CAAnimationGroup*group=[CAAnimationGroup animation];
    group.animations = @[scaleAnimation,anim];
    group.duration = 2.0;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [self.layer addAnimation:group forKey:nil];
    
    
}

- (void)playBounceAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.values = @[@(1), @(1.5), @(0.9), @(0.5), @(0.1), @(1)];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    
    [self.layer addAnimation:animation forKey:@"playBounceAnimation"];
}

#pragma mark - 常用动画
//Custom Animation
- (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                 delegate:(id)delegate
{
    /** CATransition
     *
     *  @see http://www.dreamingwish.com/dream-2012/the-concept-of-coreanimation-programming-guide.html
     *  @see http://geeklu.com/2012/09/animation-in-ios/
     *
     *  CATransition 常用设置及属性注解如下:
     */
    
    CATransition *animation = [CATransition animation];
    
    /** delegate
     *
     *  动画的代理,如果你想在动画开始和结束的时候做一些事,可以设置此属性,它会自动回调两个代理方法.
     *
     *  @see CAAnimationDelegate    (按下command键点击)
     */
    
    animation.delegate = delegate;
    
    /** duration
     *
     *  动画持续时间
     */
    
    animation.duration = duration;
    
    /** timingFunction
     *
     *  用于变化起点和终点之间的插值计算,形象点说它决定了动画运行的节奏,比如是均匀变化(相同时间变化量相同)还是
     *  先快后慢,先慢后快还是先慢再快再慢.
     *
     *  动画的开始与结束的快慢,有五个预置分别为(下同):
     *  kCAMediaTimingFunctionLinear            线性,即匀速
     *  kCAMediaTimingFunctionEaseIn            先慢后快
     *  kCAMediaTimingFunctionEaseOut           先快后慢
     *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
     *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
     */
    
    /** timingFunction
     *
     *  当上面的预置不能满足你的需求的时候,你可以使用下面的两个方法来自定义你的timingFunction
     *  具体参见下面的URL
     *
     *  @see http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/CAMediaTimingFunction_class/Introduction/Introduction.html
     *
     *  + (id)functionWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
     *
     *  - (id)initWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
     */
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    
    /** fillMode
     *
     *  决定当前对象过了非active时间段的行为,比如动画开始之前,动画结束之后.
     *  预置为:
     *  kCAFillModeRemoved   默认,当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     *  kCAFillModeForwards  当动画结束后,layer会一直保持着动画最后的状态
     *  kCAFillModeBackwards 和kCAFillModeForwards相对,具体参考上面的URL
     *  kCAFillModeBoth      kCAFillModeForwards和kCAFillModeBackwards在一起的效果
     */
    
    animation.fillMode = kCAFillModeForwards;
    
    /** removedOnCompletion
     *
     *  这个属性默认为YES.一般情况下,不需要设置这个属性.
     *
     *  但如果是CAAnimation动画,并且需要设置 fillMode 属性,那么需要将 removedOnCompletion 设置为NO,否则
     *  fillMode无效
     */
    
    //    animation.removedOnCompletion = NO;
    
    /** type
     *
     *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于似有的API(我是这么认为的,可以点进去看下注释).
     *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
     *  @"cube"                     立方体翻滚效果
     *  @"moveIn"                   新视图移到旧视图上面
     *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
     *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
     *  @"pageCurl"                 向上翻一页
     *  @"pageUnCurl"               向下翻一页
     *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
     *  @"rippleEffect"             滴水效果,(不支持过渡方向)
     *  @"oglFlip"                  上下左右翻转效果
     *  @"rotate"                   旋转效果
     *  @"push"
     *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
     *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
     */
    
    /** type
     *
     *  kCATransitionFade            交叉淡化过渡
     *  kCATransitionMoveIn          新视图移到旧视图上面
     *  kCATransitionPush            新视图把旧视图推出去
     *  kCATransitionReveal          将旧视图移开,显示下面的新视图
     */
    
    animation.type = type;
    
    /** subtype
     *
     *  各种动画方向
     *
     *  kCATransitionFromRight;      同字面意思(下同)
     *  kCATransitionFromLeft;
     *  kCATransitionFromTop;
     *  kCATransitionFromBottom;
     */
    
    /** subtype
     *
     *  当type为@"rotate"(旋转)的时候,它也有几个对应的subtype,分别为:
     *  90cw    逆时针旋转90°
     *  90ccw   顺时针旋转90°
     *  180cw   逆时针旋转180°
     *  180ccw  顺时针旋转180°
     */
    
    /**
     *  type与subtype的对应关系(必看),如果对应错误,动画不会显现.
     *
     *  @see http://iphonedevwiki.net/index.php/CATransition
     */
    
    animation.subtype = subType;
    
    /**
     *  所有核心动画和特效都是基于CAAnimation,而CAAnimation是作用于CALayer的.所以把动画添加到layer上.
     *  forKey  可以是任意字符串.
     */
    
    [self.layer addAnimation:animation forKey:nil];
}


#pragma mark - Preset Animation


- (void)animationRevealFromBottomWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationRevealFromTopWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromTop];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationRevealFromLeftWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationRevealFromRightWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationEaseInWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationEaseOutWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [self.layer addAnimation:animation forKey:nil];
}


//弹跳动画,view为动画view的父view
- (void)showBounceAnimationWithFromView:(UIView *)view duration:(CFTimeInterval)duration
{
    view.hidden = NO;
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:15.0 options:0 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}


- (void)dismissBounceAnimationWithFromView:(UIView *)view duration:(CFTimeInterval)duration
{
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        } completion:^(BOOL finished) {
            view.hidden = YES;
        }];
    }];
}

//推出动画,view为动画view的父view
- (void)showPushUpAnimationWithFromView:(UIView *)view duration:(CFTimeInterval)duration
{
    self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.height);
    view.hidden = NO;
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, ScreenHeight - self.height, ScreenWidth, self.height);
    }];
}
- (void)dismissPushDownAnimationWithFromView:(UIView *)view duration:(CFTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.height);
    } completion:^(BOOL finished) {
        view.hidden = YES;
    }];
}

/**
 *  UIViewAnimation
 *
 *  @see    http://www.cocoachina.com/bbs/read.php?tid=110168
 *
 *  @brief  UIView动画应该是最简单便捷创建动画的方式了,详解请猛戳URL.
 *
 *  @method beginAnimations:context 第一个参数用来作为动画的标识,第二个参数给代理代理传递消息.至于为什么一个使用
 *                                  nil而另外一个使用NULL,是因为第一个参数是一个对象指针,而第二个参数是基本数据类型.
 *  @method setAnimationCurve:      设置动画的加速或减速的方式(速度)
 *  @method setAnimationDuration:   动画持续时间
 *  @method setAnimationTransition:forView:cache:   第一个参数定义动画类型，第二个参数是当前视图对象，第三个参数是是否使用缓冲区
 *  @method commitAnimations        动画结束
 */


- (void)animationFlipFromLeftWithDuration:(CFTimeInterval)duration
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:NO];
    [UIView commitAnimations];
}

- (void)animationFlipFromRighWithDuration:(CFTimeInterval)duration
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:NO];
    [UIView commitAnimations];
}

- (void)animationCurlUpWithDuration:(CFTimeInterval)duration
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:NO];
    [UIView commitAnimations];
}

- (void)animationCurlDownWithDuration:(CFTimeInterval)duration
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:NO];
    [UIView commitAnimations];
}

- (void)continueRotateWithDuration:(CFTimeInterval)duration
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopRotating
{
    [self.layer removeAllAnimations];
}

- (void)animationPushUpWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationPushDownWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationPushLeftWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationPushRightWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    
    [self.layer addAnimation:animation forKey:nil];
}

// presentModalViewController
- (void)animationMoveUpWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    
    [self.layer addAnimation:animation forKey:nil];
}

// dissModalViewController
- (void)animationMoveDownWithDuration:(CFTimeInterval)duration
{
    CATransition *transition = [CATransition animation];
    transition.duration =duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.layer addAnimation:transition forKey:nil];
}

- (void)animationMoveLeftWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromLeft];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationMoveRightWithDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromRight];
    
    [self.layer addAnimation:animation forKey:nil];
}



- (void)animationRotateAndScaleEffectsWithDuration:(CFTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^
     {
         /**
          *  @see       http://donbe.blog.163.com/blog/static/138048021201061054243442/
          *
          *  @param     transform   形变属性(结构体),可以利用这个属性去对view做一些翻转或者缩放.详解请猛戳↑URL.
          *
          *  @method    valueWithCATransform3D: 此方法需要一个CATransform3D的结构体.一些非详细的讲解可以看下面的URL
          *
          *  @see       http://blog.csdn.net/liubo0_0/article/details/7452166
          *
          */
         
         self.transform = CGAffineTransformMakeScale(0.001, 0.001);
         
         CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
         
         // 向右旋转45°缩小到最小,然后再从小到大推出.
         animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.70, 0.40, 0.80)];
         
         /**
          *     其他效果:
          *     从底部向上收缩一半后弹出
          *     animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0)];
          *
          *     从底部向上完全收缩后弹出
          *     animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0)];
          *
          *     左旋转45°缩小到最小,然后再从小到大推出.
          *     animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.50, -0.50, 0.50)];
          *
          *     旋转180°缩小到最小,然后再从小到大推出.
          *     animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.1, 0.2, 0.2)];
          */
         
         animation.duration = duration;
         animation.repeatCount = 1;
         [self.layer addAnimation:animation forKey:nil];
         
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:duration animations:^
          {
              self.transform = CGAffineTransformMakeScale(1.0, 1.0);
          }];
     }];
}

/** CABasicAnimation
 *
 *  @see https://developer.apple.com/library/mac/#documentation/cocoa/conceptual/CoreAnimation_guide/Articles/KVCAdditions.html
 *
 *  @brief                      便利构造函数 animationWithKeyPath: KeyPath需要一个字符串类型的参数,实际上是一个
 *                              键-值编码协议的扩展,参数必须是CALayer的某一项属性,你的代码会对应的去改变该属性的效果
 *                              具体可以填写什么请参考上面的URL,切勿乱填!
 *                              例如这里填写的是 @"transform.rotation.z" 意思就是围绕z轴旋转,旋转的单位是弧度.
 *                              这个动画的效果是把view旋转到最小,再旋转回来.
 *                              你也可以填写@"opacity" 去修改透明度...以此类推.修改layer的属性,可以用这个类.
 *
 *  @param toValue              动画结束的值.CABasicAnimation自己只有三个属性(都很重要)(其他属性是继承来的),分别为:
 *                              fromValue(开始值), toValue(结束值), byValue(偏移值),
 !                              这三个属性最多只能同时设置两个;
 *                              他们之间的关系如下:
 *                              如果同时设置了fromValue和toValue,那么动画就会从fromValue过渡到toValue;
 *                              如果同时设置了fromValue和byValue,那么动画就会从fromValue过渡到fromValue + byValue;
 *                              如果同时设置了byValue  和toValue,那么动画就会从toValue - byValue过渡到toValue;
 *
 *                              如果只设置了fromValue,那么动画就会从fromValue过渡到当前的value;
 *                              如果只设置了toValue  ,那么动画就会从当前的value过渡到toValue;
 *                              如果只设置了byValue  ,那么动画就会从从当前的value过渡到当前value + byValue.
 *
 *                              可以这么理解,当你设置了三个中的一个或多个,系统就会根据以上规则使用插值算法计算出一个时间差并
 *                              同时开启一个Timer.Timer的间隔也就是这个时间差,通过这个Timer去不停地刷新keyPath的值.
 !                              而实际上,keyPath的值(layer的属性)在动画运行这一过程中,是没有任何变化的,它只是调用了GPU去
 *                              完成这些显示效果而已.
 *                              在这个动画里,是设置了要旋转到的弧度,根据以上规则,动画将会从它当前的弧度专旋转到我设置的弧度.
 *
 *  @param duration             动画持续时间
 *
 *  @param timingFunction       动画起点和终点之间的插值计算,也就是说它决定了动画运行的节奏,是快还是慢,还是先快后慢...
 */

/** CAAnimationGroup
 *
 *  @brief                      顾名思义,这是一个动画组,它允许多个动画组合在一起并行显示.比如这里设置了两个动画,
 *                              把他们加在动画组里,一起显示.例如你有几个动画,在动画执行的过程中需要同时修改动画的某些属性,
 *                              这时候就可以使用CAAnimationGroup.
 *
 *  @param duration             动画持续时间,值得一提的是,如果添加到group里的子动画不设置此属性,group里的duration会统一
 *                              设置动画(包括子动画)的duration属性;但是如果子动画设置了duration属性,那么group的duration属性
 *                              的值不应该小于每个子动画中duration属性的值,否则会造成子动画显示不全就停止了动画.
 *
 *  @param autoreverses         动画完成后自动重新开始,默认为NO.
 *
 *  @param repeatCount          动画重复次数,默认为0.
 *
 *  @param animations           动画组(数组类型),把需要同时运行的动画加到这个数组里.
 *
 *  @note  addAnimation:forKey  这个方法的forKey参数是一个字符串,这个字符串可以随意设置.
 *
 *  @note                       如果你需要在动画group执行结束后保存动画效果的话,设置 fillMode 属性,并且把
 *                              removedOnCompletion 设置为NO;
 */

- (void)animationRotateAndScaleDownUpWithDuration:(CFTimeInterval)duration
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    rotationAnimation.duration = duration;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration = duration;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = 1;
    animationGroup.animations =[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil];
    [self.layer addAnimation:animationGroup forKey:@"animationGroup"];
}


@end
