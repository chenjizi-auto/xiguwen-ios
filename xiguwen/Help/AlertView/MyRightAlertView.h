//
//  MyRightAlertView.h
//  CardioCycle
//
//  Created by 酷蜂ios on 15/12/21.
//  Copyright © 2015年 酷蜂ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyRightAlertView;

@protocol myrightAlertViewDelegate <NSObject>

- (void)didClickMyRightAlertView:(MyRightAlertView*)RightalertView;

@end

@interface MyRightAlertView : UIView



- (id)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content textOver:(BOOL)isover;

- (void)showDeviceStateTo:(UIView*)view ;
/**删除自己*/
- (void)hideSelf;

@property(nonatomic,weak)id<myrightAlertViewDelegate>delegate;

@end
