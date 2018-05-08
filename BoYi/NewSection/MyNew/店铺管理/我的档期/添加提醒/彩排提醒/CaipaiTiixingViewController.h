//
//  CaipaiTiixingViewController.h
//  BoYi
//
//  Created by heng on 2018/1/18.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "MyDangQiModel.h"

@interface CaipaiTiixingViewController : FatherViewController

// 回调提醒数组
@property (nonatomic, copy) void(^onDidComplete)(NSMutableArray *remindArray);

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api

@end
