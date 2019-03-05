//
//  ZLWithdrawalViewController.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/29.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLWithdrawalViewController : UIViewController

///提现
@property (nonatomic,copy) void (^withdrawalResults)(void);

@end
