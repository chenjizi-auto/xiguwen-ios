//
//  SheJieDanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SheJieDanViewController.h"

@interface SheJieDanViewController () <UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation SheJieDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"接单数量";
    [self addPopBackBtn];
    self.numberTF.delegate = self;
    self.numberTF.inputAccessoryView = [self addToolbar];
	[self.datePicker addTarget:self action:@selector(selectedDate:) forControlEvents:(UIControlEventValueChanged)];
}

- (void)selectedDate:(UIDatePicker *)sender {
	DLog(@"%@",self.datePicker.date);
}

- (IBAction)saveChanges:(UIButton *)sender {
	WeakSelf(self);
	
	if (self.datePicker.date == nil) {
		[NavigateManager showMessage: @"请选择日期"];
		return;
	}
	
	if (self.numberTF.text.length == 0) {
		[NavigateManager showMessage: @"请输入接单数量"];
		return;
	}
	
	[[RequestManager sharedManager] requestUrl:URL_scheduleSettings
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
												 @"sjdate":self.datePicker.date,
												 @"setnumber":self.numberTF.text}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if (response[@"data"] == 0) {
											   [NavigateManager showMessage: @"修改成功"];
											   [weakSelf popViewConDelay];
										   } else {
											   [NavigateManager showMessage:response[@"messge"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"修改失败"];
									   }];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
