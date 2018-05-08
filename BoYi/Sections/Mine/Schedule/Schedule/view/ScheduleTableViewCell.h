//
//  ScheduleTableViewCell.h
//  BoYi
//
//  Created by Chen on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"

@interface ScheduleTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) ScheduleModelWithDate *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@end
