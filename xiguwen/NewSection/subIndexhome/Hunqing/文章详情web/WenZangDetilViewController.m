//
//  WenZangDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/1/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "WenZangDetilViewController.h"

@interface WenZangDetilViewController ()
@property (strong,nonatomic) UIWebView *webView;
@end

@implementation WenZangDetilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文章详情页";
    [self addPopBackBtn];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:self.webView];
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
    [_webView loadHTMLString:_urlString baseURL:nil];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    //    _webView.scalesPageToFit = YES;
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
