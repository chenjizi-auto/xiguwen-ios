//
//  ZhiZuoViewController.m
//  BoYi
//
//  Created by heng on 2017/12/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ZhiZuoViewController.h"
#import "QingjianDataViewController.h"
@interface ZhiZuoViewController ()
@property (weak, nonatomic) IBOutlet UIView *webFatherView;
@property (strong,nonatomic) UIWebView *webView;
@end

@implementation ZhiZuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.image sd_setImageWithUrl:self.model.cover placeHolder:[UIImage imageNamed:@"占位图片"]];
	
	self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49)];
	[self.webFatherView addSubview:self.webView];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.tempModel.url]]];
	self.webView.scalesPageToFit = YES;
	self.webView.delegate = self;
	self.webView.scrollView.bounces = NO;
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    self.webView.mediaPlaybackAllowsAirPlay = YES;
	UIButton *backBtn = [[UIButton alloc] init];
	[backBtn setImage:[UIImage imageNamed:@"返回按钮"] forState:(UIControlStateNormal)];
	[backBtn addTarget:self action:@selector(backRound) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:backBtn];
	backBtn.sd_layout
	.topSpaceToView(self.view, 30.0f)
	.leftSpaceToView(self.view, 20.0f)
	.widthIs(30.0f)
	.heightEqualToWidth();
}

- (void)backRound {
	[self popViewConDelay];
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
- (void)getMoBanType{
 
    [[RequestManager sharedManager] requestUrl:URL_New_MobanFrist
                                        method:POST
                                        loding:@""
                                           dic:@{@"id":@ (self.tempModel.id)}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
//                                               self.urlString = response[@"data"];
//											   [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
                                               self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49)];
                                               [self.webFatherView addSubview:self.webView];
                                               
                                           }
                                           [NavigateManager hiddenLoadingMessage];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];
                                       }];
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
//    [self getMoBanType];
//    [self.webView setMediaPlaybackRequiresUserAction:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.tempModel.url]]];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
    [NavigateManager hiddenLoadingMessage];
//    [self.webView removeFromSuperview];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
//    [self cleanCacheAndCookie];
//    self.webView = nil;
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
    }else {
		// 跳转请柬信息
        QingjianDataViewController *qinjianxinxi = [[QingjianDataViewController alloc] init];
		qinjianxinxi.tempModel = self.tempModel;
		qinjianxinxi.isEdit = NO;
        [self pushToNextVCWithNextVC:qinjianxinxi];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - webview

//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [NavigateManager hiddenLoadingMessage];
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//        [NavigateManager showMessage:@"加载失败"];
//}
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [NavigateManager showLoadingMessage:@"正在加载..."];
//}
//- (UIWebView *)webView{
//
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
//        [_webView loadHTMLString:_urlString baseURL:nil];
//        _webView.delegate = self;
//        _webView.scrollView.bounces = NO;
//    //    _webView.scalesPageToFit = YES;
////        return _webView;
//    // 创建请求
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
//
//    // 自动对页面进行缩放以适应屏幕
//    _webView.scalesPageToFit = YES;
//    // 自动检测网页上的电话号码，单击可以拨打
//    // _webView.detectsPhoneNumbers = YES;
//    // 加载网页
//    [_webView loadRequest:request];
//
//    // 设置代理
//    _webView.delegate = self;
//
//    // 设置是否回弹
//    _webView.scrollView.bounces = NO;
//
//    return _webView;
//}


@end
