//
//  ZLPayPriceView.h
//  BoYi
//
//  Created by 赵磊 on 2019/3/6.
//  Copyright © 2019 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLPayPriceView : UIView

///弹窗
@property (weak, nonatomic) IBOutlet UIView *alertView;
///输入金额
@property (weak, nonatomic) IBOutlet UITextField *priceTf;
///未结金额
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
///支付
@property (nonatomic,weak) void (^payAction)(void);

@end

NS_ASSUME_NONNULL_END
