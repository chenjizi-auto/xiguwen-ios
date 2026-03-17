//
//  AddLiuchengViewController.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddLiuchengViewController.h"
#import "CwDatePiker.h"
#import "WHpickDate.h"
@interface AddLiuchengViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

//@property (nonatomic, strong) CwDatePiker *datePicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;


@end

@implementation AddLiuchengViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle: @"添加流程"];
	[self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
	
	if (self.model) {
		// 编辑状态
		self.typeTF.text = self.model.title;
		self.timeLabel.text = self.model.shijian;
		self.personnelTF.text = self.model.renyuan;
		self.contentTV.text = self.model.shixiang;
	}
	
	ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
		
	}
    self.typeTF.delegate = self;
    self.typeTF.inputAccessoryView = [self addToolbar];
	self.personnelTF.delegate = self;
	self.personnelTF.inputAccessoryView = [self addToolbar];
    self.contentTV.delegate = self;
    self.contentTV.inputAccessoryView = [self addToolbar];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 52.0;
	
}
- (void)respondsToRightBtn {
	if (self.typeTF.text.length == 0) {
		[NavigateManager showMessage: @"请填写流程类型"];
		return;
	}
	if (self.typeTF.text.length > 12) {
		[NavigateManager showMessage: @"请将流程类型控制在12个字符内"];
		return;
	}
	if (self.timeLabel.text.length == 0) {
		[NavigateManager showMessage: @"请选择时间"];
		return;
	}
	if (self.personnelTF.text.length == 0) {
		[NavigateManager showMessage: @"请填写参与人员"];
		return;
	}
	if (self.contentTV.text.length == 0) {
		[NavigateManager showMessage: @"请填写内容事项"];
		return;
	}
	NSDictionary *dic = @{@"id":@(self.model.id),
						  @"renyuan":self.personnelTF.text,
						  @"shijian":self.timeLabel.text,
						  @"shixiang":self.contentTV.text,
						  @"title":self.typeTF.text,
						  @"token":[UserDataNew sharedManager].userInfoModel.token.token,
						  @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
	if (self.model) {
		// 编辑
		DLog(@"%@",dic);
		[[RequestManager sharedManager] requestUrl:URL_editFlow
											method:POST
											loding:@""
											   dic:dic progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage:@"编辑成功"];
												   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
													   
													   [self popViewConDelay];;
												   });
												   
											   }else{
												   [NavigateManager showMessage:response[@"message"]];
											   }
										   }
										   failure:^(NSURLSessionDataTask *task, NSError *error) {
											   DLog(@"%@",error);
										   }];
	} else {
		// 添加
		[[RequestManager sharedManager] requestUrl:URL_addFlow
											method:POST
											loding:@""
											   dic:dic progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage:@"添加成功"];
//												   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
													   
													   [self popViewConDelay];;
//												   });
												   
											   }else{
												   
												   [NavigateManager showMessage:response[@"message"]];
											   }
										   }
										   failure:^(NSURLSessionDataTask *task, NSError *error) {
											   
										   }];
	}
    
}

- (IBAction)selected:(UIButton *)sender {
	
//    DLog(@"点击我进行时间选择");
//
//    __weak typeof(self) weakSelf = self;
//    CwDatePiker *piker = [CwDatePiker showInView:self.view issele:NO block:^(NSDate *date) {
//
//        weakSelf.timeLabel.text = [date fs_stringWithFormat:@"HH:mm"];
//    }];
//    piker.datePiker.datePickerMode = UIDatePickerModeTime;
    
    __weak typeof(self) weakSelf = self;
    [WHpickDate showInView:weakSelf.view block:^(NSDate *date) {
        
        NSString *dateString = [date fs_stringWithFormat:@"HH:mm"];
        weakSelf.timeLabel.text = dateString;
    }];
	
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//	if (self.typeTF.text.length >= 12) {
//		self.typeTF.text = [self.typeTF.text substringToIndex:9];
//	}
//	return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
