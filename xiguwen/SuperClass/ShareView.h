//
//  ShareView.h
//  ThreeAsk_New
//
//  Created by apple on 2017/6/29.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HNShareViewType) {
    ShareViewTypeDownApp
};


@interface ShareView : UIView

- (void)show;

@property (nonatomic, weak) UIViewController *presentedController;
@property (nonatomic, assign) HNShareViewType type;

@end
