//
//  ChangeJiageViewController.h
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "HunQinOrderModel.h"
@interface ChangeJiageViewController : FatherViewController
@property (assign,nonatomic) NSInteger id;
@property (nonatomic,nonatomic) Hunqinordernew *model;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *isMoneyType;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *priceDing;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UITextField *changeDingJing;
@property (weak, nonatomic) IBOutlet UIView *viewType;
@property (weak, nonatomic) IBOutlet UILabel *tiename;

@property (weak, nonatomic) IBOutlet UITextField *changeDJ;
@end
