//
//  ZLSearchOrderViewController.m
//  BoYi
//
//  Created by 赵磊 on 2019/3/8.
//  Copyright © 2019 hengwu. All rights reserved.
//

#import "ZLSearchOrderViewController.h"
#import "ZLTextField.h"
#import "HunQinOrderSubViewController.h"
#import "HunqingJiedanSubViewController.h"

@interface ZLSearchOrderViewController ()

@end

@implementation ZLSearchOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addPopBackBtn];
}

- (void)addPopBackBtn {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width - 20.0, 40.0)];
    
    ZLTextField *textField = [[ZLTextField alloc] initWithFrame:CGRectMake(0, 5.0, CGRectGetWidth(view.frame) - 50.0, 30.0)];
    textField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    textField.layer.borderWidth = 0.5;
    textField.font = [UIFont systemFontOfSize:15.0];
    textField.textColor = [UIColor colorWithWhite:51 / 255.0 alpha:1.0];
    textField.layer.cornerRadius = CGRectGetHeight(textField.frame) / 2;
    textField.layer.masksToBounds = YES;
    __weak typeof(self)weakSelf = self;
    textField.done = ^(NSString * _Nonnull text) {
        if (!weakSelf.shopOrder) {
            HunQinOrderSubViewController *hunQinOrderSubVc = [HunQinOrderSubViewController new];
            hunQinOrderSubVc.statusFlag = 0;
            hunQinOrderSubVc.searchString = text;
            [weakSelf.navigationController pushViewController:hunQinOrderSubVc animated:YES];
            return ;
        }
        HunqingJiedanSubViewController *hunqingJiedanSubVc = [HunqingJiedanSubViewController new];
        hunqingJiedanSubVc.statusFlag = 0;
        hunqingJiedanSubVc.searchString = text;
        [weakSelf.navigationController pushViewController:hunqingJiedanSubVc animated:YES];
    };
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0, CGRectGetHeight(textField.frame))];
    [button setImage:[UIImage imageNamed:@"邀请新成员 搜索"] forState:UIControlStateNormal];
    textField.leftView = button;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [view addSubview:textField];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(view.bounds.size.width - 40.0, 0, 40, 40)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setTitleColor:[UIColor colorWithRed:1.0 green:96 / 255.0 blue:149 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [backBtn addTarget:self action:@selector(cancelAction)forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    self.navigationItem.titleView = view;
}

- (void)cancelAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
