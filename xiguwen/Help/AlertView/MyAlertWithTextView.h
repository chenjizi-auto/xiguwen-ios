//
//  MyAlertWithTextView.h
//  Base
//
//  Created by byrd-dreamer1 on 16/8/23.
//  Copyright © 2016年 bodecn. All rights reserved.
//
typedef void(^EditTextBlock)(NSString *text);

#import <UIKit/UIKit.h>
#import "UItextViewWithPlaceHloder.h"
@class MyAlertWithTextView;
@protocol MyAlertWithTextViewDelegate <NSObject>

@optional
- (void)MyAlertWithTextView:(MyAlertWithTextView *)myalertView customClickFormLeft:(UIButton *)btnLeft;
- (void)MyAlertWithTextView:(MyAlertWithTextView *)myalertView customClickFormRight:(UIButton *)btnRight;

@end

@interface MyAlertWithTextView : UIView <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *TextView;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (copy, nonatomic) EditTextBlock block;


@property (nonatomic, weak) id<MyAlertWithTextViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent right:(NSString *)rightContent;
- (void)showInView:(UIView *)view block:(EditTextBlock)block;
- (IBAction)LeftBtnAction:(UIButton *)sender;
- (IBAction)RightBtnAction:(UIButton *)sender;
@end
