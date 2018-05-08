//
//  QingjianDataViewController.m
//  BoYi
//
//  Created by heng on 2017/12/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "QingjianDataViewController.h"
#import "QingjianHomeViewController.h"
#import "CwDatePiker.h"
#import "CwLocationManager.h"
#import "DianziQingjianHomeViewController.h"
#import "MyInvitationCardModel.h"
#import "ZhiZuoViewController.h"

@interface QingjianDataViewController ()
@property (weak, nonatomic) IBOutlet UITextField *xinlangName;
@property (weak, nonatomic) IBOutlet UITextField *xinniangName;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *timeBTN;
@property (weak, nonatomic) IBOutlet UITextField *jiudianName;

@end

@implementation QingjianDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"请柬信息";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
	
	if (self.model) {
		[self.xinlangName setText:self.model.xinlang];
		[self.xinniangName setText: self.model.xinniang];
		[self.timeBTN setTitle:[self stringForNSInteger:self.model.hunlitime] forState:(UIControlStateNormal)];
		[self.address setText:self.model.hunlidizhi];
		[self.jiudianName setText: self.model.hotel];
	}
    self.xinlangName.delegate = self;
	self.xinlangName.inputAccessoryView = [self addToolbar];
    self.xinniangName.delegate = self;
    self.xinniangName.inputAccessoryView = [self addToolbar];
    self.address.delegate = self;
    self.address.inputAccessoryView = [self addToolbar];
    self.jiudianName.delegate = self;
    self.jiudianName.inputAccessoryView = [self addToolbar];
}

// 时间戳转字符串
- (NSString *)stringForNSInteger:(NSInteger) time{
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *string = [formatter stringFromDate:date];
	return string;
}


- (IBAction)timead:(IB_DESIGN_Button *)sender {
    __weak typeof(self) weakSelf = self;
    [CwDatePiker showInView:weakSelf.view issele:YES block:^(NSDate *date) {
        
        
        NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
        [weakSelf.timeBTN setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
        [weakSelf.timeBTN setTitle:[NSString stringWithFormat:@"  %@",dateString] forState:UIControlStateNormal];
    }];
}
- (IBAction)addressAC:(UIButton *)sender {
    @weakify(self);
    [[CwLocationManager sharedManager] startWithGeoSearch:YES complete:^(BOOL success, NSString *province, NSString *city) {
        
        @strongify(self);
        if (success) {
            //            _provinceString = province;
            //            _cityString = city;

            self.address.text = [NSString stringWithFormat:@"  %@",city];
            
        } else {
            [NavigateManager showMessage:@"获取定位失败，请重试！"];
            
        }
        
    }];
}

- (void)respondsToRightBtn {

    if (self.xinlangName.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写新郎名字"];
        return;
    }
    if (self.xinniangName.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写新娘名字"];
        return;
    }
    if (self.address.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写地址"];
        return;
    }
    if ([self.timeBTN.titleLabel.text isEqualToString:@"请选择婚礼时间"] ) {
        [NavigateManager showMessage:@"请填些婚礼时间"];
        return;
    }
    if (self.jiudianName.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写酒店名称"];
        return;
    }
    NSString *time = [self.timeBTN.titleLabel.text substringFromIndex:2];
    NSInteger index = [NSString timeSwitchTimestamp:time andFormatter:@"yyyy-MM-dd"];
	
	NSDictionary *dic;
	if (self.isEdit) {
		// 编辑请柬
		dic = @{@"hotel":self.jiudianName.text,
				@"hunlidizhi":self.address.text,
				@"hunlitime":self.timeBTN.titleLabel.text,
				@"id":@(self.model.id),// 请柬id
				@"xinlang":self.xinlangName.text,
				@"xinniang":self.xinniangName.text,
				@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
	} else {
		// 新增请柬
		dic = @{@"hotel":self.jiudianName.text,
				@"hunlidizhi":self.address.text,
				@"hunlitime":@(index),
				@"id":@(self.tempModel.id),// 模版id
				@"xinlang":self.xinlangName.text,
				@"xinniang":self.xinniangName.text,
				@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
	}
	
//	self.model.xinlang = self.xinlangName.text;
//	self.model.xinniang = self.xinniangName.text;
//	self.model.hunlitime =
//
//	[self.timeBTN setTitle:[self stringForNSInteger:self.model.hunlitime] forState:(UIControlStateNormal)];
//	[self.address setText:self.model.hunlidizhi];
//	[self.jiudianName setText: self.model.hotel];
	
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl: self.isEdit ? URL_editMyInvitationTemp : URL_New_Mobansecsond
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"保存成功"];
											   // 将上级页面推出栈
											   [weakSelf removeLastController];
											   // 跳转到另一页面
											   [weakSelf jump:[MyInvitationCardModel mj_objectWithKeyValues:response[@"data"]]];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"保存失败"];
                                       }];
}

- (void)jump:(MyInvitationCardModel *)model {
//	QingjianHomeViewController *jumpVC = [[QingjianHomeViewController alloc] init];
//	for (NSInteger i = 0; i < self.navigationController.viewControllers.count;  i ++) {
//		FatherViewController *vc = self.navigationController.viewControllers[i];
//		if ([vc isKindOfClass:[QingjianHomeViewController class]]) {
//			jumpVC = (QingjianHomeViewController *)vc;
//			jumpVC.model = model;
//			break;
//		}
//	}
	if (!self.isEdit) {
		QingjianHomeViewController *jumpVC = [[QingjianHomeViewController alloc] init];
		jumpVC.model = model;
		[self pushToNextVCWithNextVC:jumpVC];
	} else {
		[self popViewConDelay];
		self.onDidReload(model);
	}
	
	
//	for (UIViewController *controller in self.navigationController.viewControllers) {
//		if ([controller isKindOfClass:[QingjianHomeViewController class]]) {
//			QingjianHomeViewController *vc = (QingjianHomeViewController *)controller;
//			vc.model = model;
//			[self.navigationController popToViewController:vc animated:YES];
//		}
//		else {
//			[self popViewConDelay];
//		}
//	}
	
	
//	[self.navigationController popToViewController:jumpVC animated:YES];
}

- (void)removeLastController {
	NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
	for (UIViewController *vc in marr) {
		if ([vc isKindOfClass:[ZhiZuoViewController class]]) {
			[marr removeObject:vc];
			break;
		}
	}
	self.navigationController.viewControllers = marr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
