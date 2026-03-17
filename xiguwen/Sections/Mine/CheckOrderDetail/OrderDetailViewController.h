//
//  OrderDetailViewController.h
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface OrderDetailViewController : FatherViewController

@property (assign,nonatomic) NSInteger orderId;
@end


@interface OrderDetailModel : NSObject

@property (nonatomic, copy) NSString *refund;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *bizName;

@property (nonatomic, assign) CGFloat price;

@end
