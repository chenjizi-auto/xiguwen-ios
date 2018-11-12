//
//  ZLActivitiesVoteViewController.m
//  BoYi
//
//  Created by zhaolei on 2018/11/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLActivitiesVoteViewController.h"
#import "ZLHTTPSessionManager.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZLActivitiesVoteViewController ()<UIWebViewDelegate>

///导航条
@property (nonatomic,weak) UIView *navBar;
///内容视图
@property (nonatomic,weak) UIWebView *webView;
///分享
@property (nonatomic,weak) UIButton *rightItemButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;

///上下文
@property (nonatomic,strong) JSContext *jsContext;

@end

@implementation ZLActivitiesVoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webView];
    [self navBar];
    [self requestInfoData];
    self.titleLabel.text = @"活动投票";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - Lazy
- (UIView *)navBar {
    if (!_navBar) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0)];
        view.backgroundColor = UIColor.whiteColor;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height, 50.0, 40.0)];
        [button setImage:[UIImage imageNamed:@"返回上一级"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60.0, UIApplication.sharedApplication.statusBarFrame.size.height, UIScreen.mainScreen.bounds.size.width - 120.0, 40.0)];
        label.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.0];
        [view addSubview:label];
        self.titleLabel = label;
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 50.0, UIApplication.sharedApplication.statusBarFrame.size.height, 50.0, 40.0)];
        [button setImage:[UIImage imageNamed:@"音乐分享"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [view addSubview:button];
        self.rightItemButton = button;
        
        //分割线
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 43.5, UIScreen.mainScreen.bounds.size.width, 0.5);
        layer.backgroundColor = UIColor.lightGrayColor.CGColor;
        [view.layer addSublayer:layer];
        
        [self.view addSubview:view];
        _navBar = view;
    }
    return _navBar;
}
- (UIWebView *)webView {
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - UIApplication.sharedApplication.statusBarFrame.size.height - 44.0)];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        //ios11 适配
        if (@available(iOS 11.0, *)) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset;
        }
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

#pragma mark - Action
- (void)requestInfoData {
    __weak typeof(self)weakSelf = self;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/activity/index_list" Params:nil POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:responseObject[@"data"]]]];
    }];
}
- (void)leftAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction {
    JSValue *labelAction = self.jsContext[@"iosShareFunction"];
    JSValue *value = [labelAction callWithArguments:@[@""]];
    if (value) {
        NSString *string = [NSString stringWithFormat:@"%@",[value toString]];
        if ([string rangeOfString:@"key:"].location != NSNotFound) {
            NSArray *array= [string componentsSeparatedByString:@"key:"];
            // 分享按钮
            [CwShareManager shareWebPageToPlatformWithUrl:array[0] image:array[1] title:array[2] descr:array[3] vc:self completion:^(id data, NSError *error) {
                if (error) {
                    [NavigateManager showMessage:@"分享成功"];
                    return;
                }
                [NavigateManager showMessage:@"分享失败"];
            }];
        }
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView.canGoBack) {
        self.rightItemButton.hidden = NO;
    }else {
        self.rightItemButton.hidden = YES;
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    return YES;
}

@end
