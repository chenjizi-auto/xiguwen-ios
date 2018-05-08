//
//  MyAlertView.h
//  CardioCycle
//
//  Created by Apple on 15/12/15.
//  Copyright © 2015年 酷蜂ios. All rights reserved.
//
typedef void(^SelectBtnBlock)(NSInteger index);
#import <UIKit/UIKit.h>


@class MyAlertView;
@protocol MyAlertViewDelegate <NSObject>

@optional
- (void)myalertView:(MyAlertView*)myalertView customClickFormLeft:(UIButton *)btnLeft;
- (void)myalertView:(MyAlertView*)myalertView customClickFormRight:(UIButton *)btnRight;

@end

@interface MyAlertView : UIView

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *messageLable;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (copy, nonatomic) SelectBtnBlock block;

@property (nonatomic, weak) id<MyAlertViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent right:(NSString *)rightContent;
- (void)showInView:(UIView *)view block:(SelectBtnBlock)block;
- (IBAction)LeftBtnAction:(UIButton *)sender;
- (IBAction)RightBtnAction:(UIButton *)sender;

+ (void)showInView:(UIView *)view message:(NSString *)contentTitle left:(NSString *)leftContent right:(NSString *)rightContent block:(SelectBtnBlock)block;
@end
