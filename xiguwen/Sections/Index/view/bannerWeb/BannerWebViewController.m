//
//  BannerWebViewController.m
//  BoYi
//
//  Created by apple on 2017/8/17.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "BannerWebViewController.h"

@interface BannerWebViewController ()
@property (strong, nonatomic) WKWebView *webView;
@property (nonatomic, assign) BOOL hasStartedLoading;
@end

@implementation BannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.name isBlankString] ? @"详情":self.name;
    [self addPopBackBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.view addSubview:self.webView];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.hasStartedLoading) {
        return;
    }
    self.hasStartedLoading = YES;
    NSURL *url = [NSURL URLWithString:self.urlString ?: @""];
    if (!url) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    });
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
    [NavigateManager hiddenLoadingMessage];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [NavigateManager showLoadingMessage:@"正在加载..."];
}


#pragma mark - getter
- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        if (@available(iOS 10.0, *)) {
            configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            configuration.requiresUserActionForMediaPlayback = NO;
#pragma clang diagnostic pop
        }
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.opaque = NO;
        _webView.allowsBackForwardNavigationGestures = YES;
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

@end
