//
//  ZLKeyboardBar.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/7/11.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import "ZLKeyboardBar.h"

@interface ZLKeyboardBar ()

///完成
@property (nonatomic,weak) UIButton *doneButton;
///顶部分割线
@property (nonatomic,weak) CALayer *topLine;

@end

@implementation ZLKeyboardBar

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, 0);
        self.backgroundColor = UIColor.whiteColor;
        [self doneButton];
        [self topLine];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}
+ (instancetype)shared {
    static ZLKeyboardBar *keyboardBar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyboardBar = [self new];
    });
    return keyboardBar;
}
- (void)removeFromSuperview {
    //阻断
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    [self.doneButton setTitle:title forState:UIControlStateNormal];
}

#pragma mark - Lazy
- (UIButton *)doneButton {
    if (!_doneButton) {
        UIButton *doneButton = [[UIButton alloc] initWithFrame:(CGRectMake(UIScreen.mainScreen.bounds.size.width - 60.0, 0, 60, 35.0))];
        [doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [doneButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        doneButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [doneButton addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneButton];
        _doneButton = doneButton;
    }
    return _doneButton;
}
- (CALayer *)topLine {
    if (!_topLine) {
        CALayer *topLine = [CALayer layer];
        topLine.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0.5);
        topLine.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0].CGColor;
        [self.layer addSublayer:topLine];
        _topLine = topLine;
    }
    return _topLine;
}

#pragma mark - Action
- (void)doneButtonAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"done" object:nil];
    [[UIApplication sharedApplication].delegate.window endEditing:NO];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y != UIScreen.mainScreen.bounds.size.height) {
        if (!self.hidden) {
            [UIView animateWithDuration:0.25 animations:^{
                self.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - frame.size.height - 35.0, UIScreen.mainScreen.bounds.size.width, 35.0);
            }];
        }
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, 35.0);
        }];
    }
}

#pragma mark - Public
- (void)showInView:(UIView *)view {
    self.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, 35.0);
    if (view) {
        self.hidden = NO;
        [view addSubview:self];
        return;
    }
    self.hidden = YES;
    [UIApplication.sharedApplication.delegate.window addSubview:self];
}

@end
