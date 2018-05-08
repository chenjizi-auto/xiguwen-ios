//
//  QiyeRenzhenViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "QiyeRenzhenViewController.h"

@interface QiyeRenzhenViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *cardTF;
@property (weak, nonatomic) IBOutlet UIImageView *frontImage;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *licenseImage;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic, strong) NSString *frontStr;
@property (nonatomic, strong) NSString *reverseStr;
@property (nonatomic, strong) NSString *licenseStr;

@end

@implementation QiyeRenzhenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业实名认证";
    [self addPopBackBtn];
    self.nameTF.delegate = self;
    self.cardTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.cardTF.inputAccessoryView = [self addToolbar];
	// 判断是否通过审核
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_checkCompanyAuth
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   [weakSelf pushAlertController:[[response[@"data"] objectForKey:@"state"] integerValue] message:[response[@"data"] objectForKey:@"content"]];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
									   }];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)pushAlertController:(NSInteger )status message:(NSString *)message {
	NSString *title;
	NSString *btnTitle;
	if (status == 0) {
		title = @"提交资料成功";
		btnTitle = @"我知道了";
	} else if (status == 1) {
		title = @"恭喜您，实名认证成功！";
		btnTitle = @"我知道了";
	} else if (status == 2) {
		title = @"很抱歉，实名认证未通过！";
		btnTitle = @"修改提交";
	} else if (status == 3) {
		// 从未认证过
		return;
	}
	WeakSelf(self);
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
	UIAlertAction *sureAction = [UIAlertAction actionWithTitle:btnTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
		// 点击知道进行操作
		if (status != 2) {
			[weakSelf popViewConDelay];
		}
	}];
	[sureAction setValue:UIColorFromRGB(0xFC5887) forKey:@"_titleTextColor"];
	[alert addAction: sureAction];
	[self presentViewController:alert animated:YES completion:nil];

}

- (IBAction)tapFront:(UITapGestureRecognizer *)sender {
	// 上传生份证正面照片
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:YES imageBlock:^(UIImage *image) {
//		[self.frontImage setImage:image];
//		NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//		NSString *str = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
//		weakSelf.frontStr = [UIImage urlWithBase64Image:image];
		
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				weakSelf.frontStr = urlStr;
				[weakSelf.frontImage setImage:image];
			}
		}];
		
	}];
}

- (IBAction)tapBack:(UITapGestureRecognizer *)sender {
	// 上传身份证反面照片
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:YES imageBlock:^(UIImage *image) {
//		[weakSelf.backImage setImage:image];
//		NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//		NSString *str = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
//		weakSelf.reverseStr = [UIImage urlWithBase64Image:image];
		
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				weakSelf.reverseStr = urlStr;
				[weakSelf.backImage setImage:image];
			}
		}];
		
	}];
	
	
	
}

- (IBAction)tapLicense:(UITapGestureRecognizer *)sender {
	// 上传企业执照
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:YES imageBlock:^(UIImage *image) {
//		[weakSelf.licenseImage setImage:image];
//		NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//		NSString *str = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
//		weakSelf.licenseStr = [UIImage urlWithBase64Image:image];
		
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				weakSelf.licenseStr = urlStr;
				[weakSelf.licenseImage setImage:image];
			}
		}];
		
	}];
}

- (IBAction)submit:(UIButton *)sender {
	if (self.nameTF.text.length == 0) {
		[NavigateManager showMessage: @"请填写姓名"];
		return;
	}
	if (self.cardTF.text.length == 0) {
		[NavigateManager showMessage: @"请填写身份证号"];
		return;
	}
	if (self.frontStr.length == 0) {
		[NavigateManager showMessage: @"请上传身份证正面照"];
		return;
	}
	if (self.reverseStr.length == 0) {
		[NavigateManager showMessage: @"请上传身份证背面照"];
		return;
	}
	if (self.licenseStr.length == 0) {
		[NavigateManager showMessage: @"请上传企业营业执照"];
	}

	NSDictionary *dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
						  @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
						  @"name":self.nameTF.text,
						  @"identitynum":self.cardTF.text,
						  @"identitya":self.frontStr,
						  @"identityb":self.reverseStr,
						  @"imga":self.licenseStr};
	[[RequestManager sharedManager] requestUrl:URL_CompanyAuth
										method:POST
										loding:@""
										   dic:dic
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage:@"上传成功"];
											   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

												   [self popViewConDelay];;
											   });

										   }else{

											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"上传失败"];
									   }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

@end
