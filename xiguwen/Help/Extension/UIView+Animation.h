//
//  UIView+Animation.h
//  CardioCycle
//
//  Created by 酷蜂ios on 15/11/26.
//  Copyright © 2015年 酷蜂ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    animationTypeAirBallFourSide,//上下左右晃动
    animationTypeAirBallUpAndDown,//上下晃动
    animationTypeAirBallRightToLeft,//从右往左
    animationTypeAirBallLeftToRight,//从左往右
    animationTypeCircle//打圈圈
    
}animationType;


@interface UIView (Animation)<CAAnimationDelegate>


/**针对长时间的动画*/
- (void)showAnimationWithType:(animationType)type;

/**从底部串出来，到达顶部约束多少 左侧约束多少 然后缩放比例*/
- (void)showAnimationFromBottomWithTopInset:(CGFloat)topInset leftInset:(CGFloat)leftInset finish:(void (^)())finish;


///*******////
//针对一次性动画

- (void)animationWithHeartRecoverBySmallCircle;

- (void)animationWithCircleByRightMargin:(CGFloat)rightMargin andBottomMargin:(CGFloat)bottomMargin;



- (void)narrowViewWithScale:(CGFloat)scale;

- (void)strengthViewMakeIdentity;
- (void)exerciseViewMakeIdentity;

///*****/////

/**往右移动自身宽度一半的距离*/
- (void)showAnimationWithOffsetByWidthOfSelfWidthMiddle;

/**从左往右移直到左边离屏幕的距离 底部距离 相对于父视图*/
- (void)showAnimationLeftToRight:(CGFloat)leftInset BottomInset:(CGFloat)bottomInset;

/**从右往做移直到右边离屏幕的距离  顶部距离 相对于父视图*/
- (void)showAnimationRightToLeft:(CGFloat)rightInset TopInset:(CGFloat)topInset;

/**从底部冒出来*/
- (void)showAnimationFromBottom:(CGFloat)bottomInset;

/**从左往右移动多少距离*/
- (void)showAnimationLeftToRightWithDistance:(CGFloat)distance success:(void (^)())success;
/**往上移动 并缩放*/
- (void)showAnimationWithScaleAndgotoTop:(CGFloat)topInset;
/**返回到缩放前的位置*/
- (void)showBack;
/**一直保持一个缩放动画*/
- (void)animationKeepScale:(CGFloat)scale duration:(CGFloat)duration;

- (void)directionFirstLeftThenGoRightFinish:(void (^)())success;

/**旋转多少度*/
- (void)showAnimationWithRotation:(CGFloat)rotation;

/**扩散动画*/
-(void)ligthHaloAnimation;

/**弹跳动画*/
-(void)playBounceAnimation;

-(void)showAnimationRightToLeft:(CGFloat)rightInset BottomInset:(CGFloat)bottomInset success:(void (^)())success;

#pragma mark ---- 自定义动画

/**运动设置界面中的两个往外消失动画 之 往上移动*/
- (void)moveToLeftWithAnimationByFirstViewToUpAndScale;

/**运动设置界面中的两个往外消失动画 之 往上移动*/
- (void)moveToRightWithAnimationBySecondViewToUpAndScale;


/**首页的动画*/
- (void)homeAnimationithTop:(CGFloat)topInset time:(NSTimeInterval)time;

/**运动界面的进场动画*/

- (void)sportToRightFromLeftWithLeftInset:(CGFloat)left andTopInset:(CGFloat)top;

- (void)sportToLeftFromRightWithRightInset:(CGFloat)right andBottomInset:(CGFloat)bottomInset;


#pragma mark - 常用动画

/**
 *   @brief 快速构建一个你自定义的动画,有以下参数供你设置.
 *
 *   @note  调用系统预置Type需要在调用类引入下句
 *
 *          #import <QuartzCore/QuartzCore.h>
 *
 *   @param type                动画过渡类型
 *   @param subType             动画过渡方向(子类型)
 *   @param duration            动画持续时间
 *   @param timingFunction      动画定时函数属性
 *
 *
 */

- (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                 delegate:(id)delegate;

#pragma mark - Preset Animation

/**
 *  下面是一些常用的动画效果
 */

// reveal
- (void)animationRevealFromBottomWithDuration:(CFTimeInterval)duration;
- (void)animationRevealFromTopWithDuration:(CFTimeInterval)duration;
- (void)animationRevealFromLeftWithDuration:(CFTimeInterval)duration;
- (void)animationRevealFromRightWithDuration:(CFTimeInterval)duration;

// 渐隐渐消
- (void)animationEaseInWithDuration:(CFTimeInterval)duration;
- (void)animationEaseOutWithDuration:(CFTimeInterval)duration;

//弹跳动画,view为动画view的父view
- (void)showBounceAnimationWithFromView:(UIView *)view duration:(CFTimeInterval)duration;
- (void)dismissBounceAnimationWithFromView:(UIView *)view duration:(CFTimeInterval)duration;
//推出动画,view为动画view的父view
- (void)showPushUpAnimationWithFromView:(UIView *)view duration:(CFTimeInterval)duration;
- (void)dismissPushDownAnimationWithFromView:(UIView *)view duration:(CFTimeInterval)duration;

// 翻转
- (void)animationFlipFromLeftWithDuration:(CFTimeInterval)duration;
- (void)animationFlipFromRighWithDuration:(CFTimeInterval)duration;

//持续旋转
- (void)continueRotateWithDuration:(CFTimeInterval)duration;
//停止旋转
- (void)stopRotating;

// 翻页
- (void)animationCurlUpWithDuration:(CFTimeInterval)duration;
- (void)animationCurlDownWithDuration:(CFTimeInterval)duration;

// push
- (void)animationPushUpWithDuration:(CFTimeInterval)duration;
- (void)animationPushDownWithDuration:(CFTimeInterval)duration;
- (void)animationPushLeftWithDuration:(CFTimeInterval)duration;
- (void)animationPushRightWithDuration:(CFTimeInterval)duration;

// move
- (void)animationMoveUpWithDuration:(CFTimeInterval)duration;
- (void)animationMoveDownWithDuration:(CFTimeInterval)duration;
- (void)animationMoveLeftWithDuration:(CFTimeInterval)duration;
- (void)animationMoveRightWithDuration:(CFTimeInterval)duration;

// 旋转缩放

// 各种旋转缩放效果
- (void)animationRotateAndScaleEffectsWithDuration:(CFTimeInterval)duration;

// 旋转同时缩小放大效果
- (void)animationRotateAndScaleDownUpWithDuration:(CFTimeInterval)duration;


@end
