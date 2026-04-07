//
//  VedioView.m
//  BoYi
//
//  Created by heng on 2018/4/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "VedioView.h"
#if __has_include("xiguwen-Swift.h")
#import "xiguwen-Swift.h"
#endif

@implementation VedioView

+ (VedioView *)showInView:(UIView *)view url:(NSString *)url{
#if __has_include("xiguwen-Swift.h")
    UIWindow *window = view.window ?: UIApplication.sharedApplication.keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    UIViewController *topViewController = rootViewController;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)topViewController;
        topViewController = navigationController.topViewController ?: navigationController;
    } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)topViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        if ([selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)selectedViewController;
            topViewController = navigationController.topViewController ?: navigationController;
        } else if (selectedViewController) {
            topViewController = selectedViewController;
        }
    }
    if (url.length > 0 && topViewController) {
        NSLog(@"[BMPlayer] present fullscreen url=%@ presenter=%@",
              url ?: @"",
              NSStringFromClass(topViewController.class));
        CwBMPlayerViewController *playerViewController = [[CwBMPlayerViewController alloc] initWithUrlString:url titleText:nil];
        [topViewController presentViewController:playerViewController animated:YES completion:nil];
    } else {
        NSLog(@"[BMPlayer] skip present url=%@ presenter=%@",
              url ?: @"",
              topViewController ? NSStringFromClass(topViewController.class) : @"");
    }
    return nil;
#else
    VedioView *alert = [[[NSBundle mainBundle]loadNibNamed:@"VedioView" owner:self options:nil]lastObject];
    alert.urlString = url;
    alert.frame = view.frame;
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = YES;
    alert.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, alert.bgView.height) configuration:configuration];
    alert.webView.backgroundColor = RGBA(137, 137, 137, 1);
    [alert.bgView addSubview:alert.webView];
    [alert showOnView:view];
    return alert;
#endif
}
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
- (WKWebView *)webView{
    if (_webView && _urlString.length > 0) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        [_webView loadRequest:request];
    }
    return _webView;
}
- (void)dealloc{
    [NavigateManager hiddenLoadingMessage];
    self.webView = nil;
    self.bgView = nil;
}
@end
