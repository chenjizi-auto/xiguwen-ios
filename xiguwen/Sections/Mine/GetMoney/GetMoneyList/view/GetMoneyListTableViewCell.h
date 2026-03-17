//
//  GetMoneyListTableViewCell.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetMoneyListModel.h"

@interface GetMoneyListTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) GetMoneyListModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
