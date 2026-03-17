//
//  ZLSearchOrderViewController.m
//  BoYi
//
//  Created by    on 2019/3/8.
//  Copyright © 2019 hengwu. All rights reserved.
//

#import "ZLSearchOrderViewController.h"
#import "HunQinOrderSubViewController.h"
#import "HunqingJiedanSubViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface ZLSearchOrderViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, assign) BOOL iqWasEnabled;
@property (nonatomic, assign) BOOL iqWasAutoToolbarEnabled;

@end

@implementation ZLSearchOrderViewController

- (BOOL)useClearBar {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftItemsSupplementBackButton = NO;
    [self setupNavigationSearchView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    self.iqWasEnabled = keyboardManager.enable;
    self.iqWasAutoToolbarEnabled = keyboardManager.enableAutoToolbar;
    keyboardManager.enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchTextField resignFirstResponder];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = self.iqWasEnabled;
    keyboardManager.enableAutoToolbar = self.iqWasAutoToolbarEnabled;
}

- (void)setupNavigationSearchView {
    self.navigationItem.leftBarButtonItem = nil;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width - 20.0, 40.0)];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5.0, CGRectGetWidth(view.frame) - 50.0, 30.0)];
    textField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    textField.layer.borderWidth = 0.5;
    textField.font = [UIFont systemFontOfSize:15.0];
    textField.textColor = [UIColor colorWithWhite:51 / 255.0 alpha:1.0];
    textField.layer.cornerRadius = CGRectGetHeight(textField.frame) / 2;
    textField.layer.masksToBounds = YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.placeholder = @"请输入搜索类容";
    textField.returnKeyType = UIReturnKeySearch;
    textField.delegate = self;
    if (@available(iOS 9.0, *)) {
        textField.inputAssistantItem.leadingBarButtonGroups = @[];
        textField.inputAssistantItem.trailingBarButtonGroups = @[];
    }
    [textField addTarget:self action:@selector(searchTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(searchTextDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:self action:@selector(searchTextDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    self.searchTextField = textField;

    UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12.0, CGRectGetHeight(textField.frame))];
    textField.leftView = leftPaddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;

    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14.0, 14.0)];
    searchImageView.contentMode = UIViewContentModeScaleAspectFit;
    searchImageView.image = [UIImage imageNamed:@"邀请新成员 搜索"];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30.0, CGRectGetHeight(textField.frame))];
    searchImageView.center = CGPointMake(CGRectGetWidth(rightView.bounds) * 0.5, CGRectGetHeight(rightView.bounds) * 0.5);
    [rightView addSubview:searchImageView];
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    [view addSubview:textField];
    
    UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(view.bounds.size.width - 40.0, 0, 40, 40)];
    actionButton.backgroundColor = [UIColor clearColor];
    [actionButton setTitleColor:[UIColor colorWithRed:1.0 green:96 / 255.0 blue:149 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    actionButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [actionButton addTarget:self action:@selector(handleActionButtonTap) forControlEvents:UIControlEventTouchUpInside];
    self.actionButton = actionButton;
    [self updateActionButtonTitle];
    [view addSubview:actionButton];
    
    self.navigationItem.titleView = view;
}

- (void)searchTextDidChange:(UITextField *)textField {
    [self updateActionButtonTitle];
}

- (void)searchTextDidBeginEditing:(UITextField *)textField {
    if (!textField.isFirstResponder) {
        [textField becomeFirstResponder];
    }
}

- (void)searchTextDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchWithCurrentText];
    return YES;
}

- (void)updateActionButtonTitle {
    NSString *buttonTitle = [self normalizedSearchText].length > 0 ? @"搜索" : @"取消";
    [self.actionButton setTitle:buttonTitle forState:UIControlStateNormal];
}

- (NSString *)normalizedSearchText {
    return [self.searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)handleActionButtonTap {
    if ([self normalizedSearchText].length > 0) {
        [self searchWithCurrentText];
        return;
    }
    [self cancelAction];
}

- (void)searchWithCurrentText {
    NSString *text = [self normalizedSearchText];
    if (text.length == 0) {
        [self updateActionButtonTitle];
        return;
    }
    [self.searchTextField resignFirstResponder];
    if (!self.shopOrder) {
        HunQinOrderSubViewController *hunQinOrderSubVc = [HunQinOrderSubViewController new];
        hunQinOrderSubVc.statusFlag = 0;
        hunQinOrderSubVc.searchString = text;
        [self.navigationController pushViewController:hunQinOrderSubVc animated:YES];
        return;
    }
    HunqingJiedanSubViewController *hunqingJiedanSubVc = [HunqingJiedanSubViewController new];
    hunqingJiedanSubVc.statusFlag = 0;
    hunqingJiedanSubVc.searchString = text;
    [self.navigationController pushViewController:hunqingJiedanSubVc animated:YES];
}

- (void)cancelAction {
    [self.searchTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


@end
