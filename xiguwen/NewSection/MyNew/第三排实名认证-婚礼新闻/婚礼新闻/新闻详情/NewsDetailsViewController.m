//
//  NewsDetailsViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/3/28.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NewsDetailsViewController.h"

@interface NewsDetailsViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation NewsDetailsViewController

#pragma mark - Setters and getters
- (UIWebView *)webView {
	if (!_webView) {
		_webView = [[UIWebView alloc] init];
		_webView.scalesPageToFit = YES;
		_webView.delegate = self;
		_webView.scrollView.bounces = NO;
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
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[NavigateManager hiddenLoadingMessage];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[NavigateManager showMessage:@"加载失败"];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[NavigateManager showLoadingMessage:@"正在加载..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}


@end
