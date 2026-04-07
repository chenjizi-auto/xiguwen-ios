//
//  UserXieyiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "UserXieyiViewController.h"
#import <WebKit/WebKit.h>

@interface UserXieyiViewController ()<WKNavigationDelegate>
@property (strong,nonatomic) WKWebView *webView;
@property (nonatomic,strong) NSString *urlString;
@end

@implementation UserXieyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.isXieyi ? @"用户协议":@"隐私协议";
    [self addPopBackBtn];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:self.webView];
    if (self.isXieyi) {
        _urlString = [HOMEURL stringByAppendingString:@"wap/news/userprotocol.html"];
    }else {
        _urlString = [HOMEURL stringByAppendingString:@"wap/news/privacy.html"];
    }
    if (self.url) {
        _urlString = self.url;
    }
    NSURL *url = [NSURL URLWithString:_urlString ?: @""];
    if (url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NavigateManager hiddenLoadingMessage];
}

#pragma mark - webview

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [NavigateManager hiddenLoadingMessage];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [NavigateManager hiddenLoadingMessage];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //    [NavigateManager showMessage:@"加载失败"];
    [NavigateManager hiddenLoadingMessage];
}
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    [NavigateManager showLoadingMessage:@"正在加载..."];
//}


#pragma mark - getter
- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}

@end
