//
//  ZLKeyboardPayPassword.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/8/31.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLKeyboardPayPassword : UIView

///处理结果
@property (nonatomic,copy) void (^results)(NSString *payPassword);

///展示
- (void)show;
///关闭
- (void)close;
///清除支付密码
- (void)clearPayPassword;

@end
