//
//  BannerWebViewController.m
//  BoYi
//
//  Created by apple on 2017/8/17.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "BannerWebViewController.h"

@interface BannerWebViewController ()
@property (strong,nonatomic) UIWebView *webView;
@end

@implementation BannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.name isBlankString] ? @"详情":self.name;
    [self addPopBackBtn];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [NavigateManager hiddenLoadingMessage];
}

#pragma mark - webview

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [NavigateManager hiddenLoadingMessage];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [NavigateManager showMessage:@"加载失败"];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [NavigateManager showLoadingMessage:@"正在加载..."];
}


#pragma mark - getter
- (UIWebView *)webView{
    
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
//    [_webView loadHTMLString:_urlString baseURL:nil];
//    _webView.delegate = self;
//    _webView.scrollView.bounces = NO;
////    _webView.scalesPageToFit = YES;
//    return _webView;
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    
    // 自动对页面进行缩放以适应屏幕
    _webView.scalesPageToFit = YES;
    // 自动检测网页上的电话号码，单击可以拨打
    // _webView.detectsPhoneNumbers = YES;
    // 加载网页
    [_webView loadRequest:request];
    
    // 设置代理
    _webView.delegate = self;
    
    // 设置是否回弹
    _webView.scrollView.bounces = NO;
    
    return _webView;
}

@end
