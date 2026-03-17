//
//  ShopOrderTableViewFooter.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

@interface ShopOrderTableViewFooter : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *orderMoney;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *centerBtn;

@property (weak, nonatomic) IBOutlet UIImageView *completeImage;
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;
@property (nonatomic,strong) MyOrderModel *model;

@end
