//
//  ZLAddBankCardAView.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/31.
//  Copyright © 2018年   . All rights reserved.
//

#import "ZLAddBankCardAView.h"

@interface ZLAddBankCardAView ()

///滑动视图
@property (nonatomic,weak) UIScrollView *scrollView;
///确定
@property (nonatomic,weak) UIButton *doneButton;
///银行名称
@property (nonatomic,weak) UITextField *bankNameTextField;
///银行卡号
@property (nonatomic,weak) UITextField *bankCardNumberTextField;

@end

@implementation ZLAddBankCardAView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0];
        [self scrollView];
    }
    return self;
}

#pragma mark - Lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        scrollView.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0];
        scrollView.alwaysBounceVertical = YES;
        
        //ios11 适配
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            scrollView.scrollIndicatorInsets = scrollView.contentInset;
        }
        
        //银行卡信息
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 54.0, UIScreen.mainScreen.bounds.size.width, 100.0)];
        unitView.backgroundColor = UIColor.whiteColor;
        
        for (NSInteger index = 0; index < 2; index++) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15.0, 50.0 * index, UIScreen.mainScreen.bounds.size.width - 30.0, 50.0)];
            textField.placeholder = !index ? @"请输入支付宝账号（区分大小写）" : @"请输入支付宝账号姓名";
            textField.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.font = [UIFont systemFontOfSize:15.0];
            [textField addTarget:self action:@selector(textDidChangeAction) forControlEvents:(UIControlEventEditingChanged)];
            textField.keyboardType = UIKeyboardTypeDefault;
            [unitView addSubview:textField];
            if (!index) {
                self.bankNameTextField = textField;
            }else {
                self.bankCardNumberTextField = textField;
            }
        }
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 50.0, UIScreen.mainScreen.bounds.size.width, 0.5);
        layer.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0].CGColor;
        [unitView.layer addSublayer:layer];
        
        //确定
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(unitView.frame) + 32.0, UIScreen.mainScreen.bounds.size.width - 30.0, 40.0)];
        button.backgroundColor = [UIColor colorWithRed:212.0 / 255.0 green:212.0 / 255.0 blue:212.0 / 255.0 alpha:1.0];
        button.enabled = NO;
        button.layer.cornerRadius = 20.0;
        button.layer.masksToBounds = YES;
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        self.doneButton = button;
        
        [scrollView addSubview:unitView];
        
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

#pragma mark - Action
- (void)doneAction {
    if (!self.bankNameTextField.text.length) {
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请输入支付宝账号"];
        return;
    }
    if (!self.bankCardNumberTextField.text.length) {
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请输入支付宝账号姓名"];
        return;
    }
    if (self.infoModel.next) {
        self.infoModel.name = self.bankCardNumberTextField.text;
        self.infoModel.number = self.bankNameTextField.text;
        self.infoModel.next();
    }
}
- (void)textDidChangeAction {
    if (!self.bankNameTextField.text.length || !self.bankCardNumberTextField.text.length) {
        self.doneButton.backgroundColor = [UIColor colorWithRed:212.0 / 255.0 green:212.0 / 255.0 blue:212.0 / 255.0 alpha:1.0];
        self.doneButton.enabled = NO;
        return;
    }
    self.doneButton.backgroundColor = UIColor.redColor;
    self.doneButton.enabled = YES;
}

@end
