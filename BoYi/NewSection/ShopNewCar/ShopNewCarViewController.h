//
//  ShopNewCarViewController.h
//  BoYi
//
//  Created by heng on 2018/1/6.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface ShopNewCarViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isQuanxuan;
@property (weak, nonatomic) IBOutlet UIView *vieww;
@property (weak, nonatomic) IBOutlet UILabel *zongMoney;
@property (weak, nonatomic) IBOutlet UIButton *quanxuanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *isGouImage;

@property (nonatomic, assign) BOOL isGiabianheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end
