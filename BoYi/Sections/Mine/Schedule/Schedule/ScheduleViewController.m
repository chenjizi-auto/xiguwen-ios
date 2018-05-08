//
//  ScheduleViewController.m
//  BoYi
//
//  Created by Chen on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleViewModel.h"
#import <FSCalendar.h>
#import "LunarFormatter.h"
#import "OrderAlertView.h"
#import "NewScheduleViewController.h"

@interface ScheduleViewController ()<FSCalendarDataSource,FSCalendarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ScheduleViewModel *viewModel;
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet UILabel *suit;
@property (weak, nonatomic) IBOutlet UILabel *avoid;
@property (weak, nonatomic) IBOutlet UIView *scheleSubview;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
@property (strong, nonatomic) LunarFormatter *lunarFormatter;
@property (strong,nonatomic) NSMutableArray <ScheduleModel *>*ScheduleArray;
@property (assign, nonatomic) BOOL isAfterNoon;
@property (assign, nonatomic) BOOL isCloseSchedule;
@end

@implementation ScheduleViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"日程档期";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"新建" image:nil];
    
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    self.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    _lunarFormatter = [[LunarFormatter alloc] init];
    self.calendar.dataSource = self;
    self.calendar.delegate   = self;
    
    
    @weakify(self);
    [self.viewModel.getCalendarCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if ([x[@"error_code"] integerValue] == 0) {
            self.suit.text = x[@"result"][@"data"][@"suit"];
            self.avoid.text = x[@"result"][@"data"][@"avoid"];
        }
    }];
    
    //档期
    [self.viewModel.findScheduleCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.ScheduleArray = [ScheduleModel mj_objectArrayWithKeyValuesArray:x].mutableCopy;
        [self showSchele:!self.isAfterNoon];
    }];
    //关闭档期
    [self.viewModel.udpateStatusByIdCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
//        [self.switchControl setOn:!self.switchControl.isOn];
//        [self.viewModel.findScheduleCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
//                                                      @"startTime":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string,
//                                                      @"endTime":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string}];
        [self.switchControl setOn:!self.isCloseSchedule];
        for (ScheduleModel *model in self.ScheduleArray) {
            //判断是不是选择的一天
            if ([[NSDate dateWithTimeIntervalSince1970:model.scheduleDate.millis / 1000] fs_isEqualToDateForDay:self.calendar.selectedDate]) {
                NSInteger type = self.isAfterNoon ? 2 : 1;
                if (model.scheduleType == type) {
                    model.status = self.isCloseSchedule ? -1 : 1;
                }
            }
        }
        
        
    }];
    //关闭档期
    [self.viewModel.insertStatusByIdCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
//        [self.switchControl setOn:!self.switchControl.isOn];
//        [self.viewModel.findScheduleCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
//                                                      @"startTime":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string,
//                                                      @"endTime":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string}];
        [self.switchControl setOn:!self.isCloseSchedule];
        [self.ScheduleArray addObject:[ScheduleModel mj_objectWithKeyValues:x]];
    }];
    
    [self setupTableView];
    
    [self.table.mj_header beginRefreshing];
    
    
    //日程点击
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        
        
        @strongify(self);
        
        ScheduleModelWithDate *model = x[@"x"];
        
        if ([x[@"isEdit"] boolValue]) {
            
            NewScheduleViewController *vc = [[NewScheduleViewController alloc] init];
            vc.model = model;
            @weakify(self);
            [vc.refreshDataSubject subscribeNext:^(id  _Nullable x) {
                
                @strongify(self);
                //传入参数 进行刷新
                [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                                 @"scheduledate":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string,
                                                                 @"scheduletime":@"",
                                                                 @"username":@""}];
            }];
            [self pushToNextVCWithNextVC:vc];
            
            
        } else {
            //取消订单  未付款
            __weak typeof(self) weakSelf = self;
            [OrderAlertView showInView:self.view
                                   top:@"您真的要删除吗!"
                                bottom:nil
                                 block:^(NSInteger index) {
                                     //完成
                                     [[[RequestManager sharedManager] RACRequestUrl:URL_deleteScheduleByid
                                                                            method:GET
                                                                            loding:@""
                                                                               dic:@{@"id":@(model.id)}] subscribeNext:^(id  _Nullable x) {
                                         //传入参数 进行刷新
                                         [weakSelf.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                                                      @"scheduledate":weakSelf.calendar.selectedDate ? weakSelf.calendar.selectedDate.fs_string : weakSelf.calendar.today.fs_string,
                                                                                      @"scheduletime":@"",
                                                                                      @"username":@""}];
                                     }];
                                 }];

        }
    }];
    
    
}


#pragma mark - 点击事件
- (void)respondsToRightBtn {
    
    NewScheduleViewController *vc = [[NewScheduleViewController alloc] init];
    
    @weakify(self);
    [vc.refreshDataSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                     @"scheduledate":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string,
                                                     @"scheduletime":@"",
                                                     @"username":@""}];
    }];
    [self pushToNextVCWithNextVC:vc];
}
- (IBAction)ClickBtn:(UIButton *)sender {
    UIView *view = sender.superview;
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[view viewWithTag:100 + i];
        [btn setBackgroundColor:RGBA(102, 102, 102, 1)];
    }
    
    [sender setBackgroundColor:MAINCOLOR];
    self.isAfterNoon = sender.tag == 101;
    if (self.ScheduleArray) {
        [self showSchele:!self.isAfterNoon];
    }
    
}

/**
 点击关闭
 */
- (IBAction)ClickSwitch:(UIButton *)sender {
    
    //关闭接单状态.判断是否可以接单
    if (self.switchControl.isOn) {
        BOOL isShow = NO;
        
        for (ScheduleModel *model in self.ScheduleArray) {
            //判断是不是选择的一天
            if ([[NSDate dateWithTimeIntervalSince1970:model.scheduleDate.millis / 1000] fs_isEqualToDateForDay:self.calendar.selectedDate]) {
                //午宴
                if (!self.isAfterNoon && model.scheduleType == 1 && model.status != 1) {
                    isShow = YES;
                } else if (self.isAfterNoon && model.scheduleType == 2 && model.status != 1) {
                    //晚宴
                    isShow = YES;
                }
            }
            
        }
        if (isShow) {
            [NavigateManager showMessage:@"档期已满,无法接单"];
            return;
        }

    }
    
    
    self.isCloseSchedule = self.switchControl.isOn;
    BOOL isHave = NO;
    for (ScheduleModel *model in self.ScheduleArray) {
        
        //判断是不是选择的一天
        if ([[NSDate dateWithTimeIntervalSince1970:model.scheduleDate.millis / 1000] fs_isEqualToDateForDay:self.calendar.selectedDate]) {
            NSInteger type = self.isAfterNoon ? 2 : 1;
            if (model.scheduleType == type) {
                isHave = YES;
                
                //档期状态修改接口   修改为-1
//                [self.viewModel.udpateStatusByIdCommand execute:@{@"id":@(model.id),
//                                                                  @"scheduleDate":self.isAfterNoon ? @"2":@"1",
//                                                                  
//                                                                  @"status":self.switchControl.isOn ? @-1 : @1}];
                //关闭接单
                [self.viewModel.udpateStatusByIdCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
                                                                  @"status":self.switchControl.isOn ? @-1 : @1,
                                                                  @"scheduleDate":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string,
                                                                  @"scheduleType":self.isAfterNoon ? @2 : @1}];
            }
            
        }
    }
    
        if (!isHave) {
            //没有档期。调用其他接口
            //关闭接单
            [self.viewModel.insertStatusByIdCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                              @"status":self.switchControl.isOn ? @-1 : @1,
                                                              @"scheduleDate":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string,
                                                              @"scheduleType":self.isAfterNoon ? @2 : @1}];
        }
        
        
    
    
    
}

#pragma mark - public api


#pragma mark - private api


/**
 显示档期

 @param isLuncher 是不是午宴
 */
- (void)showSchele:(BOOL)isLuncher {
    
    BOOL isShow = NO;
    for (ScheduleModel *model in self.ScheduleArray) {
        
        NSDate *selectDate = self.calendar.selectedDate ? self.calendar.selectedDate : self.calendar.today;
        //判断是不是选择的一天
        if ([[NSDate dateWithTimeIntervalSince1970:model.scheduleDate.millis / 1000] fs_isEqualToDateForDay:selectDate]) {
            //午宴
            if (isLuncher && model.scheduleType == 1 && model.status == 1) {
                isShow = YES;
            } else if (!isLuncher && model.scheduleType == 2 && model.status == 1) {
                //晚宴
                isShow = YES;
            }
        }
    
    }
    [self.switchControl setOn:isShow];
    [self.calendar reloadData];
}



//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ScheduleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ScheduleTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"ScheduleTableViewHeaderFooterView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ScheduleTableViewHeaderFooterView"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        
//        self.curPage = 1;
        [self loadData];
        [self loadSchedule];
        
//        NSDate *date = self.calendar.currentPage.fs_lastDayOfMonth;
        
    
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:YES];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    
//                    self.curPage ++;
//                    
//                    if (self.statusFlag != 0) {
//                        //传入参数 进行刷新
//                        [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
//                                                                     @"curPage":@(self.curPage),
//                                                                     @"pageSize":@10,
//                                                                     @"statusFlag":@(self.statusFlag)}];
//                    } else {
//                        //传入参数 进行刷新
//                        [self.viewModel.refreshDataCommand execute:@{@"userId":@([UserData sharedManager].userInfoModel.id),
//                                                                     @"curPage":@(self.curPage),
//                                                                     @"pageSize":@10}];
//                    }
//                }];
//            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//            
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//            
//        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //处理异常状态
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
//        } else if (self.table.mj_footer.isRefreshing) {
//            [self.table.mj_footer endRefreshing];
        }
    }];
}
- (void)loadData {
    //传入参数 进行刷新
    [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                 @"scheduledate":self.calendar.selectedDate ? self.calendar.selectedDate.fs_string : self.calendar.today.fs_string,
                                                 @"scheduletime":@"",
                                                 @"username":@""}];
    [self.viewModel.getCalendarCommand execute:self.calendar.selectedDate ? [self.calendar.selectedDate fs_stringWithFormat:@"yyyy-M-d"] : [self.calendar.today fs_stringWithFormat:@"yyyy-M-d"]];
    
}
- (void)loadSchedule {
    NSDate *date = [self.calendar.currentPage fs_lastDayOfMonth];
    [self.viewModel.findScheduleCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id),
                                                  @"startTime":self.calendar.currentPage.fs_string,
                                                  @"endTime":date.fs_string}];
}

//初始化viewModel
- (ScheduleViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ScheduleViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark - fs datasource
#pragma mark - FSCalendarDataSource

//- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
//{
//    return self.minimumDate;
//}
//
//- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
//{
//    return self.maximumDate;
//}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
//    if (self.showsEvents) {
//        EKEvent *event = [self eventsForDate:date].firstObject;
//        if (event) {
//            return event.title;
//        }
//    }
//    if (self.showsLunar) {
        return [self.lunarFormatter stringFromDate:date];
//    }
    return nil;
}


#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
//    NSLog(@"did select %@",[self.dateFormatter stringFromDate:date]);
    [self loadData];
    [self showSchele:!self.isAfterNoon];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    //切换月份的时候调用
//    NSLog(@"did change page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
    [self loadSchedule];
    
}
//- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
//{
//    NSInteger eventCount = 0;
//    for (ScheduleModel *model in self.ScheduleArray) {
//    
//        //判断是不是选择的一天
//        if ([[NSDate dateWithTimeIntervalSince1970:model.scheduleDate.millis / 1000] fs_isEqualToDateForDay:date]) {
//            //午宴
//            if (model.scheduleType == 1 && model.status == -1) {
//                eventCount ++;
//            } else if (model.scheduleType == 2 && model.status == -1) {
//                
//                eventCount ++;
//            }
//        }
//        
//    }
//    if (eventCount == 2) {
//        return 1;
//    }
//
//    return 0;
//}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSInteger eventCount = 0;
    for (ScheduleModel *model in self.ScheduleArray) {
        
        //判断是不是选择的一天
        if ([[NSDate dateWithTimeIntervalSince1970:model.scheduleDate.millis / 1000] fs_isEqualToDateForDay:date]) {
            //午宴
            if (model.scheduleType == 1 && model.status == 1) {
                eventCount ++;
//            } else if (model.scheduleType == 2 && model.status == 1) {
//
//                eventCount ++;
            }
        }
        
    }
    if (eventCount == 1) {
        return RGBA(20, 188, 159, 1);
    }

    return nil;
}

//- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
//{
//    if (!self.showsEvents) return 0;
//    if (!self.events) return 0;
//    NSArray<EKEvent *> *events = [self eventsForDate:date];
//    return events.count;
//}

//- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
//{
//    if (!self.showsEvents) return nil;
//    if (!self.events) return nil;
//    NSArray<EKEvent *> *events = [self eventsForDate:date];
//    NSMutableArray<UIColor *> *colors = [NSMutableArray arrayWithCapacity:events.count];
//    [events enumerateObjectsUsingBlock:^(EKEvent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [colors addObject:[UIColor colorWithCGColor:obj.calendar.CGColor]];
//    }];
//    return colors.copy;
//}


@end
