//
//  NewThreeTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewThreeTableViewCell.h"

@implementation NewThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 实例化NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 获取当前日期
    NSString *currentDateString = [formatter stringFromDate:[NSDate new]];
    
    self.time.text = currentDateString;
    self.dateView.delegate = self;
    self.dangqiArray = [NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark FSCalendarDelegate
//选中某一天进行相关操作
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    
    self.time.text = self.dateView.selectedDate.fs_string;
    [[RequestManager sharedManager] requestUrl:URL_findScheduleByUserIdDate
                                        method:POST
                                        loding:@""
                                           dic:@{@"userid":self.userId,//@([UserData sharedManager].userInfoModel.id),
                                                 @"startTime":self.dateView.selectedDate ? self.dateView.selectedDate.fs_string : self.dateView.today.fs_string,
                                                 @"endTime":self.dateView.selectedDate ? self.dateView.selectedDate.fs_string : self.dateView.today.fs_string}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           
                                           [NavigateManager hiddenLoadingMessage];
                                           if ([response[@"status"] integerValue] == 200) {
                                               [self.dangqiArray removeAllObjects];
                                               [self.dangqiArray addObjectsFromArray:[ScheduleModel mj_objectArrayWithKeyValuesArray:response[@"r"]]];
                                               
                                               NSString *wuStr = @"";
                                               NSString *wanStr = @"";
                                               NSString *douStr = @"";
                                               if (self.dangqiArray.count == 0) {
                                                   self.contentWords.text = @"当前日期可订";
                                               }else if (self.dangqiArray.count == 1){
                                                   
                                                   ScheduleModel *model = self.dangqiArray[0];
                                                   if (model.scheduleType == 1) {
                                                       if (model.status == -1) {
                                                           wuStr = @"午宴可订";
                                                       }
                                                       if (model.status == 1) {
                                                           wuStr = @"午宴已订";
                                                       }
                                                   }else {
                                                       if (model.status == -1) {
                                                           wanStr = @"晚宴可订";
                                                       }
                                                       if (model.status == 1) {
                                                           wanStr = @"晚宴已订";
                                                       }
                                                   }
                                                   if (![wanStr isEqualToString:@""] && ![wuStr isEqualToString:@""]) {
                                                       douStr = @",";
                                                   }
                                                   self.contentWords.text = [NSString stringWithFormat:@"%@%@%@",wuStr,douStr,wanStr];
                                               }else if (self.dangqiArray.count == 2){
                                                   
                                                   for (int i = 0; i < 2; i ++) {
                                                       ScheduleModel *model = self.dangqiArray[i];
                                                       if (model.scheduleType == 1) {
                                                           if (model.status == -1) {
                                                               wuStr = @"午宴可订";
                                                           }
                                                           if (model.status == 1) {
                                                               wuStr = @"午宴已订";
                                                           }
                                                       }else {
                                                           if (model.status == -1) {
                                                               wanStr = @"晚宴可订";
                                                           }
                                                           if (model.status == 1) {
                                                               wanStr = @"晚宴已订";
                                                           }
                                                       }
                                                       if (![wanStr isEqualToString:@""] && ![wuStr isEqualToString:@""]) {
                                                           douStr = @",";
                                                       }
                                                       self.contentWords.text = [NSString stringWithFormat:@"%@%@%@",wuStr,douStr,wanStr];
                                                   }
                                               }else {
                                                   for (int i = 0; i < self.dangqiArray.count; i ++) {
                                                       
                                                       ScheduleModel *model = self.dangqiArray[i];
                                                       if (model.scheduleType == 1) {
                                                           if (model.status == -1) {
                                                               wuStr = @"午宴可订";
                                                           }
                                                           if (model.status == 1) {
                                                               wuStr = @"午宴已订";
                                                               break;
                                                           }
                                                       }else {
                                                           if (model.status == -1) {
                                                               wanStr = @"晚宴可订";
                                                           }
                                                           if (model.status == 1) {
                                                               wanStr = @"晚宴已订";
                                                               break;
                                                           }
                                                       }
                                                       if (![wanStr isEqualToString:@""] && ![wuStr isEqualToString:@""]) {
                                                           douStr = @",";
                                                       }
                                                       self.contentWords.text = [NSString stringWithFormat:@"%@%@%@",wuStr,douStr,wanStr];
                                                   }
                                               }
                                           }

                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"查询失败"];
                                           
                                       }];
    
}
//取消选中的日期进行相关操作
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date {
    //...
    NSLog(@"%@",date);
}


@end
