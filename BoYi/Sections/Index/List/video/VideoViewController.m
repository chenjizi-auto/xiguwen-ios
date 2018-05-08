//
//  VideoViewController.m
//  BoYi
//
//  Created by apple on 2017/9/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
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

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
//    [_webView loadHTMLString:_urlString baseURL:nil];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scalesPageToFit = YES;
    
    return _webView;
}

@end
