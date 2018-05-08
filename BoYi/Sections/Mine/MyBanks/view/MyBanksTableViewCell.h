//
//  MyBanksTableViewCell.h
//  BoYi
//
//  Created by Chen on 2017/9/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetMoneyViewController.h"

@interface MyBanksTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) GetMoneyModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *bankNo;

@end
