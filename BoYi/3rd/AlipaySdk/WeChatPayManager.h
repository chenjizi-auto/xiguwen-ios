//
//  WeChatPayManager.h
//  differennt
//
//  Created by bodecn on 15/12/31.
//  Copyright © 2015年 bodecn. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "Order.h"
#import "UPPaymentControl.h"
#import <AlipaySDK/AlipaySDK.h>

@interface WeChatPayManager : NSObject

/*
 type   1为银联  2为支付宝
*/
+ (void)payWithType:(NSInteger)type info:(id)info vc:(id)vc block:(void (^)(NSDictionary *response))block;

@end
