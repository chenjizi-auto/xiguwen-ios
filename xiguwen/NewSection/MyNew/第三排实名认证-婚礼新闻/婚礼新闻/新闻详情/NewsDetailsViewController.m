//
//  NewsDetailsViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/3/28.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import <WebKit/WebKit.h>

@interface NewsDetailsViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation NewsDetailsViewController

#pragma mark - Setters and getters
- (WKWebView *)webView {
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



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"新闻详情";
	[self addPopBackBtn];
	[self addRightBtnWithTitle: @"" image: @"分享的副本"];
	DLog(@"%@",self.model.content);
	
	[self.view addSubview:self.webView];
	self.webView.sd_layout
	.topSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.bottomSpaceToView(self.view, 0.0f);
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.model.content]]];
}

- (void)respondsToRightBtn {
	// 分享按钮
	[CwShareManager shareWebPageToPlatformWithUrl:self.model.content image:self.model.img title:self.model.title descr:@"" vc:self completion:^(id data, NSError *error) {
		
	}];
}

#pragma mark - webView Delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
	[NavigateManager hiddenLoadingMessage];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
	[NavigateManager showMessage:@"加载失败"];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [NavigateManager showMessage:@"加载失败"];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
	[NavigateManager showLoadingMessage:@"正在加载..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}


@end
