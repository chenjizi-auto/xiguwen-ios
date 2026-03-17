//
//  NewScheduleViewController.m
//  BoYi
//
//  Created by Chen on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewScheduleViewController.h"
#import "CwDatePiker.h"
#import "UItextViewWithPlaceHloder.h"

@interface NewScheduleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *content;


@property (weak, nonatomic) IBOutlet UIView *tabSubview;
@property (strong,nonatomic) NSString *scheduletab;
@property (assign,nonatomic) BOOL isChoose;
@end

@implementation NewScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = self.model ? @"编辑日程" : @"新建日程";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
    self.content.placeholder = @"请输入内容";
    self.content.placeholderTextColor = RGBA(242, 242, 242, 1);
    [self loadDataWithModel];
    self.date.delegate = self;
    self.date.inputAccessoryView = [self addToolbar];
    self.time.delegate = self;
    self.time.inputAccessoryView = [self addToolbar];
    self.name.delegate = self;
    self.name.inputAccessoryView = [self addToolbar];
    self.phone.delegate = self;
    self.phone.inputAccessoryView = [self addToolbar];
    self.content.delegate = self;
    self.content.inputAccessoryView = [self addToolbar];
}


- (void)loadDataWithModel {
    
    self.date.text = self.model.scheduledate;
    self.time.text = self.model.scheduletime;
    if (self.model.scheduletab.length > 0) {
        for (int i = 0; i < 5; i++) {
            
            UIButton *btn = [self.tabSubview viewWithTag:100 + i];
            if ([self.model.scheduletab isEqualToString:[btn titleForState:UIControlStateNormal]]) {
                [btn setBackgroundColor:MAINCOLOR];
            } else {
                [btn setBackgroundColor:RGBA(102, 102, 102, 1)];
            }
        }
    }
    self.scheduletab = self.model.scheduletab;
    self.name.text = self.model.username;
    self.phone.text = self.model.tel;
    self.content.text = self.model.remark;
    
}

/**
 右边按钮事件
 */
- (void)respondsToRightBtn {
    
    if (!self.date.text) {
        [NavigateManager showMessage:@"请选择日期"];
        return;
    }
//    if (!self.time.text) {
//        [NavigateManager showMessage:@"请选择时间"];
//        return;
//    }
//    if (!self.isChoose) {
//        [NavigateManager showMessage:@"请选择标签"];
//        return;
//    }
//    if (!self.name.text) {
//        [NavigateManager showMessage:@"请输入姓名"];
//        return;
//    }
//    if (!self.phone.text || self.phone.text.length != 11) {
//        [NavigateManager showMessage:@"请输入正确手机号"];
//        return;
//    }
//    if (!self.content.text) {
//        [NavigateManager showMessage:@"请输入内容"];
//        return;
//    }
    
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:@{@"scheduledate":self.date.text,
                                                                                @"scheduletime":self.time.text ? self.time.text : @"",
                                                                                @"scheduletab":self.scheduletab ? self.scheduletab : @"",
                                                                                @"name":self.name.text  ? self.name.text : @"",
                                                                                @"tel":self.phone.text  ? self.phone.text : @"",
                                                                                @"remark":self.content.text  ? self.content.text : @"",
                                                                                @"userid":@([UserData sharedManager].userInfoModel.id),
                                                                                @"username":USERID}];
    if (self.model) {
        [info setObject:@(self.model.id) forKey:@"id"];
    }
    
    
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:self.model ? URL_updateSchedule : URL_insertSchedule
                                           method:POST
                                           loding:@"保存中..."
                                              dic:info] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [NavigateManager showMessage:@"操作成功"];
        [self.refreshDataSubject sendNext:nil];
        [self popViewConDelay];
    }];
}


/**
 选择日期
 */
- (IBAction)chooseDate:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    CwDatePiker *piker = [CwDatePiker showInView:self.view issele:NO block:^(NSDate *date) {
        weakSelf.date.text = date.fs_string;
        }];
    piker.datePiker.datePickerMode = UIDatePickerModeDate;
}

/**
 选择时间
 */
- (IBAction)chooseTime:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    CwDatePiker *piker = [CwDatePiker showInView:self.view issele:NO block:^(NSDate *date) {
        weakSelf.time.text = [date fs_stringWithFormat:@"HH:mm:ss"];
    }];
    piker.datePiker.datePickerMode = UIDatePickerModeTime;
}

/**
 标签点击

 @param sender 按钮
 */
- (IBAction)clickBtn:(UIButton *)sender {
    
    if (!self.isChoose) {
        self.isChoose = YES;
    }
    UIView *view = sender.superview;
    for (int i = 0; i < 5; i++) {
        UIButton *btn = (UIButton *)[view viewWithTag:100 + i];
        [btn setBackgroundColor:RGBA(102, 102, 102, 1)];
    }
    
    [sender setBackgroundColor:MAINCOLOR];
    self.scheduletab = sender.titleLabel.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (RACSubject *)refreshDataSubject {
    if (!_refreshDataSubject) {
        _refreshDataSubject = [RACSubject subject];
    }
    return _refreshDataSubject;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
