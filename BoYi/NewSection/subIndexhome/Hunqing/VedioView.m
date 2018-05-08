//
//  VedioView.m
//  BoYi
//
//  Created by heng on 2018/4/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "VedioView.h"

@implementation VedioView

+ (VedioView *)showInView:(UIView *)view url:(NSString *)url{
    VedioView *alert = [[[NSBundle mainBundle]loadNibNamed:@"VedioView" owner:self options:nil]lastObject];
    alert.urlString = url;
    alert.frame = view.frame;
    alert.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, alert.bgView.height)];
    alert.webView.backgroundColor = RGBA(137, 137, 137, 1);
    [alert.bgView addSubview:alert.webView];
    [alert showOnView:view];
    return alert;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [NavigateManager hiddenLoadingMessage];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [NavigateManager hiddenLoadingMessage];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [NavigateManager showLoadingMessage:@"正在加载..."];
    [MBProgressHUD showMsg:@"正在加载..." withTime:10];
}

- (IBAction)cance:(UIButton *)sender {
    [self hidden];
}
- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1;
        weakSelf.bgView.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}

- (void) hidden{
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgView.alpha = 0.01;
        //        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
#pragma mark - getter
- (UIWebView *)webView{

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
- (void)dealloc{
    [NavigateManager hiddenLoadingMessage];
    self.webView = nil;
    self.bgView = nil;
}
@end
