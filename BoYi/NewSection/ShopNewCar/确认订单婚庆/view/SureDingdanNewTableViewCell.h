//
//  SureDingdanNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SureDingdanNewModel.h"
@interface SureDingdanNewTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Goodssure *model;


// xib

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *isMoneyType;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *priceDing;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end
