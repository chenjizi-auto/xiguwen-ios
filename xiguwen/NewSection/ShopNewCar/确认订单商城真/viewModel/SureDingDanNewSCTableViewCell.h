//
//  SureDingDanNewSCTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sureDingdanSCmodel.h"
@interface SureDingDanNewSCTableViewCell : UITableViewCell


@property (strong,nonatomic) GoodsSC *modelsc;

// xib

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *priceD;

@property (weak, nonatomic) IBOutlet UILabel *number;
@end
