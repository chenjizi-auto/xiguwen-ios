//
//  CwShareManager.m
//  ZeroRead
//
//  Created by Chen on 2017/3/8.
//  Copyright © 2017年 pan wei. All rights reserved.
//

#import "CwShareManager.h"
#import <WXApi.h>

@implementation CwShareManager
+ (CwShareManager *)sharedManager
{
    static CwShareManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

+ (void)shareWebPageToPlatformWithUrl:(NSString *)url image:(id)image title:(NSString *)title descr:(NSString *)descr vc:(UIViewController *)vc completion:(void (^)(id data, NSError *error))completion
{
    //友盟埋点
//    [MobClick event:@"share_btn"];
    
    //创建网页内容对象
    if ([image isKindOfClass:[UIImage class]]) {
        UIImage *imagewu = image;
        [self shareFollowWebPageToPlatformWithUrl:url image:imagewu title:title descr:descr vc:vc completion:completion];
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString* thumbURL =  image;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:thumbURL]];
        UIImage *imagewu = [UIImage imageWithData:data]; // 取得图片
        dispatch_async(dispatch_get_main_queue(), ^{
            [self shareFollowWebPageToPlatformWithUrl:url image:imagewu title:title descr:descr vc:vc completion:completion];
        });
    });
}

+ (void)shareFollowWebPageToPlatformWithUrl:(NSString *)url image:(UIImage *)image title:(NSString *)title descr:(NSString *)descr vc:(UIViewController *)vc completion:(void (^)(id data, NSError *error))completion
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = url;//[NSString stringWithFormat:@"%@",@""];//url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //    //显示分享面板
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//
//    }];
    
    [CwShareManager shareObject:messageObject vc:vc];
}


//+ (void)shareWebPageToPlatformWithData:(Momentslist *)data {
//
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    if (data.attaches.count > 0) {
//        //图片
//        if (data.attaches[0].type == 1) {
//            //
//            UMShareImageObject *object = [UMShareImageObject shareObjectWithTitle:data.content
//                                                                           descr:data.content
//                                                                       thumImage:RIGHT_URL(data.attaches[0].url)];
//            object.shareImage = [NSString stringWithFormat:@"https://oss.40yue.com/%@",data.attaches[0].url];
//
//            //文本
//            messageObject.title = data.content;
//            messageObject.text  = data.content;
//            messageObject.shareObject = object;
//
//        } else {
//            UMShareVideoObject *object = [UMShareVideoObject shareObjectWithTitle:data.content
//                                                                           descr:data.content
//                                                                       thumImage:RIGHT_URL(data.attaches[0].firstFrame)];
//            object.videoUrl = RIGHT_URL(data.attaches[0].url);
//            //文本
//            messageObject.title = data.content;
//            messageObject.text  = data.content;
//            messageObject.shareObject = object;
//
//        }
//    } else {
//        //文本
//        messageObject.title = data.content;
//        messageObject.text  = data.content;
//    }
//
//
//    [CwShareManager shareObject:messageObject vc:nil];
//}




+ (void)shareObject:(UMSocialMessageObject *)messageObject vc:(UIViewController *)vc {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina)]];
//    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_WechatSession withPlatformIcon:[UIImage imageNamed:@"微信登录-1"] withPlatformName:@"微信好友"];
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        //调用分享接口
//        if (platformType == UMSocialPlatformType_WechatTimeLine || platformType == UMSocialPlatformType_WechatSession) {
//            [self share:platformType Object:messageObject.shareObject vc:vc];
//            return;
//        }
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
            if (error) {
                DLog(@"************Share fail with error %@*********",error);
                [NavigateManager showMessage:@"分享失败！"];
            }else {
                
                //                [CwShareManager shareSuccess:2];
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    [NavigateManager showMessage:@"分享成功！"];
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
//            if(completion) {
//                completion(data,error);
//            }
        }];
        
    }];

}

// 劫持微信分享，使用原生SDK调用
+ (void)share:(UMSocialPlatformType)type Object:(UMShareWebpageObject *)messageObject vc:(UIViewController *)vc {
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = messageObject.webpageUrl;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = messageObject.title;
    message.description = messageObject.descr;
    [message setThumbImage:[UIImage imageNamed:@"微信登录-1"]];
    message.mediaObject = webpageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        NSLog(@"success = %d", success);
    }];
}


/**
 分享成功 调用接口

 @param codeId codeId
 */
+ (void)shareSuccess:(NSInteger)codeId {
    [[RequestManager sharedManager] PostUrl:URL_SHARE_CODE
                                     loding:nil
                                        dic:@{@"codeId":@(codeId)}
                              Authorization:nil
                                    success:^(NSURLSessionDataTask *task, id response) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


@end
