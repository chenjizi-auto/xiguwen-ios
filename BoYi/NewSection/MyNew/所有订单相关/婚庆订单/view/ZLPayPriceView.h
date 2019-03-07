//
//  ZLPayPriceView.h
//  BoYi
//
//  Created by 赵磊 on 2019/3/6.
//  Copyright © 2019 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKeyboardMoneyField.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLPayPriceView : UIView

///是否允许展示第一层
@property (nonatomic,unsafe_unretained) BOOL allowShow;

///弹窗
@property (weak, nonatomic) IBOutlet UIView *alertView;
///
@property (weak, nonatomic) IBOutlet UIButton *online;
///输入金额
@property (weak, nonatomic) IBOutlet ZLKeyboardMoneyField *priceTf;
///线上线下背景块
@property (weak, nonatomic) IBOutlet UIView *topBgView;
///事件按钮
@property (weak, nonatomic) IBOutlet UIButton *payButton;
///未结金额
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
///支付
@property (nonatomic,copy) void (^payAction)(void);
///线下支付
@property (nonatomic,copy) void (^offlinePay)(void);

@end

NS_ASSUME_NONNULL_END
