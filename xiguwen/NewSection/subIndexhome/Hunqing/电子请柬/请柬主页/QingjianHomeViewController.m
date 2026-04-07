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
@property (strong,nonatomic) WKWebView *webView;
@property (nonatomic, strong) NSString *previewStr;

@end

@implementation QingjianHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = YES;
    if (@available(iOS 10.0, *)) {
        configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    }
	self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49) configuration:configuration];
	[self.fatherWebView addSubview:self.webView];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.model.url]]];
	self.webView.navigationDelegate = self;
	self.webView.scrollView.bounces = NO;
	
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
    [self.webView evaluateJavaScript:@"document.open();document.close()" completionHandler:nil];
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

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
}


@end
