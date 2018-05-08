//
//  ChenxinRenzhenViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChenxinRenzhenViewController.h"
#import "MyCertificationAlertView.h"
#import "ShouyinTaiViewController.h"

@interface ChenxinRenzhenViewController () {
	NSInteger status;
}
@property (weak, nonatomic) IBOutlet UIButton *certificationBtn;

@property (nonatomic, strong) MyCertificationAlertView *alertView;

@end

@implementation ChenxinRenzhenViewController

- (NSArray *)certificationArray {
	if (!_certificationArray) {
		_certificationArray = [[NSArray alloc] init];
	}
	return _certificationArray;
}

- (MyCertificationAlertView *)alertView {
	if (!_alertView) {
		_alertView = [[MyCertificationAlertView alloc] init];
		WeakSelf(self);
		[_alertView setOnConfirmClick:^(NSInteger index) {
			// 去缴费
			[weakSelf ToPayWith:index];
		}];
	}
	return _alertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.certificationBtn.layer setCornerRadius:2.0f];
	[self.certificationBtn.layer setMasksToBounds:YES];
	[self.certificationBtn.layer setBorderWidth:0.5f];
	[self.certificationBtn.layer setBorderColor:UIColorFromRGB(0xFF7299).CGColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// 获取认证类型和价格
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_getAuthInfo
										method:POST
										loding:@""
										   dic:@{}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   weakSelf.certificationArray = [response[@"data"] subarrayWithRange:NSMakeRange(1, 3)];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];
	
	[self updateView];
}

- (IBAction)renaction:(UIButton *)sender {
	WeakSelf(self);
	if (status == 4) {
		// 退保证金
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退诚信保证金吗？这将导致您无法加入消费者保障计划哦！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
			// 退保证金
			[weakSelf refundMoney];
        }];
        UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction*_Nonnull action) {
        }];

        [alertController addAction:sureAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (status == 0) {
		 //交钱认证状态
		[self.alertView showWithArray:self.certificationArray];
    }
}

- (void)refundMoney {
    
    NSInteger chengxinId = [UserDataNew sharedManager].certificationDataModel.chengxin.id;
    NSDictionary *info = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
                           @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
                           @"id":@(chengxinId)
                           };
	// 退保证金
	[[RequestManager sharedManager] requestUrl:URL_refundMoney
										method:POST
										loding:@""
										   dic:info
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
                                           [NavigateManager hiddenLoadingMessage];
                                           
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               [self updateView];
                                               
                                           } else {
//                                               [NavigateManager showMessage:response[@"message"]];
                                               // 提示错误
                                               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:response[@"message"] preferredStyle:UIAlertControllerStyleAlert];
//                                               UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
//                                               }];
                                               UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction*_Nonnull action) {
                                               }];
                                               
//                                               [alertController addAction:sureAction];
                                               [alertController addAction:cancelAction];
                                               [self presentViewController:alertController animated:YES completion:nil];
                                           }
                                           
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:error.localizedDescription];
									   }];
}

- (void)ToPayWith:(NSInteger)index {
	// 提交认证费用
	[self.alertView dismiss];
	DLog(@"%@",self.certificationArray[index]);
//    // 跳转支付模块
//    ShouyinTaiViewController *vc = [[ShouyinTaiViewController alloc] init];
//    vc.type = 2;
//    vc.price = [self.certificationArray[index] objectForKey:@"parameter2"];
//    vc.bianhao = @"1";
//    [self pushToNextVCWithNextVC:vc];
    [self getOrderIdWithPrice:[NSString stringWithFormat:@"%@",self.certificationArray[index][@"parameter2"]] type:[NSString stringWithFormat:@"%@",self.certificationArray[index][@"id"]]];
}
- (void)getOrderIdWithPrice:(NSString *)price type:(NSString *)type {
    
    NSDictionary *info = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
                           @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
                           @"money":price,
                           @"type":type
                           };
    
    WeakSelf(self);
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Authentication/flowsheet"]
                                        method:POST
                                        loding:@""
                                           dic:info
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           
                                           [NavigateManager hiddenLoadingMessage];
                                           
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               [NavigateManager hiddenLoadingMessage];
                                               // 跳转支付模块
                                               ShouyinTaiViewController *vc = [[ShouyinTaiViewController alloc] init];
                                               vc.type = 5;
                                               vc.price = price;
                                               vc.bianhao = [NSString stringWithFormat:@"%@",response[@"data"][@"dingdanid"]];
                                               [weakSelf pushToNextVCWithNextVC:vc];
                                               
                                           }else{
                                               [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"网络连接失败"];
                                           
                                       }];
}
#pragma mark - 刷新页面专用
- (void)updateView {
	// 所有用户进行交互成功之后都要进行此步操作来冲亲请求数据并且刷新页面
	WeakSelf(self);
	[[UserDataNew sharedManager] getCertificationInfo:^(BOOL isSuccess) {
		if (isSuccess) {
			// 请求成功可以刷新界面
			status = [UserDataNew sharedManager].certificationDataModel.chengxin.state;
			if (status == 0) {
				[weakSelf.certificationBtn setTitle:@"立即认证" forState:(UIControlStateNormal)];
				[weakSelf.certificationBtn setUserInteractionEnabled:YES];
			} else if (status == 4) {
				[weakSelf.certificationBtn setTitle:@"退保证金" forState:(UIControlStateNormal)];
				[weakSelf.certificationBtn setUserInteractionEnabled:YES];
			} else if (status == 5) {
				[weakSelf.certificationBtn setTitle:@"退款中" forState:(UIControlStateNormal)];
				[weakSelf.certificationBtn setUserInteractionEnabled:NO];
			}
		}
	}];
}


@end
