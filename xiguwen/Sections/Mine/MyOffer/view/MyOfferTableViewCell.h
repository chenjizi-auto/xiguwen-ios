//
//  MyOfferTableViewCell.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOfferModel.h"

@interface MyOfferTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MyOfferModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *eventBtn;
@end
