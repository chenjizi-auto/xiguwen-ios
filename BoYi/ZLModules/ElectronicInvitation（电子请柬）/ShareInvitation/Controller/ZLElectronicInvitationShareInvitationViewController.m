//
//  ZLElectronicInvitationShareInvitationViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationShareInvitationViewController.h"
#import "ZLElectronicInvitationShareInvitationView.h"
#import "ZLElectronicInvitationShareInvitationSelectImage.h"
#import "ZLElectronicInvitationShareInvitationModel.h"
#import "ZLHTTPSessionManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import <UIImageView+AFNetworking.h>

@interface ZLElectronicInvitationShareInvitationViewController ()<ZLElectronicInvitationShareInvitationSelectImageDelegate>

///主视图
@property (nonatomic,weak) ZLElectronicInvitationShareInvitationView *shareInvitationView;
///选择图片
@property (nonatomic,strong) ZLElectronicInvitationShareInvitationSelectImage *selectImageManager;
///持有模型
@property (nonatomic,strong) ZLElectronicInvitationShareInvitationModel *infoModel;

@end

@implementation ZLElectronicInvitationShareInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.shareInvitationView show];
}

#pragma mark - Lazy
- (ZLElectronicInvitationShareInvitationSelectImage *)selectImageManager {
    if (!_selectImageManager) {
        _selectImageManager = [ZLElectronicInvitationShareInvitationSelectImage new];
    }
    return _selectImageManager;
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationShareInvitationView *shareInvitationView = [[ZLElectronicInvitationShareInvitationView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 400.0, self.view.frame.size.width, 400.0)];
    shareInvitationView.sharetime = self.sharetime;
    shareInvitationView.imageUrl = self.imageUrl;
    [self.view addSubview:shareInvitationView];
    self.shareInvitationView = shareInvitationView;
    //消失
    __weak typeof(self)weakSelf = self;
    shareInvitationView.dismissPage = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    //更改图片
    shareInvitationView.changeImage = ^{
        [weakSelf.selectImageManager updateHeadPictureWithDelegate:weakSelf];
    };
    //分享
    shareInvitationView.share = ^(NSInteger index, NSString *title, NSString *content) {
        [weakSelf saveShareDataWithTitle:title Content:content Results:^{
            [weakSelf shareWithIndex:index Title:title Content:content];
        }];
    };
}

- (void)saveShareDataWithTitle:(NSString *)title Content:(NSString *)content Results:(void (^)(void))complete {
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"id"] = self.keyId;
    params[@"token"] = self.token;
    params[@"userid"] = self.userId;
    params[@"sharetitle"] = title;
    params[@"sharecover"] = self.imageUrl;
    params[@"sharedescribe"] = content;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/invitation/saveshare" Params:params POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] intValue]) {
                complete();
            }
        }
    }];
}
- (void)shareWithIndex:(NSInteger)index Title:(NSString *)title Content:(NSString *)content {
    if (!index) {
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
            self.shareInvitationView.errorMessage = @"未安装微信,分享失败！";
            return;
        }
    }else if (index == 1) {
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
            self.shareInvitationView.errorMessage = @"未安装微信,分享失败！";
            return;
        }
    }else if (index == 2) {
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
            self.shareInvitationView.errorMessage = @"未安装QQ,分享失败！";
            return;
        }
    }else if (index == 3) {
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
            self.shareInvitationView.errorMessage = @"未安装QQ,分享失败！";
            return;
        }
    }else {
        NSLog(@"%d",[[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_Sina]);
        if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
            self.shareInvitationView.errorMessage = @"未安装新浪微博,分享失败！";
            return;
        }
    }
    NSArray *array = @[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina)];
    UIImageView *imageView = [UIImageView new];
    [imageView setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UIImage *thumbURL = self.infoModel.imageUrl ? [UIImage imageWithData:self.infoModel.imageData] : imageView.image;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:thumbURL];
    shareObject.webpageUrl = self.htmlUrl;
    messageObject.shareObject = shareObject;
    NSLog(@"\n图片：%@\n标题：%@\n内容：%@\n链接：%@\n平台代号：%@\n",thumbURL,title,content,shareObject.webpageUrl,array[index]);
    __weak typeof(self)weakSelf = self;
    [[UMSocialManager defaultManager] shareToPlatform:[array[index] integerValue] messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            weakSelf.shareInvitationView.errorMessage = @"分享失败！";
        }else {
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                weakSelf.shareInvitationView.errorMessage = @"分享成功！";
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

#pragma mark - ZLElectronicInvitationShareInvitationSelectImageDelegate
-(void)didEndSelectedImageWithImage:(ZLElectronicInvitationShareInvitationSelectImageModel *)imageModel {
    self.shareInvitationView.showHud = YES;
    self.infoModel = [ZLElectronicInvitationShareInvitationModel new];
    self.infoModel.imageData = imageModel.imageData;
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationShareInvitationModel imageUrlWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        if (errorMessage) {
            weakSelf.shareInvitationView.errorMessage = errorMessage;
            return;
        }
        if (!sessionErrorState) {
            weakSelf.shareInvitationView.iconImage = imageModel.image;
            return;
        }
    }];
}

@end
