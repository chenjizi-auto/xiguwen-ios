//
//  ChoeseCarIDViewController.h
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "BankCardModel.h"

@interface ChoeseCarIDViewController : FatherViewController
@property (nonatomic, strong) BankCardModel *model;
@property (nonatomic, copy) void(^onSelectedBank)(BankCardModel *model);

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api

@end
