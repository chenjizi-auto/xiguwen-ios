//
//  ZLAddBankCardCView.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/11/1.
//  Copyright © 2018年   . All rights reserved.
//

#import "ZLAddBankCardCView.h"

@interface ZLAddBankCardCView ()<UITextFieldDelegate>

///滑动视图
@property (nonatomic,weak) UIScrollView *scrollView;
///手机号
@property (nonatomic,weak) UILabel *phoneLabel;
///验证码
@property (nonatomic,weak) UITextField *authCodeTextField;
///确定
@property (nonatomic,weak) UIButton *doneButton;

@end

@implementation ZLAddBankCardCView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0];
        [self scrollView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLAddBankCardCModel *)infoModel {
    _infoModel = infoModel;
    [self registerAction];
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
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 30.0, 50.0)];
        label.textColor = [UIColor colorWithRed:134.0 / 255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:14.0];
        [unitView addSubview:label];
        self.phoneLabel = label;
        
        [scrollView addSubview:unitView];
        
        unitView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(unitView.frame), UIScreen.mainScreen.bounds.size.width, 50.0)];
        unitView.backgroundColor = UIColor.whiteColor;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 30.0, 50.0)];
        textField.delegate = self;
        textField.placeholder = @"请输入验证码";
        textField.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont systemFontOfSize:16.0];
        [textField addTarget:self action:@selector(textDidChangeAction) forControlEvents:(UIControlEventEditingChanged)];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [unitView addSubview:textField];
        self.authCodeTextField = textField;
        
        [scrollView addSubview:unitView];
        
        //确定
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(unitView.frame) + 32.0, UIScreen.mainScreen.bounds.size.width - 30.0, 40.0)];
        button.backgroundColor = [UIColor colorWithRed:212.0 / 255.0 green:212.0 / 255.0 blue:212.0 / 255.0 alpha:1.0];
        button.enabled = NO;
        button.layer.cornerRadius = 20.0;
        button.layer.masksToBounds = YES;
        [button setTitle:@"确认添加" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        self.doneButton = button;
        
        
        
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

#pragma mark - Action
- (void)registerAction {
    __weak typeof(self)weakSelf = self;
    self.infoModel.results = ^{//展示数据
        weakSelf.phoneLabel.text = [NSString stringWithFormat:@"请输入%@收到的短信验证码：",weakSelf.infoModel.starPhone];
    };
}
- (void)doneAction {
    self.infoModel.code = self.authCodeTextField.text;
    if (self.infoModel.done) {
        self.infoModel.done();
    }
}
- (void)textDidChangeAction {
    if (self.authCodeTextField.text.length != 6) {
        self.doneButton.backgroundColor = [UIColor colorWithRed:212.0 / 255.0 green:212.0 / 255.0 blue:212.0 / 255.0 alpha:1.0];
        self.doneButton.enabled = NO;
        return;
    }
    self.doneButton.backgroundColor = UIColor.redColor;
    self.doneButton.enabled = YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= 6 && ![string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

@end
