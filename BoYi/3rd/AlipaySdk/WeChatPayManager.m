//
//  WeChatPayManager.m
//  differennt
//
//  Created by bodecn on 15/12/31.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "WeChatPayManager.h"

@implementation WeChatPayManager


+ (void)payWithType:(NSInteger)type info:(id )info vc:(id)vc block:(void (^)(NSDictionary *))block {
    
    
    //    [UserData sharedManager].userInfoModel.isWaitingForPay = YES;
    
    if (type == 2) {
        //微信
        [WeChatPayManager wechat:info[@"prepayid"]
                       partnerId:info[@"partnerid"]
                        nonceStr:info[@"noncestr"]
                       timeStamp:[info[@"timestamp"] intValue]
                         package:info[@"package"]
                            sign:info[@"sign"]];
        
        
    } else if (type == 1) {
        
        //支付宝
        
        [WeChatPayManager AlipayWithGenerateTradeNO:info callBackData:block];
    } else if (type == 3) {
        // 银联
        [[UPPaymentControl defaultControl] startPay:info
                                         fromScheme:@"boyi028"
                                               mode:@"00"
                                     viewController:vc];
    }
}








+ (void)AlipayWithGenerateTradeNO:(NSString *)orderString
                     callBackData:(void (^)(NSDictionary *response))callBackData {
    
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    NSString *appScheme = @"boyi028";
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:callBackData];
    
    
    //        DLog(@"%@",resultDic[@"memo"]);
    //        /**
    //         *  回调
    //         */
    //        callBackData(resultDic);
    //        DLog(@"%@",resultDic);
    //
    //
    //        switch ([[resultDic objectForKey:@"resultStatus"] integerValue]) {
    //            case 9000:
    //            {
    //                //付款成功
    //            }
    //                break;
    //            case 6001:
    //            {
    //                //用户中途取消  去订单详情
    //                [NavigateManager showMessage:@"用户中途取消"];
    //            }
    //                break;
    //            case 6002:
    //            {
    //                //网络连接错误
    //                [NavigateManager showMessage:@"网络连接错误"];
    //
    //            }
    //                break;
    //            case 4000:
    //            {
    //                //订单支付失败
    //                [NavigateManager showMessage:@"订单支付失败"];
    //            }
    //                break;
    //            case 8000:
    //            {
    //                //正在处理中
    //                [NavigateManager showMessage:@"正在处理中"];
    //            }
    //                break;
    //            default:
    //                break;
    //        }
    //
    //
    //    }];
    
}

+ (void)wechat:(NSString*)prepayId
     partnerId:(NSString *)partnerId
      nonceStr:(NSString *)nonceStr
     timeStamp:(UInt32)timeStamp
       package:(NSString *)package
          sign:(NSString *)sign{
    
    
    
    //调起微信支付
    
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = partnerId;
    req.prepayId            = prepayId;
    req.nonceStr            = nonceStr;
    req.timeStamp           = timeStamp;
    req.package             = package;
    req.sign                = sign;
    [WXApi sendReq:req completion:^(BOOL success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WECHAT_PAY_RESULT_NOTIFACATION object:[NSNumber numberWithInt:success ? 0 : -3]];
    }];
    
    
}


@end
