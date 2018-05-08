//
//  PingtaiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "PingtaiViewController.h"
#import "ShouyinTaiViewController.h"

@interface PingtaiViewController ()
@property (weak, nonatomic) IBOutlet UIButton *certificationBtn;
@property (nonatomic, strong) NSString *remark;
@end

@implementation PingtaiViewController

- (NSArray *)certificationArray {
	if (!_certificationArray) {
		_certificationArray = [[NSArray alloc] init];
	}
	return _certificationArray;
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
										   weakSelf.certificationArray = response[@"data"];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];
	[self updateView];
}

- (IBAction)renzhenAC:(UIButton *)sender {
	WeakSelf(self);
	// 进行判断状态，是否认证通过
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"message"preferredStyle:UIAlertControllerStyleAlert];
	
	[alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		textField.placeholder = @"请输入备注";
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
	}];
	
	UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
		// 取消认证支付
	}];
	
	UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去缴费"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
        [weakSelf getOrderId];
	}];
	
	
	NSMutableAttributedString *messageAttribute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"认证费用:¥%@",[self.certificationArray[0] objectForKey:@"parameter2"]]];
	[messageAttribute addAttribute:NSForegroundColorAttributeName value: MAINCOLOR range:NSMakeRange(5,messageAttribute.string.length-5)];
	[messageAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,messageAttribute.string.length)];
	[alertController setValue:messageAttribute forKey:@"attributedMessage"];
	//3.3修改按钮的颜色
	//    [sureAction setValue:RGBA(69, 173, 216,1) forKey:@"titleTextColor"];
	//    [cancelAction setValue:[UIColor grayColor] forKey:@"titleTextColor"];
	[alertController addAction:cancelAction];
	[alertController addAction:sureAction];
	[self presentViewController:alertController animated:YES completion:nil];
    
}

// TextFieldTextDidChange 的通知处理方法
- (void)alertTextFieldDidChange:(NSNotification *)notification{
	
	UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
	if (alertController) {
		UITextField *remarkTF = alertController.textFields.firstObject;
//		UIAlertAction *okAction = alertController.actions.lastObject;
		// 设置okAction的状态，是否可点击
//		okAction.enabled = remarkTF.text.length > 0;
		self.remark = remarkTF.text;
	}
}  

#pragma mark - 刷新页面专用
- (void)updateView {
	// 所有用户进行交互成功之后都要进行此步操作来冲亲请求数据并且刷新页面
	WeakSelf(self);
	[[UserDataNew sharedManager] getCertificationInfo:^(BOOL isSuccess) {
		if (isSuccess) {
			// 请求成功可以刷新界面
			NSInteger status = [UserDataNew sharedManager].certificationDataModel.pingtai.state;
			[weakSelf.certificationBtn setTitle:status == 0 ? @"立即认证" : @"已认证" forState:(UIControlStateNormal)];
			[weakSelf.certificationBtn setUserInteractionEnabled:status == 0 ? YES : NO];
		}
	}];
}

- (void)getOrderId {
    
    NSDictionary *info = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
                           @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
                           @"money":[self.certificationArray[0] objectForKey:@"parameter2"],
                           @"type":[self.certificationArray[0] objectForKey:@"id"],
                           @"remark":self.remark ? self.remark : @""
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
                                               vc.price = [self.certificationArray[0] objectForKey:@"parameter2"];
                                               vc.bianhao = [NSString stringWithFormat:@"%@",response[@"data"][@"dingdanid"]];
                                               [weakSelf pushToNextVCWithNextVC:vc];
                                               
                                           }else{
                                               [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                      
                                           [NavigateManager showMessage:@"网络连接失败"];
                                           
                                       }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
