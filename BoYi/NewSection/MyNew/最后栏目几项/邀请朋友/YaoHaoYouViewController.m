//
//  YaoHaoYouViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "YaoHaoYouViewController.h"
#import <HMQRCodeScanner/HMScannerController.h>
@interface YaoHaoYouViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImage;
@property (nonatomic, strong) NSString *urlStr;
@end

@implementation YaoHaoYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isYaoqingYonghu) {
        self.navigationItem.title = @"邀请新人用户";
        self.titlewh.text = @"通过邀请新人用户扫描下图二维码，可以直接安装";
        [self.btn setTitle:@"邀请新人用户" forState:UIControlStateNormal];
    }else {
        self.navigationItem.title = @"邀请婚嫁商家";
        self.titlewh.text = @"通过邀请婚嫁商家扫描下图二维码，可以直接安装";
        [self.btn setTitle:@"邀请婚嫁商家" forState:UIControlStateNormal];
    }
    
    [self addPopBackBtn];
	
	WeakSelf(self);
	// 邀请码请求
    NSString *url;
    if (self.isYaoqingYonghu) {
        url = URL_invitation;
    }else {
        url = [HOMEURL stringByAppendingString:@"appapi/invited/yaoqingsj"];
    }
	[[RequestManager sharedManager] requestUrl:url
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   weakSelf.urlStr = [response[@"data"] objectForKey:@"url"];
										   DLog(@"%@",[response[@"data"] objectForKey:@"url"])
										   @weakify(self);
										   [HMScannerController cardImageWithCardName:[response[@"data"] objectForKey:@"url"] avatar:nil scale:0.2 completion:^(UIImage *image) {
											   @strongify(self);
											   self.QRCodeImage.image = image;
										   }];
									   }
									   failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];
}

- (IBAction)invitation:(UIButton *)sender {
	// 点击邀请好友（分享功能）
	[CwShareManager shareWebPageToPlatformWithUrl:self.urlStr image:[UIImage imageNamed:@"logongon"] title:@"你的好友送来50元现金抵扣券，快点我领取吧。" descr:@"下载喜GO做最美新娘，婚嫁一站式服务平台，专业，贴心，高质量婚礼服务！" vc:self completion:^(id data, NSError *error) {
	}];
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
