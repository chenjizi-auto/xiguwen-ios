//
//  ZLNavBar.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/7/6.
//  Copyright © 2018年   . All rights reserved.
//
///齐刘海设备
#define ZL_Discern_Bang_Device(isBangDevice) BOOL isBangDevice = NO;if (@available(iOS 11.0, *)) {isBangDevice = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;}

#import "ZLNavBar.h"

@interface ZLNavBar ()<UITextFieldDelegate>

///底部分割线
@property (nonatomic,weak) CALayer *bottomLine;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///搜索框
@property (nonatomic,weak) UITextField *searchBar;
///左边按钮
@property (nonatomic,weak) UIButton *leftButton;
///右边主按钮
@property (nonatomic,weak) UIButton *rightMainButton;
///右边副按钮
@property (nonatomic,weak) UIButton *rightApposeButton;
///搜索框点击按钮
@property (nonatomic,weak) UIButton *searchBarTapButton;
///消息个数
@property (nonatomic,weak) UILabel *messageNumberLabel;
///消息提示（小红点）
@property (nonatomic,weak) UIView *messageView;
///上次搜索的字符串
@property (nonatomic,strong) NSString *lastSearchString;

@end

@implementation ZLNavBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:248.0 / 255.0 green:248.0 / 255.0 blue:248.0 / 255.0 alpha:1.0];
        CGFloat onHeight = 0;
        if (UIApplication.sharedApplication.statusBarFrame.size.height == 0) {
            ZL_Discern_Bang_Device(isBangDevice);
            if (isBangDevice) {
                onHeight = 40.0;
            }else {
                onHeight = 20.0;
            }
        }else {
            onHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
        }
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, onHeight + 44.0);
        [self bottomLine];
    }
    return self;
}

#pragma mark - Set
- (void)setShowMessagePoint:(BOOL)showMessagePoint {
    _showMessagePoint = showMessagePoint;
    self.messageView.hidden = !showMessagePoint;
}
- (void)setMessageNumber:(NSInteger)messageNumber {
    _messageNumber = messageNumber;
    if (!messageNumber) {
        self.messageNumberLabel.hidden = YES;
        return;
    }else {
        self.messageNumberLabel.hidden = NO;
    }
    NSString *numberString = [NSString stringWithFormat:@"%ld",messageNumber];
    if (messageNumber > 99) {
        numberString = @"99+";
    }
    self.messageNumberLabel.text = numberString;
    CGSize size = [numberString boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.messageNumberLabel.font} context:nil].size;
    CGFloat width = 0;
    CGFloat height = 0;
    if (messageNumber < 10) {
        width = 13.0;
        height = 13.0;
    }else {
        width = size.width + 5.0;
        height = size.height + 2.0;
    }
    self.messageNumberLabel.frame = CGRectMake(CGRectGetMaxX(self.rightMainButton.frame) - width - 5.0, UIApplication.sharedApplication.statusBarFrame.size.height + 3.0, width, height);
    self.messageNumberLabel.layer.cornerRadius = CGRectGetHeight(self.messageNumberLabel.frame) / 2.0;
    self.messageNumberLabel.layer.masksToBounds = YES;
}
- (void)setGoBackImageName:(NSString *)goBackImageName {
    _goBackImageName = goBackImageName;
    [self.leftButton setImage:[UIImage imageNamed:goBackImageName] forState:UIControlStateNormal];
}
- (void)setBarChangeSize:(CGSize)barChangeSize {
    _barChangeSize = barChangeSize;
    self.frame = CGRectMake(0, 0, barChangeSize.width, barChangeSize.height);
    self.bottomLine.frame = CGRectMake(0, barChangeSize.height - 0.3, barChangeSize.width, 0.3);
}
- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    self.bottomLine.hidden = !showBottomLine;
}
- (void)setAlphaViewAlpha:(CGFloat)alphaViewAlpha {
    _alphaViewAlpha = alphaViewAlpha;
    
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setTitleAlpha:(CGFloat)titleAlpha {
    _titleAlpha = titleAlpha;
    self.titleLabel.alpha = titleAlpha;
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}
- (void)setShowGoBack:(BOOL)showGoBack {
    _showGoBack = showGoBack;
    [self.leftButton setImage:[UIImage imageNamed:@"返回上一级"] forState:UIControlStateNormal];
    [self.leftButton setTitle:@"       " forState:UIControlStateNormal];
}
- (void)setLeftItemImageName:(NSString *)leftItemImageName {
    _leftItemImageName = leftItemImageName;
    [self.leftButton setImage:[UIImage imageNamed:leftItemImageName] forState:UIControlStateNormal];
    [self.leftButton setTitle:@"    " forState:UIControlStateNormal];
}
- (void)setLeftItemTitleImageName:(NSString *)leftItemTitleImageName {
    _leftItemTitleImageName = leftItemTitleImageName;
    [self.leftButton setImage:[UIImage imageNamed:leftItemTitleImageName] forState:UIControlStateNormal];
}
- (void)setLeftItemTitle:(NSString *)leftItemTitle {
    _leftItemTitle = leftItemTitle;
    if (leftItemTitle.length > 3) {
        leftItemTitle = [leftItemTitle substringWithRange:(NSMakeRange(0, 2))];
        leftItemTitle = [NSString stringWithFormat:@"%@…",leftItemTitle];
    }
    [self.leftButton setTitle:leftItemTitle forState:UIControlStateNormal];
}
- (void)setLeftItemTitleColor:(UIColor *)leftItemTitleColor {
    _leftItemTitleColor = leftItemTitleColor;
    [self.leftButton setTitleColor:leftItemTitleColor forState:UIControlStateNormal];
}
- (void)setRightItemImageName:(NSString *)rightItemImageName {
    _rightItemImageName = rightItemImageName;
    CGFloat size = 40.0;
    CGFloat onHeight = 0;
    if (UIApplication.sharedApplication.statusBarFrame.size.height == 0) {
        ZL_Discern_Bang_Device(isBangDevice);
        if (isBangDevice) {
            onHeight = 40.0;
        }else {
            onHeight = 20.0;
        }
    }else {
        onHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    CGFloat y = onHeight;
    CGFloat x = self.bounds.size.width - size - 5.0;
    self.rightMainButton.frame = CGRectMake(x, y, size, size);
    [self.rightMainButton setImage:[UIImage imageNamed:rightItemImageName] forState:UIControlStateNormal];
    [self updateApposeButtonFrame];
}
- (void)setRightItemTitle:(NSString *)rightItemTitle {
    _rightItemTitle = rightItemTitle;
    if (!rightItemTitle) {
        [self.rightMainButton removeFromSuperview];
        return;
    }
    [self.rightMainButton setTitle:rightItemTitle forState:UIControlStateNormal];
    [self.rightMainButton sizeToFit];
    CGFloat width = self.rightMainButton.frame.size.width + 10.0;
    CGFloat height = 40.0;
    CGFloat x = self.bounds.size.width - width - 5.0;
    CGFloat onHeight = 0;
    if (UIApplication.sharedApplication.statusBarFrame.size.height == 0) {
        ZL_Discern_Bang_Device(isBangDevice);
        if (isBangDevice) {
            onHeight = 40.0;
        }else {
            onHeight = 20.0;
        }
    }else {
        onHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    CGFloat y = onHeight;
    self.rightMainButton.frame = CGRectMake(x, y, width, height);
    [self updateApposeButtonFrame];
}
- (void)setRightItemTitleColor:(UIColor *)rightItemTitleColor {
    _rightItemTitleColor = rightItemTitleColor;
    [self.rightMainButton setTitleColor:rightItemTitleColor forState:UIControlStateNormal];
}
- (void)setApposeItemImageName:(NSString *)apposeItemImageName {
    _apposeItemImageName = apposeItemImageName;
    CGFloat size = 40.0;
    CGFloat onHeight = 0;
    if (UIApplication.sharedApplication.statusBarFrame.size.height == 0) {
        ZL_Discern_Bang_Device(isBangDevice);
        if (isBangDevice) {
            onHeight = 40.0;
        }else {
            onHeight = 20.0;
        }
    }else {
        onHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    CGFloat y = onHeight;
    CGFloat x = self.bounds.size.width - self.rightMainButton.frame.size.width - size - 5.0;
    self.rightApposeButton.frame = CGRectMake(x, y, size, size);
    [self.rightApposeButton setImage:[UIImage imageNamed:apposeItemImageName] forState:UIControlStateNormal];
}
- (void)setApposeItemTitle:(NSString *)apposeItemTitle {
    _apposeItemTitle = apposeItemTitle;
    [self.rightApposeButton setTitle:apposeItemTitle forState:UIControlStateNormal];
    [self.rightApposeButton sizeToFit];
    CGFloat width = self.rightApposeButton.frame.size.width + 10.0;
    CGFloat height = 40.0;
    CGFloat onHeight = 0;
    if (UIApplication.sharedApplication.statusBarFrame.size.height == 0) {
        ZL_Discern_Bang_Device(isBangDevice);
        if (isBangDevice) {
            onHeight = 40.0;
        }else {
            onHeight = 20.0;
        }
    }else {
        onHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    CGFloat y = onHeight;
    CGFloat x = self.bounds.size.width - self.rightMainButton.frame.size.width - width - 5.0;
    self.rightApposeButton.frame = CGRectMake(x, y, width, height);
}
- (void)setApposeItemTitleColor:(UIColor *)apposeItemTitleColor {
    _apposeItemTitleColor = apposeItemTitleColor;
    [self.rightApposeButton setTitleColor:apposeItemTitleColor forState:UIControlStateNormal];
}
- (void)setApposeItemHidden:(BOOL)apposeItemHidden {
    _apposeItemHidden = apposeItemHidden;
    self.rightApposeButton.hidden = apposeItemHidden;
}
- (void)setSearchBarPlaceholder:(NSString *)searchBarPlaceholder {
    _searchBarPlaceholder = searchBarPlaceholder;
    self.searchBar.placeholder = searchBarPlaceholder;
}
- (void)setSearchBarAngleStyle:(ZLNavigationSearchBarAngleStyle)searchBarAngleStyle {
    _searchBarAngleStyle = searchBarAngleStyle;
    switch (searchBarAngleStyle) {
        case ZLNavigationSearchBarAngleStyleLittle:
            self.searchBar.layer.cornerRadius = 5.0;
            self.searchBar.layer.masksToBounds = YES;
            break;
        case ZLNavigationSearchBarAngleStyleRound:
            self.searchBar.layer.cornerRadius = self.searchBar.frame.size.height / 2.0;
            self.searchBar.layer.masksToBounds = YES;
            break;
        default:
            break;
    }
}
- (void)setSearchBarText:(NSString *)searchBarText {
    _searchBarText = searchBarText;
    self.searchBar.text = searchBarText;
}
- (void)setSearchBarChangeFrame:(CGRect)searchBarChangeFrame {
    self.searchBar.frame = searchBarChangeFrame;
    if (self.openSearchBarTapFunction) {
        self.searchBarTapButton.frame = searchBarChangeFrame;
    }
}
- (void)setOpenSearchBarTapFunction:(BOOL)openSearchBarTapFunction {
    _openSearchBarTapFunction = openSearchBarTapFunction;
    self.searchBarTapButton.hidden = !openSearchBarTapFunction;
}
- (void)setSearchBarBecomeFirstResponder:(BOOL)searchBarBecomeFirstResponder {
    _searchBarBecomeFirstResponder = searchBarBecomeFirstResponder;
    searchBarBecomeFirstResponder
    ? [self.searchBar becomeFirstResponder]
    : [self.searchBar resignFirstResponder];
}

#pragma mark - Lazy
- (CALayer *)bottomLine {
    if (!_bottomLine) {
        CALayer *bottomLine = [[CALayer alloc] init];
        bottomLine.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0].CGColor;
        bottomLine.frame = CGRectMake(0, self.bounds.size.height - 0.3, self.bounds.size.width, 0.3);
        [self.layer addSublayer:bottomLine];
        _bottomLine = bottomLine;
    }
    return _bottomLine;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGFloat width = self.bounds.size.width - 180.0;
        CGFloat height = 40.0;
        CGFloat onHeight = 0;
    if (UIApplication.sharedApplication.statusBarFrame.size.height == 0) {
        ZL_Discern_Bang_Device(isBangDevice);
        if (isBangDevice) {
            onHeight = 40.0;
        }else {
            onHeight = 20.0;
        }
    }else {
        onHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    CGFloat y = onHeight;
        CGFloat x = (self.bounds.size.width - width) / 2;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(x, y, width, height))];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UITextField *)searchBar {
    if (!_searchBar) {
        CGFloat width = self.bounds.size.width - 140.0;
        CGFloat height = 35.0;
        CGFloat onHeight = 0;
        if (UIApplication.sharedApplication.statusBarFrame.size.height == 0) {
            ZL_Discern_Bang_Device(isBangDevice);
            if (isBangDevice) {
                onHeight = 40.0;
            }else {
                onHeight = 20.0;
            }
        }else {
            onHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
        }
        CGFloat y = onHeight + 3.0;
        CGFloat x = (self.bounds.size.width - width) / 2;
        UITextField *searchBar = [[UITextField alloc] initWithFrame:(CGRectMake(x, y, width, height))];
        UIButton *sender = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, 30.0, height))];
        [sender setImage:[UIImage imageNamed:@"search"] forState:(UIControlStateNormal)];
        searchBar.leftView = sender;
        [searchBar addTarget:self action:@selector(searchBarNowText) forControlEvents:(UIControlEventEditingChanged)];
        searchBar.leftViewMode = UITextFieldViewModeAlways;
        searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        searchBar.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1.0];
        searchBar.font = [UIFont systemFontOfSize:14.0];
        searchBar.returnKeyType = UIReturnKeySearch;
        searchBar.delegate = self;
        [self addSubview:searchBar];
        _searchBar = searchBar;
    }
    return _searchBar;
}
- (UIButton *)leftButton {
    if (!_leftButton) {
        CGFloat width = 60.0;
        CGFloat height = 40.0;
        CGFloat onHeight = 0;
    if (UIApplication.sharedApplication.statusBarFrame.size.height == 0) {
        ZL_Discern_Bang_Device(isBangDevice);
        if (isBangDevice) {
            onHeight = 40.0;
        }else {
            onHeight = 20.0;
        }
    }else {
        onHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    CGFloat y = onHeight;
        CGFloat x = 5.0;
        UIButton *leftButton = [[UIButton alloc] initWithFrame:(CGRectMake(x, y, width, height))];
        leftButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:leftButton];
        _leftButton = leftButton;
    }
    return _leftButton;
}
- (UIButton *)rightMainButton {
    if (!_rightMainButton) {
        UIButton *rightMainButton = [[UIButton alloc] initWithFrame:(CGRectZero)];
        rightMainButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [rightMainButton addTarget:self action:@selector(rightMainButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        rightMainButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:rightMainButton];
        _rightMainButton = rightMainButton;
    }
    return _rightMainButton;
}
- (UILabel *)messageNumberLabel {
    if (!_messageNumberLabel) {
        UILabel *messageNumberLabel = [[UILabel alloc] initWithFrame:(CGRectZero)];
        messageNumberLabel.backgroundColor = UIColor.redColor;
        messageNumberLabel.font = [UIFont systemFontOfSize:9.0];
        messageNumberLabel.textColor = UIColor.whiteColor;
        messageNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:messageNumberLabel];
        _messageNumberLabel = messageNumberLabel;
    }
    return _messageNumberLabel;
}
- (UIView *)messageView {
    if (!_messageView) {
        CGFloat size = 7.0;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.rightMainButton.frame) - size * 2.8, CGRectGetMinY(self.rightMainButton.frame) + size, size, size)];
        view.backgroundColor = UIColor.redColor;
        view.layer.cornerRadius = CGRectGetHeight(view.frame) / 2;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        _messageView = view;
    }
    return _messageView;
}
- (UIButton *)rightApposeButton {
    if (!_rightApposeButton) {
        UIButton *rightApposeButton = [[UIButton alloc] initWithFrame:(CGRectZero)];
        rightApposeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [rightApposeButton addTarget:self action:@selector(rightApposeButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        rightApposeButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:rightApposeButton];
        _rightApposeButton = rightApposeButton;
    }
    return _rightApposeButton;
}
- (UIButton *)searchBarTapButton {
    if (!_searchBarTapButton) {
        UIButton *searchBarTapButton = [[UIButton alloc] initWithFrame:self.searchBar.frame];
        [searchBarTapButton addTarget:self action:@selector(searchBarTapButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:searchBarTapButton];
        _searchBarTapButton = searchBarTapButton;
    }
    return _searchBarTapButton;
}

#pragma mark - Separate
- (void)updateApposeButtonFrame {
    if (self.apposeItemImageName || self.apposeItemTitle) {
        self.rightApposeButton.frame = CGRectMake(self.bounds.size.width - self.rightMainButton.frame.size.width - self.rightApposeButton.frame.size.width - 5.0, self.rightApposeButton.frame.origin.y, self.rightApposeButton.frame.size.width, self.rightApposeButton.frame.size.height);
    }
}

#pragma mark - Action
- (void)leftButtonAction {
    if (self.leftItemAction) {
        self.leftItemAction();
    }
}
- (void)rightMainButtonAction {
    if (self.rightItemAction) {
        self.rightItemAction();
    }
}
- (void)rightApposeButtonAction {
    if (self.apposeItemAction) {
        self.apposeItemAction();
    }
}
- (void)searchBarTapButtonAction {
    if (self.searchAction) {
        self.searchAction(nil);
    }
}
- (void)searchBarNowText {
    if (self.runSearchAction) {
        if (!self.lastSearchString) {
            self.lastSearchString = @"";
        }
        if ([self.searchBar.text isEqualToString:self.lastSearchString]) {
            return;
        }
        self.lastSearchString = self.searchBar.text;
        self.runSearchAction(self.searchBar.text);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [UIApplication.sharedApplication.keyWindow endEditing:NO];
    if (self.searchAction) {
        self.searchAction(textField.text);
    }
    return YES;
}

@end
