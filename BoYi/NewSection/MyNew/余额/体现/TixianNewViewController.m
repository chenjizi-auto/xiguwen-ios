//
//  TixianNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "TixianNewViewController.h"
#import "ChoeseCarIDViewController.h"
#import "BankCardModel.h"
#import "XLPasswordView.h"

@interface TixianNewViewController () <XLPasswordViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankNumber;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic, strong) BankCardModel *model;
@property (nonatomic, strong) XLPasswordView *passwordView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation TixianNewViewController

- (NSMutableArray *)dataArray {
	if (!_dataArray) {
		_dataArray = [[NSMutableArray alloc] init];
	}
	return _dataArray;
}

- (BankCardModel *)model {
	if (!_model) {
		_model = [[BankCardModel alloc] init];
	}
	return _model;
}

- (XLPasswordView *)passwordView {
	if (!_passwordView) {
		_passwordView = [[XLPasswordView alloc] init];
		_passwordView.delegate = self;
	}
	return _passwordView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    [self addPopBackBtn];
	
	[self.balanceLabel setText:[NSString stringWithFormat: @"可用余额:%@",[UserDataNew sharedManager].userInfoModel.user.vouchers]];
	[self.submitBtn setBackgroundColor:UIColorFromRGB(0xFECBDA)];
	[self.submitBtn setUserInteractionEnabled:NO];
	[self getBankCard];
    self.amountTF.delegate = self;
    self.amountTF.inputAccessoryView = [self addToolbar];
    self.topInset.constant = [UIApplication sharedApplication].statusBarFrame.size.height + 52.0;
}

- (void)getBankCard {
	// 先请求银行卡列表
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_myBankList
										method:POST
										loding:nil
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   // 解析数据
										   [weakSelf.dataArray addObjectsFromArray:[BankCardModel mj_objectArrayWithKeyValuesArray:response[@"data"]]];
										   if (weakSelf.dataArray.count <= 0) {
											   [NavigateManager showMessage:@"请添加银行卡"];
										   } else {
											   weakSelf.model = weakSelf.dataArray[0];
                                               [weakSelf updateView];
										   }
										   
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];
}

- (void)updateView {
	[self.bankImage sd_setImageWithUrl:self.model.icon];
	[self.bankName setText: self.model.name];
	[self.bankNumber setText:[NSString stringWithFormat:@"尾号%@",[self.model.band_number substringFromIndex:self.model.band_number.length-4]]];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)xuanzheAC:(UIButton *)sender {
	// 选择银行卡
	ChoeseCarIDViewController *xuan = [[ChoeseCarIDViewController alloc] init];
	xuan.model = self.model;
	[self pushToNextVCWithNextVC:xuan];
	WeakSelf(self);
	[xuan setOnSelectedBank:^(BankCardModel *model) {
		weakSelf.model = model;
		[weakSelf updateView];
	}];
}
- (IBAction)sureAC:(UIButton *)sender {
	// 提交银行卡
	[self.passwordView showPasswordInView:self.view];
	
}

- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password {
	// 输入密码位数已满时调用
    [self.passwordView clearPassword];
	[self.passwordView hidePasswordView];
    
	[[RequestManager sharedManager] requestUrl:URL_withdrawal
										method:POST
										loding:nil
										   dic:@{@"bankid":@(self.model.bandid),
												 @"jine":@([self.amountTF.text integerValue]),
												 @"paypassword":password,
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage:@"提现请求成功"];
                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   [self popViewConDelay];
                                               });
										   } else {
											   [NavigateManager showMessage: response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"提现请求失败"];
									   }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
	if ([self.amountTF.text integerValue] > [[UserDataNew sharedManager].userInfoModel.user.vouchers integerValue] || self.amountTF.text.length <= 0) {
		[self.balanceLabel setText:self.amountTF.text.length <= 0 ? [NSString stringWithFormat: @"可用余额:%@",[UserDataNew sharedManager].userInfoModel.user.vouchers] : @"金额已超过可提取余额"];
		[self.balanceLabel setTextColor:UIColorFromRGB(0xFC3C45)];
		[self.submitBtn setBackgroundColor:UIColorFromRGB(0xFECBDA)];
		[self.submitBtn setUserInteractionEnabled:NO];
    }else {
        if ([self.bankName.text isEqualToString:@"银行卡开户行"]) {
            
            [self.balanceLabel setTextColor:UIColorFromRGB(0xFC3C45)];
            [self.submitBtn setBackgroundColor:UIColorFromRGB(0xFECBDA)];
            [self.submitBtn setUserInteractionEnabled:NO];
        }else {
            [self.balanceLabel setText:[NSString stringWithFormat: @"可用余额:%@",[UserDataNew sharedManager].userInfoModel.user.vouchers]];
            [self.balanceLabel setTextColor:UIColorFromRGB(0x898989)];
            [self.submitBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
            [self.submitBtn setUserInteractionEnabled:YES];
        }
        
		
	}
}

@end
