//
//  PreviewInvitationViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/3/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "PreviewInvitationViewController.h"
#import "ShareView.h"
#import "SendQingjianViewController.h"

@interface PreviewInvitationViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ShareView *shareView;

@end

@implementation PreviewInvitationViewController

- (ShareView *)shareView {
	if (!_shareView) {
		_shareView = [[ShareView alloc] init];
	}
	return _shareView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.navigationItem setTitle: @"请柬预览"];
	[self addPopBackBtn];
	[self addRightBtnWithTitle: @"发送" image: nil];
//	[self.view addSubview:self.webView];
//	self.webView.sd_layout
//	.topSpaceToView(self.view, 0.0f)
//	.leftSpaceToView(self.view, 0.0f)
//	.rightSpaceToView(self.view, 0.0f)
//	.bottomSpaceToView(self.view, 0.0f);
//	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.urlStr]]];
	self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
	[self.view addSubview:self.webView];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [self.model.url stringByReplacingOccurrencesOfString:@"indexedit" withString:@"index"]]]];
	self.webView.scalesPageToFit = YES;
    [self.webView setMediaPlaybackRequiresUserAction:NO];
	self.webView.delegate = self;
	self.webView.scrollView.bounces = NO;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}
/**清除缓存和cookie*/

- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
}
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    [NavigateManager hiddenLoadingMessage];
    
    [self.webView removeFromSuperview];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
    [self cleanCacheAndCookie];
    self.webView = nil;
}

#pragma mark - webView Delegate
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//	[NavigateManager hiddenLoadingMessage];
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//	[NavigateManager showMessage:@"加载失败"];
//}
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//	[NavigateManager showLoadingMessage:@"正在加载..."];
//}

- (void)respondsToRightBtn {
	// 发送请柬
	SendQingjianViewController *send = [[SendQingjianViewController alloc] init];
	send.modalPresentationStyle =UIModalPresentationCustom;
	send.model = self.model;
	[self presentViewController:send animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
