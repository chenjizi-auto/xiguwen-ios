//
//  MyBanksViewController.h
//  BoYi
//
//  Created by Chen on 2017/9/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface MyBanksViewController : FatherViewController

#pragma mark- as

#pragma mark- model
@property (assign,nonatomic) BOOL isChoose;

@property (strong,nonatomic) RACSubject *chooseBankSubject;
#pragma mark- view

#pragma mark- api

@end
