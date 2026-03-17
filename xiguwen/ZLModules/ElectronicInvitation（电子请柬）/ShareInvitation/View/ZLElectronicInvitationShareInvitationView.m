//
//  ZLElectronicInvitationShareInvitationView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationShareInvitationView.h"
#import <UIButton+AFNetworking.h>

@interface ZLElectronicInvitationShareInvitationView ()

///是否处于展示
@property (nonatomic,unsafe_unretained) BOOL isShowing;
///是否处于隐藏
@property (nonatomic,unsafe_unretained) BOOL isDismissing;
///灰色蒙版
@property (nonatomic,weak) UIView *hudView;
///标题
@property (nonatomic,weak) UITextField *titleTextField;
///图片
@property (nonatomic,weak) UIButton *iconButton;
///内容
@property (nonatomic,weak) UITextView *contentTextView;
///分享平台块
@property (nonatomic,weak) UIView *itemsView;
///取消
@property (nonatomic,weak) UIButton *cancelButton;

///图片换地址时的蒙版
@property (nonatomic,weak) UIView *uploadImageHudView;
///错误提示
@property (nonatomic,weak) UILabel *errorLabel;
///完成
@property (nonatomic,weak) UIView *doneView;

@end

@implementation ZLElectronicInvitationShareInvitationView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        self.backgroundColor = UIColor.whiteColor;
        [self itemsView];
    }
    return self;
}

#pragma mark - Set
- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.iconButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"square_placeholder_ small"]];
}
- (void)setSharetime:(NSString *)sharetime {
    _sharetime = sharetime;
    if ([sharetime isKindOfClass:[NSString class]]) {
        if ([sharetime rangeOfString:@"-"].location != NSNotFound) {
            NSArray *array = [sharetime componentsSeparatedByString:@"-"];
            self.contentTextView.text = [NSString stringWithFormat:@"我们将在%@年%@月%@日举行宴会，诚挚地邀请您的到来。",array.firstObject,array[1],array.lastObject];
            return;
        }else if ([sharetime rangeOfString:@"年"].location != NSNotFound
                  && [sharetime rangeOfString:@"月"].location != NSNotFound) {
            NSArray *array = [sharetime componentsSeparatedByString:@"年"];
            NSString *monthString = array.lastObject;
            NSArray *monthArray = [monthString componentsSeparatedByString:@"月"];
            NSString *dayString = monthArray.lastObject;
            if ([dayString rangeOfString:@"日"].location != NSNotFound) {
                NSArray *dayArray = [dayString componentsSeparatedByString:@"日"];
                if ([dayArray isKindOfClass:[NSArray class]]) {
                    if (dayArray.count) {
                        dayString = dayArray.firstObject;
                    }
                }
            }
            self.contentTextView.text = [NSString stringWithFormat:@"我们将在%@年%@月%@日举行宴会，诚挚地邀请您的到来。",array.firstObject,monthArray.firstObject,dayString];
            return;
        }
    }
    self.contentTextView.text = @"我们将在xx年xx月xx日举行宴会，诚挚地邀请您的到来。";
}
- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    self.showHud = NO;
    [self.iconButton setImage:iconImage forState:UIControlStateNormal];
}
- (void)setErrorMessage:(NSString *)errorMessage {
    _errorMessage = errorMessage;
    [self showErrorMessage];
}
- (void)setShowHud:(BOOL)showHud {
    if (_showHud != showHud) {
        _showHud = showHud;
        if (showHud) {
            [self showSaveDataHudView];
        }else {
            if (self.uploadImageHudView) {
                [self.uploadImageHudView removeFromSuperview];
            }
        }
    }
}

#pragma mark - Lazy
- (UIView *)hudView {
    if (!_hudView) {
        UIView *hudView = [[UIView alloc] initWithFrame:self.superview.frame];
        hudView.alpha = 0;
        hudView.backgroundColor = UIColor.blackColor;
        [hudView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)]];
        [self.superview addSubview:hudView];
        [self.superview bringSubviewToFront:self];
        _hudView = hudView;
    }
    return _hudView;
}
- (UITextField *)titleTextField {
    if (!_titleTextField) {
        UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50.0)];
        titleTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15.0, CGRectGetHeight(titleTextField.frame))];
        titleTextField.leftViewMode = UITextFieldViewModeAlways;
        titleTextField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15.0, CGRectGetHeight(titleTextField.frame))];
        titleTextField.rightViewMode = UITextFieldViewModeAlways;
        titleTextField.placeholder = @"请输入标题";
        [self addSubview:titleTextField];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, CGRectGetHeight(titleTextField.frame) - 1.0, CGRectGetWidth(titleTextField.frame), 1.0);
        layer.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor;
        [titleTextField.layer addSublayer:layer];
        _titleTextField = titleTextField;
    }
    return _titleTextField;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 50.0, self.frame.size.width, 50.0)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:cancelButton];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, CGRectGetWidth(cancelButton.frame), 1.0);
        layer.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor;
        [cancelButton.layer addSublayer:layer];
        _cancelButton = cancelButton;
    }
    return _cancelButton;
}
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.titleTextField.frame) + 15.0, 100.0, 100.0)];
        [iconButton setImage:[UIImage imageNamed:@"square_placeholder_ small"] forState:UIControlStateNormal];
        iconButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [iconButton addTarget:self action:@selector(changeImageAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UITextView *)contentTextView {
    if (!_contentTextView) {
        UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame) + 15.0, CGRectGetMinY(self.iconButton.frame), self.frame.size.width - CGRectGetMaxX(self.iconButton.frame) - 30.0, CGRectGetHeight(self.iconButton.frame))];
        [self addSubview:contentTextView];
        _contentTextView = contentTextView;
    }
    return _contentTextView;
}
- (UIView *)itemsView {
    if (!_itemsView) {
        UIView *itemsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentTextView.frame) + 15.0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(self.contentTextView.frame) - 15.0 - CGRectGetHeight(self.cancelButton.frame))];
        [self addSubview:itemsView];
        //分割线
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(15.0, 0, CGRectGetWidth(itemsView.frame) - 30.0, 1.0);
        layer.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor;
        [itemsView.layer addSublayer:layer];
        //子视图
        NSArray *imageNames = @[@"朋友圈.png",@"微信好友.png",@"QQ好友.png",@"QQ空间.png",@"新浪微博.png"];
        CGFloat size = 60.0;
        NSInteger column = 4;
        CGFloat edgeSpace = 25.0;
        CGFloat horizontalSpace = 20.0;
        CGFloat verticalSpace = (CGRectGetWidth(itemsView.frame) - edgeSpace * 2 - size * column) / (column - 1);
        for (NSInteger index = 0; index < imageNames.count; index++) {
            UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(edgeSpace + (size + verticalSpace) * (index % column), 15.0 + (size + horizontalSpace) * (index / column), size, size)];
            sender.tag = index;
            [sender addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            [sender setImage:[UIImage imageWithContentsOfFile:[NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:imageNames[index]]] forState:UIControlStateNormal];
            [itemsView addSubview:sender];
        }
        _itemsView = itemsView;
    }
    return _itemsView;
}
- (UILabel *)errorLabel {
    if (!_errorLabel) {
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        errorLabel.textColor = UIColor.whiteColor;
        errorLabel.backgroundColor = UIColor.blackColor;
        errorLabel.textAlignment = NSTextAlignmentCenter;
        errorLabel.layer.cornerRadius = 3.0;
        errorLabel.layer.masksToBounds = YES;
        errorLabel.font = [UIFont systemFontOfSize:14.0];
        [self.superview addSubview:errorLabel];
        _errorLabel = errorLabel;
    }
    return _errorLabel;
}
- (UIView *)doneView {
    if (!_doneView) {
        UIView *doneView = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, 40.0)];
        doneView.backgroundColor = UIColor.whiteColor;
        [self.superview addSubview:doneView];
        CALayer *layer = [CALayer layer];
        layer.backgroundColor =UIColor.lightGrayColor.CGColor;
        layer.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0.5);
        [doneView.layer addSublayer:layer];
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(doneView.frame) - 80.0, 0, 80.0, CGRectGetHeight(doneView.frame))];
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
        sender.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [sender addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [doneView addSubview:sender];
        _doneView = doneView;
    }
    return _doneView;
}

#pragma mark - Action
- (void)tapGestureRecognizerAction {
    [UIApplication.sharedApplication.delegate.window endEditing:NO];
    [self dismiss];
}
- (void)cancelAction {
    [self dismiss];
}
- (void)changeImageAction {
    if (self.changeImage) {
        self.changeImage();
    }
}
- (void)shareAction:(UIButton *)sender {
    if (self.titleTextField.text.length < 1) {
        self.errorMessage = @"标题不能为空";
        return;
    }
    if (self.contentTextView.text.length < 1) {
        self.errorMessage = @"内容不能为空";
        return;
    }
    if (self.share) {
        self.showHud = YES;
        self.share(sender.tag,self.titleTextField.text,self.contentTextView.text);
    }
}
- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    CGSize size = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGPoint point = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin;
    CGFloat y = (point.y != UIScreen.mainScreen.bounds.size.height) ? UIScreen.mainScreen.bounds.size.height - size.height - 220.0: UIScreen.mainScreen.bounds.size.height - 400.0;
    CGFloat doneY = (point.y != UIScreen.mainScreen.bounds.size.height) ? point.y - 40.0 : UIScreen.mainScreen.bounds.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.doneView.frame = CGRectMake(0, doneY, UIScreen.mainScreen.bounds.size.width, 40.0);
        self.frame = CGRectMake(0, y, self.frame.size.width, self.frame.size.height);
    }];
}
- (void)doneButtonAction {
    [UIApplication.sharedApplication.delegate.window endEditing:NO];
}

#pragma mark - separate
- (void)show {
    if (!self.isShowing) {
        self.isShowing = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.hudView.alpha = 0.2;
            self.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 400.0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            self.isDismissing = NO;
        }];
    }
}
- (void)dismiss {
    if (!self.isDismissing) {
        self.isDismissing = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.hudView.alpha = 0;
            self.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            self.isShowing = NO;
            if (self.dismissPage) {
                self.dismissPage();
            }
        }];
    }
}
- (void)showSaveDataHudView {
    UIView *hudView = [[UIView alloc] initWithFrame:self.superview.bounds];
    [self.superview addSubview:hudView];
    self.uploadImageHudView = hudView;
    UIView *alphaView = [[UIView alloc] initWithFrame:self.superview.bounds];
    alphaView.alpha = 0.2;
    alphaView.backgroundColor = UIColor.blackColor;
    [hudView addSubview:alphaView];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80.0, 80.0)];
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityIndicatorView.color = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
    [hudView addSubview:activityIndicatorView];
    activityIndicatorView.layer.cornerRadius = 5.0;
    activityIndicatorView.layer.masksToBounds = YES;
    activityIndicatorView.backgroundColor = UIColor.whiteColor;
    activityIndicatorView.center = hudView.center;
    [activityIndicatorView startAnimating];
}
- (void)showErrorMessage {
    self.showHud = NO;
    CGSize size = [self.errorMessage boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 50.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    CGFloat width = size.width + 20;
    CGFloat height = size.height + 20;
    CGFloat x = (UIScreen.mainScreen.bounds.size.width - width) * 0.5;
    CGFloat y = UIScreen.mainScreen.bounds.size.height - height - 40.0;
    self.errorLabel.frame = CGRectMake(x, y, width, height);
    self.errorLabel.text = self.errorMessage;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.errorLabel removeFromSuperview];
    });
}

@end
