//
//  NewScheduleViewController.h
//  BoYi
//
//  Created by Chen on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "ScheduleModel.h"

@interface NewScheduleViewController : FatherViewController

@property (strong,nonatomic) ScheduleModelWithDate *model;
@property (strong,nonatomic) RACSubject *refreshDataSubject;

@end

