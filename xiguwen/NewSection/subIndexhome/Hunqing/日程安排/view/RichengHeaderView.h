//
//  RichengHeaderView.h
//  BoYi
//
//  Created by heng on 2018/1/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FSCalendar.h>

@interface RichengHeaderView : UIView<FSCalendarDataSource,FSCalendarDelegate>
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@end
