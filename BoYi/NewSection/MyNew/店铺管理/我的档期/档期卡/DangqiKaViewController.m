//
//  DangqiKaViewController.m
//  BoYi
//
//  Created by heng on 2018/1/19.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "DangqiKaViewController.h"
#import "DangqinewCollectionViewCell.h"
#import "CwShareManager.h"

@interface DangqiKaViewController () <UIWebViewDelegate>


@property (nonatomic, strong) UIWebView *webView;
@property (strong,nonatomic) ShareNewmodel *sharemodel;
///分享的长图
@property (nonatomic,strong) UIImage *sendImage;

///分享
@property (nonatomic,weak) UIView *shareView;
@end

@implementation DangqiKaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的档期卡";
    [self webView];
    if (!self.shareImage) {
        [self shareData];
    }
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"" image: @"分享的副本"];
}
//
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    WeakSelf(self);
    [[RequestManager sharedManager] requestUrl:URL_scheduleCard
                                        method:POST
                                        loding:@""
                                           dic:@{@"id":@([UserDataNew sharedManager].userInfoModel.token.userid),@"type":self.shareImage ? @(2) : @(1)}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: response[@"data"]]]];
//                                           url = response[@"data"];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {

                                       }];
}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
////    self.navigationController.navigationBarHidden = NO;
//}
//
- (void)respondsToRightBtn {
    //分享图片
    if (self.shareImage) {
        if (self.sendImage) {
            [self showShareView];
        }
        [NavigateManager showMessage:@"图片可能还在生成中" detailMessage:@"请稍后重试…"];
        return;
    }
    if (self.sharemodel) {
        [CwShareManager shareWebPageToPlatformWithUrl:self.sharemodel.url
                                                image:self.sharemodel.image
                                                title:self.sharemodel.title
                                                descr:self.sharemodel.descr
                                                   vc:self
                                           completion:^(id data, NSError *error) {
                                               
                                           }];
    }
    
}

//    return;
//
//    if (self.sharemodel) {
//
////
//
//
//
////        [CwShareManager shareObject:[UMSocialMessageObject messageObject] vc:self];
//    }
//
//}
- (void)shareData{
    NSDictionary *dic = @{@"id":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxiangdangqi"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.sharemodel = [ShareNewmodel mj_objectWithKeyValues:response[@"data"]];
                                           }else{

                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];

                                       }];
}
#pragma mark - webView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [NavigateManager hiddenLoadingMessage];
    UIScrollView *scroll = self.webView.subviews.firstObject;

    scroll.frame = scroll.superview.frame;
    CGRect frm = scroll.frame;
    frm.size.height = _webView.scrollView.contentSize.height;
    scroll.frame = frm;
    [scroll.superview layoutIfNeeded];
    // 执行截图
    self.sendImage = [self screenView:scroll];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [NavigateManager showMessage:@"加载失败"];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [NavigateManager showLoadingMessage:@"正在加载..."];
}

- (UIImage *)screenView:(UIScrollView *)view{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(UIScreen.mainScreen.bounds.size.width,view.frame.size.height), YES, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRef];
    return sendImage;
}

#pragma mark - Lazy
- (UIWebView *)webView {
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - UIApplication.sharedApplication.statusBarFrame.size.height - 44.0)];
        webView.backgroundColor = [UIColor whiteColor];
        webView.opaque = NO;
        if (@available(iOS 11.0, *)) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset;
        }
        webView.delegate = self;
        webView.scalesPageToFit = YES; // 页面大小适应屏幕
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}
- (UIView *)shareView {
    if (!_shareView) {
        CGSize screenSize = UIScreen.mainScreen.bounds.size;
        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height, 0, 0)];
        shareView.backgroundColor = UIColor.whiteColor;
        
        CALayer *topLayer = [CALayer layer];
        topLayer.backgroundColor = UIColor.lightGrayColor.CGColor;
        topLayer.frame = CGRectMake(0, 0, screenSize.width, 0.5);
        [shareView.layer addSublayer:topLayer];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        label.text = @"请选择分享的平台";
        label.textAlignment = NSTextAlignmentCenter;
        [shareView addSubview:label];
        
        NSArray *imageNames = @[@"QQ好友",@"QQ空间",@"微信好友",@"朋友圈",@"新浪微博"];
        NSArray *tags = @[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Sina)];
        for (NSInteger index = 0; index < 5; index++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.width / 4 * (index % 4), CGRectGetMaxY(label.frame) + 100 * (index / 4), screenSize.width / 4, 100.0)];
            [button setImage:[UIImage imageNamed:imageNames[index]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = [tags[index] integerValue];
            [shareView addSubview:button];
            if (index == 4) {
                UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), screenSize.width, 50.0)];
                [sender setTitle:@"取消" forState:UIControlStateNormal];
                [sender setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [sender addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
                
                topLayer = [CALayer layer];
                topLayer.backgroundColor = UIColor.lightGrayColor.CGColor;
                topLayer.frame = CGRectMake(0, 0, screenSize.width, 0.5);
                [sender.layer addSublayer:topLayer];
                
                [shareView addSubview:sender];
                shareView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, CGRectGetMaxY(sender.frame));
            }
        }
        [self.view addSubview:shareView];
        _shareView = shareView;
    }
    return _shareView;
}
- (void)cancelAction {
    [self dismissShareView];
}
- (void)shareAction:(UIButton *)sender {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    [shareObject setShareImage:self.sendImage];//@"https://mobile.umeng.com/images/pic/home/social/img-1.png"
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    __weak typeof(self)weakSelf = self;
    [[UMSocialManager defaultManager] shareToPlatform:sender.tag messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
            [NavigateManager showMessage:@"分享失败！"];
        }else {
            
            //                [CwShareManager shareSuccess:2];
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                [NavigateManager showMessage:@"分享成功！"];
                [weakSelf dismissShareView];
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

- (void)showShareView {
    [UIView animateWithDuration:0.25 animations:^{
        self.shareView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - self.shareView.frame.size.height, UIScreen.mainScreen.bounds.size.width, self.shareView.frame.size.height);
    }];
}
- (void)dismissShareView {
    [UIView animateWithDuration:0.25 animations:^{
        self.shareView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, self.shareView.frame.size.height);
    }];
}

@end
