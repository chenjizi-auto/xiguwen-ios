//
//  ZLWithdrawalView.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/29.
//  Copyright © 2018年   . All rights reserved.
//

#import "ZLWithdrawalView.h"
#import <UIButton+AFNetworking.h>
#import "ZLKeyboardPayPassword.h"
#import "ZLKeyboardMoneyField.h"

@interface ZLWithdrawalView ()

///滑动视图
@property (nonatomic,weak) UIScrollView *scrollView;

///银行卡单元
@property (nonatomic,weak) UIView *bankUnitView;
///银行图标
@property (nonatomic,weak) UIButton *bankIconButton;
///银行名称
@property (nonatomic,weak) UILabel *bankNameLabel;
///银行卡号
@property (nonatomic,weak) UILabel *bankCardNumberLabel;
///银行标记
@property (nonatomic,weak) UIButton *bankMarkButton;

///提现单元
@property (nonatomic,weak) UIView *withdrawalUnitView;
///输入框
@property (nonatomic,weak) ZLKeyboardMoneyField *textField;
///余额
@property (nonatomic,weak) UILabel *balanceLabel;

///确定
@property (nonatomic,weak) UIButton *doneButton;

///最后录入的字符串
@property (nonatomic,strong) NSString *lastString;

///支付密码录入
@property (nonatomic,weak) ZLKeyboardPayPassword *inputPayPassword;

@end

@implementation ZLWithdrawalView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0];
        [self scrollView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLWithdrawalModel *)infoModel {
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
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 54.0, UIScreen.mainScreen.bounds.size.width, 70.0)];
        unitView.backgroundColor = UIColor.whiteColor;
        [unitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBankCardAction)]];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 15.0, 40.0, 40.0)];
        button.hidden = YES;
        [unitView addSubview:button];
        self.bankIconButton = button;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 15.0, UIScreen.mainScreen.bounds.size.width - 120.0, 20.0)];
        label.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:15.0];
        [unitView addSubview:label];
        self.bankNameLabel = label;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 40.0, UIScreen.mainScreen.bounds.size.width - 120.0, 15.0)];
        label.textColor = [UIColor colorWithRed:134.0 / 255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:14.0];
        label.hidden = YES;
        [unitView addSubview:label];
        self.bankCardNumberLabel = label;
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 40.0, 15.0, 40.0, 40.0)];
        [button setImage:[UIImage imageNamed:@"进入下一级"] forState:UIControlStateNormal];
        [unitView addSubview:button];
        self.bankMarkButton = button;
        
        [scrollView addSubview:unitView];
        self.bankUnitView = unitView;
        
        //提现信息
        unitView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(unitView.frame) + 15.0, UIScreen.mainScreen.bounds.size.width, 140.0)];
        unitView.backgroundColor = UIColor.whiteColor;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 5.0, UIScreen.mainScreen.bounds.size.width - 30.0, 35.0)];
        label.textColor = [UIColor colorWithRed:134.0 / 255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = @"提现金额";
        [unitView addSubview:label];
        
        ZLKeyboardMoneyField *textField = [[ZLKeyboardMoneyField alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(label.frame), UIScreen.mainScreen.bounds.size.width - 30.0, 50.0)];
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50.0, 50.0)];
        label.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:36.0];
        label.text = @"￥";
        textField.leftView = label;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.font = [UIFont systemFontOfSize:36.0];
        textField.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        __weak typeof(self)weakSelf = self;
        textField.didChangedText = ^(NSString *string) {
            [weakSelf textChangeAction];
        };
        [unitView addSubview:textField];
        self.textField = textField;
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(15.0, CGRectGetMaxY(textField.frame) + 12.0, UIScreen.mainScreen.bounds.size.width - 30.0, 1.0);
        layer.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0].CGColor;
        [unitView.layer addSublayer:layer];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(layer.frame), UIScreen.mainScreen.bounds.size.width - 30.0, 35.0)];
        label.font = [UIFont systemFontOfSize:14.0];
        [unitView addSubview:label];
        self.balanceLabel = label;
        
        [scrollView addSubview:unitView];
        self.withdrawalUnitView = unitView;
        
        //确定
        button = [[UIButton alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(unitView.frame) + 30.0, UIScreen.mainScreen.bounds.size.width - 30.0, 40.0)];
#warning 主色调
        button.backgroundColor = UIColor.redColor;
        button.layer.cornerRadius = 20.0;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        self.doneButton = button;
        
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (ZLKeyboardPayPassword *)inputPayPassword {
    if (!_inputPayPassword) {
        ZLKeyboardPayPassword *inputPayPassword = [ZLKeyboardPayPassword new];
        __weak typeof(self)weakSelf = self;
        inputPayPassword.results = ^(NSString *payPassword) {
            weakSelf.infoModel.payPassword = payPassword;
            if (weakSelf.infoModel.withdrawal) {
                weakSelf.infoModel.withdrawal([ZLHUD showHUDWithSuperView:weakSelf]);
            }
        };
        [self.superview addSubview:inputPayPassword];
        _inputPayPassword = inputPayPassword;
    }
    return _inputPayPassword;
}

#pragma mark - Action
- (void)registerAction {
    __weak typeof(self)weakSelf = self;
    self.infoModel.results = ^{//展示数据
        if (weakSelf.infoModel.keyId) {
            weakSelf.bankUnitView.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 54.0, UIScreen.mainScreen.bounds.size.width, 70.0);
            weakSelf.bankNameLabel.frame = CGRectMake(70.0, 15.0, UIScreen.mainScreen.bounds.size.width - 120.0, 20.0);
            weakSelf.bankMarkButton.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width - 40.0, 15.0, 40.0, 40.0);
            weakSelf.withdrawalUnitView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.bankUnitView.frame) + 15.0, UIScreen.mainScreen.bounds.size.width, 140.0);
            weakSelf.bankIconButton.hidden = NO;
            [weakSelf.bankIconButton setImage:[UIImage imageNamed:@"支付宝支付"] forState:UIControlStateNormal];
            weakSelf.bankNameLabel.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
            weakSelf.bankNameLabel.text = weakSelf.infoModel.keyTitle;
            weakSelf.bankCardNumberLabel.text = weakSelf.infoModel.subTitle;
            weakSelf.bankCardNumberLabel.hidden = NO;
        }else {
            weakSelf.bankIconButton.hidden = YES;
            weakSelf.bankNameLabel.textColor = [UIColor colorWithRed:134.0 / 255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0];
            weakSelf.bankCardNumberLabel.hidden = YES;
            weakSelf.bankUnitView.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 54.0, UIScreen.mainScreen.bounds.size.width, 50.0);
            weakSelf.bankMarkButton.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width - 40.0, 5.0, 40.0, 40.0);
            weakSelf.bankNameLabel.frame = CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 65.0, 50.0);
            weakSelf.bankNameLabel.text = @"请选择提现账户";
            weakSelf.withdrawalUnitView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.bankUnitView.frame) + 15.0, UIScreen.mainScreen.bounds.size.width, 140.0);
        }
        weakSelf.textField.text = weakSelf.infoModel.money;
        weakSelf.balanceLabel.textColor = [UIColor colorWithRed:134.0 / 255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0];
        weakSelf.balanceLabel.text = [NSString stringWithFormat:@"可用余额 %@元",weakSelf.infoModel.balance];
        weakSelf.doneButton.frame = CGRectMake(15.0, CGRectGetMaxY(weakSelf.withdrawalUnitView.frame) + 30.0, UIScreen.mainScreen.bounds.size.width - 30.0, 40.0);
        [weakSelf.doneButton setTitle:weakSelf.infoModel.time forState:UIControlStateNormal];
    };
}
- (void)doneAction {
    [self.textField endEditing:NO];
    if (!self.infoModel.keyId) {
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请选择提现账户"];
        return;
    }
    if (!self.infoModel.money) {
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请输入提现金额"];
        return;
    }
    if (![self.infoModel.money floatValue]) {
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请输入有效的提现金额"];
        return;
    }
    if (self.infoModel.error) {
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"金额已超过可提取金额"];
        return;
    }
    
    //优化金额格式
    if ([self.infoModel.money rangeOfString:@"."].location != NSNotFound) {
        NSArray *moneyArray = [self.infoModel.money componentsSeparatedByString:@"."];
        if (!moneyArray.lastObject || ![moneyArray.lastObject floatValue]) {
            self.infoModel.money = moneyArray.firstObject;
        }
    }
    
    __weak typeof(self)weakSelf = self;
    self.infoModel.payStateResults = ^(BOOL didSetup) {
        if (didSetup) {//展示支付密码验证
            [weakSelf.inputPayPassword show];
            return;
        }
        //设置支付密码
        if (weakSelf.infoModel.setupPayPassword) {
            weakSelf.infoModel.setupPayPassword();
        }
    };
    if (self.infoModel.queryPayState) {
        self.infoModel.queryPayState([ZLHUD showHUDWithSuperView:self]);
    }
}
- (void)textChangeAction {
    if (![self.textField.text isEqualToString:self.lastString]) {
        self.lastString = self.textField.text;
        if ([self.infoModel.balance floatValue] < [self.textField.text floatValue]) {
            self.balanceLabel.textColor = [UIColor colorWithRed:1.0 green:120.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
            self.balanceLabel.text = @"金额已超过可提取金额";
            self.infoModel.error = YES;
        }else {
            self.balanceLabel.textColor = [UIColor colorWithRed:134.0 / 255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0];
            self.balanceLabel.text = [NSString stringWithFormat:@"可用余额 %@元",self.infoModel.balance];
            self.infoModel.error = NO;
            self.infoModel.money = self.textField.text;
        }
    }
}
- (void)selectBankCardAction {
    if (self.infoModel.selectBankCard) {
        self.infoModel.selectBankCard();
    }
}

@end
