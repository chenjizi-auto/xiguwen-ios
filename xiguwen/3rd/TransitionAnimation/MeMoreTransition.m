//
//  MeMoreTransition.m
//  Base
//
//  Created by Chen on 2016/12/3.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "MeMoreTransition.h"

@implementation MeMoreTransition
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 这个是小红书的动画  通过imageView实现rec的变化，然后消失，代理调用，再把image补上，动画就是衔接得这么不自然......
    UIView* contentView = [transitionContext containerView];
    contentView.backgroundColor = [UIColor whiteColor];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [contentView addSubview:toViewController.view];
    toViewController.view.alpha = 0;

    __block UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageView.image];
    imageView.frame = self.isPush ? self.originalRec : self.destinationRec;
    [contentView addSubview:imageView];
    
    if (!self.isPush) {
        self.imageView.alpha = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        imageView.frame = self.isPush ? self.destinationRec : self.originalRec;
        toViewController.view.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [imageView removeFromSuperview];
        if (!self.isPush) {
            self.imageView.alpha = 1;
        } else
        {
            if (self.delegate) {
                [self.delegate animationFinish];
            }
        }
        imageView = nil;
    }];
}
@end
