//
//  TuanDuiCenterViewController.m
//  BoYi
//
//  Created by heng on 2018/1/16.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "TuanDuiCenterViewController.h"
#import "JinRiXinZenViewController.h"
#import "JinRiYoudanViewController.h"
#import "ChengyuanDanAnViewController.h"
#import "YaoQingNewchengyuanViewController.h"
#import "ChengyuanGuanliViewController.h"
#import "DaitongguoChengyuanViewController.h"
#import "ChengyuanPaixuViewController.h"

#import "sheTuanDetilViewController.h"

@interface TuanDuiCenterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *personNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *scheduleNumLabel;


@end

@implementation TuanDuiCenterViewController

- (Shetuan *)model {
	if (!_model) {
		_model = [[Shetuan alloc] init];
	}
	return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"团队中心";
    [self addPopBackBtn];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// 请求社团中心数据
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_associationsCenter
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   weakSelf.model = [Shetuan mj_objectWithKeyValues:response[@"data"]];
											   [weakSelf updateView];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"获取团队信息失败"];
									   }];
}

- (void)updateView {
	[self.logoImg sd_setImageWithUrl:self.model.logourl];
	[self.nameLabel setText:self.model.name];
	[self.addressLabel setText:self.model.dizhi];
	[self.memberLabel setText:[NSString stringWithFormat:@"成员 %ld",self.model.chengyuan]];
	[self.orderNumLabel setText:[NSString stringWithFormat:@"%ld单",self.model.jrxinzeng]];
	[self.personNumLabel setText:[NSString stringWithFormat:@"%ld人",self.model.jryoudan]];
	[self.scheduleNumLabel setText:[NSString stringWithFormat:@"%ld人",self.model.cydangqi]];
}

- (IBAction)action:(UIButton *)sender {
	WeakSelf(self);
    if (sender.tag == 0) {//团队主页
		ShetuanDetilViewController *vc = [[ShetuanDetilViewController alloc] init];
		vc.id = self.model.id;
		[self pushToNextVCWithNextVC:vc];
    }else if (sender.tag == 1) {//邀请新成员
		if (self.model.jiaose != 3) {
			YaoQingNewchengyuanViewController *jinri = [[YaoQingNewchengyuanViewController alloc] init];
			jinri.model = self.model;
			[self pushToNextVCWithNextVC:jinri];
		} else {
			[NavigateManager showMessage:@"您还不是管理员，不能进行此操作"];
		}
    }else if (sender.tag == 2) {//待通过成员
		if (self.model.jiaose != 3) {
			DaitongguoChengyuanViewController *jinri = [[DaitongguoChengyuanViewController alloc] init];
			jinri.model = self.model;
			[self pushToNextVCWithNextVC:jinri];
		} else {
			[NavigateManager showMessage:@"您还不是管理员，不能进行此操作"];
		}
    }else if (sender.tag == 3) {//成员排序
		// 废弃功能
//        ChengyuanPaixuViewController *jinri = [[ChengyuanPaixuViewController alloc] init];
//        [self pushToNextVCWithNextVC:jinri];
    }else if (sender.tag == 4) {//成员管理
		if (self.model.jiaose != 3) {
			ChengyuanGuanliViewController *jinri = [[ChengyuanGuanliViewController alloc] init];
			jinri.model = self.model;
			[self pushToNextVCWithNextVC:jinri];
		} else {
			[NavigateManager showMessage:@"您还不是管理员，不能进行此操作"];
		}
    }else if (sender.tag == 5) {//今日新增
        JinRiXinZenViewController *jinri = [[JinRiXinZenViewController alloc] init];
		jinri.model = self.model;
        [self pushToNextVCWithNextVC:jinri];
    }else if (sender.tag == 6) {//今日有单
        JinRiYoudanViewController *jinri = [[JinRiYoudanViewController alloc] init];
		jinri.model = self.model;
        [self pushToNextVCWithNextVC:jinri];
    }else if (sender.tag == 7) {//成员档期
        ChengyuanDanAnViewController *jinri = [[ChengyuanDanAnViewController alloc] init];
		jinri.model = self.model;
        [self pushToNextVCWithNextVC:jinri];
    }else {//退出团队
		
		NSString *message = self.model.jiaose == 1 ? @"你是创始人，确定要退出团队吗？创始人退出后整个团队都会解散哦！" : @"确定要退出团队吗？";
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
			// 取消按钮
		}];
		UIAlertAction *conformAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
			// 确定按钮
			[[RequestManager sharedManager] requestUrl:URL_associationsCenterOut
												method:POST
												loding:@""
												   dic:@{@"jiaid":@(self.model.jiaid),
														 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
														 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
											  progress:nil
											   success:^(NSURLSessionDataTask *task, id response) {
												   if ([response[@"code"] integerValue] == 0) {
													   [NavigateManager showMessage:@"退出社团成功"];
													   [weakSelf popViewConDelay];
												   } else {
													   [NavigateManager showMessage:response[@"message"]];
												   }
											   } failure:^(NSURLSessionDataTask *task, NSError *error) {
												   [NavigateManager showMessage:@"退出团队失败"];
											   }];
			
			
		}];
		
		[alert addAction:cancelAction];
		[alert addAction:conformAction];
		[self presentViewController:alert animated:YES completion:nil];
		
    }
}



@end
