//
//  GuanYuWomenViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanYuWomenViewController.h"
#import "BannerWebViewController.h"
@interface GuanYuWomenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *banben;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation GuanYuWomenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于喜顾问";
    [self addPopBackBtn];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.banben.text = [NSString stringWithFormat:@"v%@",appCurVersion];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}

- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {//协议
        BannerWebViewController *webViewController = [[BannerWebViewController alloc] init];
        webViewController.name = @"用户协议";
        webViewController.urlString = @"https://www.xiguwen520.com/user.html";
        [self pushToNextVCWithNextVC:webViewController];
        
    }else {//政策
        BannerWebViewController *webViewController = [[BannerWebViewController alloc] init];
        webViewController.name = @"隐私政策";
        webViewController.urlString = @"https://www.xiguwen520.com/private.html";
        [self pushToNextVCWithNextVC:webViewController];
    }
}


@end
