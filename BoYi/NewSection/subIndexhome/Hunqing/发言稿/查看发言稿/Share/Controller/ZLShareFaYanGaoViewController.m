//
//  ZLShareFaYanGaoViewController.m
//  BoYi
//
//  Created by zhaolei on 2018/6/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShareFaYanGaoViewController.h"
#import "ZLShareFaYanGaoView.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface ZLShareFaYanGaoViewController ()

///主视图
@property (nonatomic,weak) ZLShareFaYanGaoView *shareFaYanGasoView;

@end

@implementation ZLShareFaYanGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.shareFaYanGasoView show];
}

#pragma mark - Add
- (void)addSubviews {
    ZLShareFaYanGaoView *shareFaYanGasoView = [[ZLShareFaYanGaoView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 400.0, self.view.frame.size.width, 400.0)];
    shareFaYanGasoView.titleString = self.titleString;
    shareFaYanGasoView.imageUrl = self.imageUrl;
    shareFaYanGasoView.content = self.content;
    [self.view addSubview:shareFaYanGasoView];
    self.shareFaYanGasoView = shareFaYanGasoView;
    //消失
    __weak typeof(self)weakSelf = self;
    shareFaYanGasoView.dismissPage = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    //分享
    shareFaYanGasoView.share = ^(NSInteger index) {
        [weakSelf shareWithIndex:index];
    };
}

- (void)shareWithIndex:(NSInteger)index {
    if (!index) {
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
            self.shareFaYanGasoView.errorMessage = @"未安装微信,分享失败！";
            return;
        }
    }else if (index == 1) {
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
            self.shareFaYanGasoView.errorMessage = @"未安装微信,分享失败！";
            return;
        }
    }else if (index == 2) {
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
            self.shareFaYanGasoView.errorMessage = @"未安装QQ,分享失败！";
            return;
        }
    }else if (index == 3) {
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
            self.shareFaYanGasoView.errorMessage = @"未安装QQ,分享失败！";
            return;
        }
    }else {
        NSLog(@"%d",[[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_Sina]);
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
            self.shareFaYanGasoView.errorMessage = @"未安装新浪微博,分享失败！";
            return;
        }
    }
    NSArray *array = @[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina)];
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.titleString descr:self.content thumImage:self.imageUrl];
    shareObject.webpageUrl = self.htmlUrl;
    messageObject.shareObject = shareObject;
    __weak typeof(self)weakSelf = self;
    [[UMSocialManager defaultManager] shareToPlatform:[array[index] integerValue] messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            weakSelf.shareFaYanGasoView.errorMessage = @"分享失败！";
        }else {
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                weakSelf.shareFaYanGasoView.errorMessage = @"分享成功！";
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

@end
