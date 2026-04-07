//
//  WenZangDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/1/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "WenZangDetilViewController.h"

@interface WenZangDetilViewController ()
@property (strong,nonatomic) WKWebView *webView;
@end

@implementation WenZangDetilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文章详情页";
    [self addPopBackBtn];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:self.webView];
    if (self.urlString.length > 0) {
        NSURL *url = [NSURL URLWithString:self.urlString];
        if (url && url.scheme.length > 0) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        } else {
            [self.webView loadHTMLString:self.urlString baseURL:nil];
        }
    }
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
    //    [NavigateManager showMessage:@"加载失败"];
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
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
