//
//  RechargeView.m
//  BoYi
//
//  Created by 赵磊 on 2023/2/10.
//  Copyright © 2023 hengwu. All rights reserved.
//

#import "RechargeView.h"
#import "ZLKeyboardMoneyField.h"
#import "ZLTextView.h"

@interface RechargeView ()

///滑动视图
@property (nonatomic,weak) UIScrollView *scrollView;
///确定
@property (nonatomic,weak) UIButton *doneButton;

@end

@implementation RechargeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0];
        [self scrollView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(RechargeModel *)infoModel {
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
        
        ZL_Navigation_Height(navigationHeight);
        WeakSelf(self);
        ZLKeyboardMoneyField *aTextField = [[ZLKeyboardMoneyField alloc] initWithFrame:CGRectMake(15, navigationHeight + 10, UIScreen.mainScreen.bounds.size.width - 15 * 2, 50)];
        aTextField.layer.borderWidth = 1.0;
        aTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
        aTextField.placeholder = @"请输入充值金额";
        aTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        aTextField.leftViewMode = UITextFieldViewModeAlways;
        aTextField.layer.cornerRadius = 25;
        aTextField.layer.masksToBounds = true;
        aTextField.keyboardType = UIKeyboardTypeNumberPad;
        aTextField.didChangedText = ^(NSString *str){
            weakSelf.infoModel.price = str;
        };
        [scrollView addSubview:aTextField];
        
        ZLTextView *aTextView = [[ZLTextView alloc] initWithFrame:CGRectMake(15, navigationHeight + 70, UIScreen.mainScreen.bounds.size.width - 15 * 2, 100)];
        aTextView.layer.borderWidth = 1.0;
        aTextView.layer.cornerRadius = 10;
        aTextView.layer.masksToBounds = true;
        aTextView.layer.borderColor = UIColor.lightGrayColor.CGColor;
        aTextView.placeholder = @"请输入充值备注~（必填）";
        aTextView.change = ^(NSString *str){
            weakSelf.infoModel.remarks = str;
        };
        [scrollView addSubview:aTextView];
        
        //确定
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15.0, navigationHeight + 200, UIScreen.mainScreen.bounds.size.width - 30.0, 40.0)];
        button.backgroundColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.56 alpha:1.0];
        button.layer.cornerRadius = 20.0;
        button.layer.masksToBounds = YES;
        [button setTitle:@"充值" forState:UIControlStateNormal];
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
                
    };
}
- (void)doneAction {
    if ([self.infoModel.price doubleValue] <= 0) {
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请输入充值金额"];
        return;
    }
    if (self.infoModel.remarks.length <= 0) {
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请输入备注"];
        return;
    }
    if (self.infoModel.next) {
        self.infoModel.next();
    }
}

@end
