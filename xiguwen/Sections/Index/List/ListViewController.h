//
//  ListViewController.h
//  BoYi
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface ListViewController : FatherViewController

#pragma mark- as

#pragma mark- model
@property (strong,nonatomic) NSString *titleName;
#pragma mark- view

#pragma mark- api

/**
 是否是rows key列表
 */
@property (nonatomic, assign) BOOL isRows;
@end
