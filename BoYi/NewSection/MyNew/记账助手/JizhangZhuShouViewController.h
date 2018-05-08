//
//  JizhangZhuShouViewController.h
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface JizhangZhuShouViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api

@property (weak, nonatomic) IBOutlet UIButton *yueBtn;

@property (weak, nonatomic) IBOutlet UILabel *zhichuTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouruTitleLabel;



@property (weak, nonatomic) IBOutlet UILabel *shouru;
@property (weak, nonatomic) IBOutlet UILabel *yuelabel;

@property (weak, nonatomic) IBOutlet UILabel *zhichu;
@end
