//
//  HunqingJiedanSamllTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunQinOrderModel.h"
@interface HunqingJiedanSamllTableViewCell : UITableViewCell
//属性
@property (strong,nonatomic) Hunqinordernew *model;

// xib
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *shangjiaName;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *isMoneyType;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *priceDing;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UILabel *gongjiNumber;
@property (weak, nonatomic) IBOutlet UILabel *xiaoji;
@property (weak, nonatomic) IBOutlet UILabel *shifukuan;
@property (weak, nonatomic) IBOutlet UILabel *dingTitle;
@property (weak, nonatomic) IBOutlet UILabel *dikou;
@end
