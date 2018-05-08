//
//  ShopOrderTableViewCell.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

@interface ShopOrderTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Detailinfobvolist *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *Cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *allPrice;
@property (weak, nonatomic) IBOutlet UILabel *offerPrice;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end
