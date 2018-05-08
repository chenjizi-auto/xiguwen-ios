//
//  NewThreeTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "ScheduleModel.h"

@interface NewThreeTableViewCell : UITableViewCell<FSCalendarDelegate,FSCalendarDataSource>
@property (weak, nonatomic) IBOutlet FSCalendar *dateView;
@property (weak, nonatomic) IBOutlet UILabel *contentWords;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic)NSString *userId;

@property (strong,nonatomic)NSMutableArray *dangqiArray;
@end
