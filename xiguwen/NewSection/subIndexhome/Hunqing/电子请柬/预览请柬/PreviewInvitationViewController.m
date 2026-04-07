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
#import <WebKit/WebKit.h>

@interface PreviewInvitationViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
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
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = YES;
    if (@available(iOS 10.0, *)) {
        configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    }
	self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) configuration:configuration];
	[self.view addSubview:self.webView];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [self.model.url stringByReplacingOccurrencesOfString:@"indexedit" withString:@"index"]]]];
	self.webView.navigationDelegate = self;
	self.webView.scrollView.bounces = NO;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}
- (void)popViewConDelay
{
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"iscleanData"];
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**清除缓存和cookie*/

- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除WebView的缓存
    
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
    [self.webView evaluateJavaScript:@"document.open();document.close()" completionHandler:nil];
    [self cleanCacheAndCookie];
    self.webView = nil;
}

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
