//
//  MeMoreTransition.h
//  Base
//
//  Created by Chen on 2016/12/3.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MeMoreAnimatorDelegate <NSObject>

- (void)animationFinish;

@end
@interface MeMoreTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) CGRect destinationRec;
@property (nonatomic,assign) CGRect originalRec;
@property (nonatomic,assign) BOOL isPush;
@property (nonatomic,assign) id<MeMoreAnimatorDelegate>delegate;
@end
