//
//  HunQinOrderTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/13.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunQinOrderModel.h"

@interface HunQinOrderTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Hunqinordernew *model;

// xib
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *shangjiaName;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *isMoneyType;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *priceDing;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UILabel *gongjiNumber;
@property (weak, nonatomic) IBOutlet UILabel *xiaoji;
@property (weak, nonatomic) IBOutlet UILabel *shifukuan;
@property (weak, nonatomic) IBOutlet UILabel *shengyuTime;
@property (weak, nonatomic) IBOutlet UILabel *timeTitle;
@property (weak, nonatomic) IBOutlet UIView *isYinCangView;
@property (weak, nonatomic) IBOutlet UILabel *dintitle;

@property (weak, nonatomic) IBOutlet UILabel *tuikuanTitle;
@property (weak, nonatomic) IBOutlet UILabel *dikou;

@end
