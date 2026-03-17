//
//  QingjianHomeViewController.m
//  BoYi
//
//  Created by heng on 2017/12/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "QingjianHomeViewController.h"
#import "XuanzheMusicSubVC.h"
#import "SendQingjianViewController.h"
#import "DianziQingjianHomeViewController.h"
#import "PreviewInvitationViewController.h"
#import "QingjianDataViewController.h"
@interface QingjianHomeViewController ()
@property (strong,nonatomic) UIWebView *webView;
@property (nonatomic, strong) NSString *previewStr;

@end

@implementation QingjianHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49)];
	[self.fatherWebView addSubview:self.webView];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.model.url]]];
	self.webView.scalesPageToFit = YES;
	self.webView.delegate = self;
	self.webView.scrollView.bounces = NO;
    [self.webView setMediaPlaybackRequiresUserAction:NO];
	
}


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"iscleanData"]] isEqualToString:@"yes"]) {
        [self willWebPush];
    }
	
	// 首先请求出音乐类型数组
	// 获取音乐类别数组
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_New_musicleibie
										method:POST
										loding:@""
										   dic:nil
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MusicTypeList"]) {
												   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicTypeList"];
											   }
											   [[NSUserDefaults standardUserDefaults] setObject:response[@"data"] forKey:@"MusicTypeList"];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
									   }];
}
- (IBAction)popa:(UIButton *)sender {
//    [self popViewConDelay];
	for (UIViewController *controller in self.navigationController.viewControllers) {
		if ([controller isKindOfClass:[DianziQingjianHomeViewController class]]) {
			DianziQingjianHomeViewController *vc = (DianziQingjianHomeViewController *)controller;
			[self.navigationController popToViewController:vc animated:YES];
		}
//		else {
//			[self popViewConDelay];
//		}
	}
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
    [NavigateManager hiddenLoadingMessage];
    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"iscleanData"];

}

- (void)willWebPush{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.model.url]]];
}
- (void)WillwebDiss{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
}


- (IBAction)action:(UIButton *)sender {
    
    if (sender.tag == 0) {//删除
        [self shanchu];
    }else if (sender.tag == 1) {//设置
		WeakSelf(self);
		UIAlertController *alert = [[UIAlertController alloc] init];
		UIAlertAction *musicAction = [UIAlertAction actionWithTitle:@"设置请柬音乐" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
			
			[weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
			
			XuanzheMusicSubVC *vc = [[XuanzheMusicSubVC alloc] init];
			vc.titleColorSelected = MAINCOLOR;
			vc.menuViewStyle = WMMenuViewStyleLine;
			vc.automaticallyCalculatesItemWidths = YES;
			vc.progressWidth = 10;
			vc.progressViewIsNaughty = YES;
			vc.showOnNavigationBar = NO;
			vc.model = weakSelf.model;
			vc.hidesBottomBarWhenPushed = YES;
            [self WillwebDiss];
			[weakSelf pushToNextVCWithNextVC:vc];
			
			[vc setOnDidReload:^{
				// 重新加载
				[weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.model.url]]];
			}];
			
		}];
		
		UIAlertAction *infoAction = [UIAlertAction actionWithTitle:@"设置婚礼信息" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
			
			[weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
			
			QingjianDataViewController *infoVC = [[QingjianDataViewController alloc] init];
			infoVC.model = self.model;
			infoVC.isEdit = YES;
            [self WillwebDiss];
			[weakSelf pushToNextVCWithNextVC:infoVC];
			[infoVC setOnDidReload:^(MyInvitationCardModel *model) {
				// 重新加载
				weakSelf.model = model;
				[weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.model.url]]];
			}];
		}];
		
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
			// 取消操作
		}];
		
		[alert addAction:musicAction];
		[alert addAction:infoAction];
		[alert addAction:cancelAction];
		
		[self presentViewController:alert animated:YES completion:nil];
    }else if (sender.tag == 2) {//预览
		// 获取预览地址并且跳转预览web页面
		PreviewInvitationViewController *vc = [[PreviewInvitationViewController alloc] init];
		vc.model = self.model;
        [self WillwebDiss];
		[self pushToNextVCWithNextVC:vc];
		
    }else {//发送
        SendQingjianViewController *send = [[SendQingjianViewController alloc] init];
        send.modalPresentationStyle =UIModalPresentationCustom;
		send.model = self.model;
        [self.navigationController pushViewController:send animated:YES];
//        [self presentViewController:send animated:YES completion:nil];
		
//		[CwShareManager shareWebPageToPlatformWithUrl:self.model.url image:self.model.cover title:[NSString stringWithFormat:@"%@&%@的婚礼请柬",self.model.xinlang,self.model.xinniang] descr:[NSString stringWithFormat:@"我们将在%@于%@举行婚礼，诚挚地邀请您的到来",[self stringForNSInteger:self.model.hunlitime],self.model.hunlidizhi] vc:self completion:^(id data, NSError *error) {
//			// 分享成功之后操作
//			
//		}];
    }
}

- (NSString *)stringForNSInteger:(NSInteger) time{
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *string = [formatter stringFromDate:date];
	return string;
}

- (void)shanchu{
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),@"id":@(self.model.id)};
	WeakSelf(self);
    [[RequestManager sharedManager] requestUrl:URL_New_shanchuqingjian
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               for (UIViewController *controller in weakSelf.navigationController.viewControllers) {
                                                   
                                                   if ([controller isKindOfClass
                                                        :[DianziQingjianHomeViewController class]]) {
                                                       [self WillwebDiss];
                                                       DianziQingjianHomeViewController *A =(DianziQingjianHomeViewController *)controller;
                                                       [weakSelf.navigationController popToViewController:A animated:YES];
                                                   }
                                               }
   
                                               
                                           }else{
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                          
                                       }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - webview

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [NavigateManager hiddenLoadingMessage];
//    //在网页加载完成后，获取每个参数
//    //获取JS的运行环境
//    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    //JS调用无参数OC
//    __weak QingjianHomeViewController *weakSelf = self;
//    _context[@"test1"] = ^() {
//        NSLog(@"123");
//    };
//    
//    //JS调用有参数的OC
//    _context[@"test2"] = ^() {
//        //用数组接收传过来的多个参数
//        NSArray *paramArray = [JSContext currentArguments];
//        //然后取出相对应的值
//        NSString *str1 = paramArray[0];
//        NSString *str2 = paramArray[1];
//        [weakSelf methondParam:str1 withStr:str2];
//    };
}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [NavigateManager showMessage:@"加载失败"];
//}
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [NavigateManager showLoadingMessage:@"正在加载..."];
//}
//- (UIWebView *)webView{
//
//    //    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
//    //    [_webView loadHTMLString:_urlString baseURL:nil];
//    //    _webView.delegate = self;
//    //    _webView.scrollView.bounces = NO;
//    ////    _webView.scalesPageToFit = YES;
//    //    return _webView;
//    // 创建请求
////    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url]];
//
//    // 自动对页面进行缩放以适应屏幕
//    _webView.scalesPageToFit = YES;
//    // 自动检测网页上的电话号码，单击可以拨打
//    // _webView.detectsPhoneNumbers = YES;
//    // 加载网页
////    [_webView loadRequest:request];
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
