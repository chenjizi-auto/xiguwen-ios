//
//  ZLSelectBankCardViewController.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/30.
//  Copyright © 2018年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSelectBankCardModel.h"

@interface ZLSelectBankCardViewController : UIViewController

///主键id
@property (nonatomic,strong) NSString *keyId;
///手机号
@property (nonatomic,strong) NSString *starPhone;
///手机号
@property (nonatomic,strong) NSString *phone;
///已经选中的卡
@property (nonatomic,copy) void (^didSelected)(ZLSelectBankCardModel *unitModel);

@end
