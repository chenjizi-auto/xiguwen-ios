//
//  ShenqingTuiQianViewController.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "UItextViewWithPlaceHloder.h"
#import "HunQinOrderModel.h"

@interface ShenqingTuiQianViewController : FatherViewController
@property (strong,nonatomic)Hunqinordernew *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *isMoneyType;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *priceDing;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *yuanyin;
@property (weak, nonatomic) IBOutlet UILabel *shijifukuan;
@property (weak, nonatomic) IBOutlet UITextField *xiangtuijinge;


@end
