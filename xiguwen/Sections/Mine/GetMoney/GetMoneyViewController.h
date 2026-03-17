//
//  GetMoneyViewController.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface GetMoneyViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api

@end
@interface GetMoneyModel : NSObject

@property (nonatomic, copy) NSString *cardno;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *cardname;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *cardnumber;

@end
