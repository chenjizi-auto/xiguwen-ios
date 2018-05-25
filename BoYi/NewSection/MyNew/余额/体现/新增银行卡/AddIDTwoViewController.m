//
//  AddIDTwoViewController.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddIDTwoViewController.h"
#import "AddIDThreeViewController.h"
#import "AddidSixViewController.h"
#import "CwChooseAreaPikerView.h"
#import "MOFSAddressPickerView.h"
@interface AddIDTwoViewController (){
    NSString *provincew,*cityw;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *masterLabel;
@property (weak, nonatomic) IBOutlet UITextField *branchTF;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic, strong) MOFSAddressPickerView *addressPickerView;
@end

@implementation AddIDTwoViewController
- (MOFSAddressPickerView *)addressPickerView {
    if (!_addressPickerView) {
        _addressPickerView = [[MOFSAddressPickerView alloc] init];
    }
    return _addressPickerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加银行卡";
    [self addPopBackBtn];
	
	[self.nameLabel setText:self.model.name];
	[self.numberLabel setText: self.model.bandnumber];
	[self.nextBtn setUserInteractionEnabled:NO];
	
	[self getBankName];
    self.branchTF.delegate = self;
    self.branchTF.inputAccessoryView = [self addToolbar];
}

- (void)getBankName {
	// 根据银行卡号请求银行名称
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_checkBankName
										method:POST
										loding:@""
										   dic:@{@"name":self.model.name,
												 @"bankcard":self.model.bandnumber,
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"data"] integerValue] == 0) {
											   weakSelf.model.bandname = response[@"blank"];
											   [weakSelf.masterLabel setText:response[@"blank"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionall:(UIButton *)sender {
    if (sender.tag == 0) {//银行
        AddIDThreeViewController *yinhang = [[AddIDThreeViewController alloc] init];
		yinhang.model = self.model;
        [self pushToNextVCWithNextVC:yinhang];
		WeakSelf(self);
		[yinhang setOnSelectedBank:^(BankCardModel *model) {
			weakSelf.model = model;
			[weakSelf.masterLabel setText: model.bandname];
		}];
		
    }else if (sender.tag == 1) {
//        __weak typeof(self)weakSelf = self;
//
//        [CwChooseAreaPikerView showInView:self.view block:^(NSString *province, NSString *city, NSString *area) {
//            if ([province isEqualToString:city]) {
//                provincew = city;
//                cityw = city;
//                weakSelf.shengshi.text = [NSString stringWithFormat:@"%@,%@",city,area];
//            }else {
//                provincew = province;
//                cityw = city;
//                weakSelf.shengshi.text = [NSString stringWithFormat:@"%@,%@,%@",province,city,area];
//            }
//        }];

        
        self.addressPickerView.toolBar.titleBarTitle = @"选择地址";
        self.addressPickerView.toolBar.cancelBarTitle = @"取消";
        self.addressPickerView.toolBar.commitBarTitle = @"确定";
        self.addressPickerView.numberOfSection = 2;
        WeakSelf(self);
        [self.addressPickerView showMOFSAddressPickerCommitBlock:^(NSString *address, NSString *zipcode) {
            NSArray *arrayCity = [NSArray array];
            arrayCity = [address componentsSeparatedByString:@"-"];
            provincew = arrayCity[0];
            cityw = arrayCity[1];
            if ([provincew isEqualToString:cityw]) {
                weakSelf.shengshi.text = [NSString stringWithFormat:@"%@",provincew];
            }else {
                weakSelf.shengshi.text = [NSString stringWithFormat:@"%@%@",provincew,cityw];
            }
            
        } cancelBlock:^{
            
        }];
        
        
        
    }else{//下一步
		self.model.site = self.branchTF.text;
		self.model.bandname = self.masterLabel.text;
        self.model.province = provincew;
        self.model.city = cityw;
        AddidSixViewController *yinhang = [[AddidSixViewController alloc] init];
		yinhang.model = self.model;
        [self pushToNextVCWithNextVC:yinhang];
        
    }
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//	
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (self.masterLabel.text.length > 0 && self.branchTF.text.length > 0 && self.shengshi.text.length > 0) {
		[self.nextBtn setUserInteractionEnabled:YES];
		[self.nextBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
	} else {
		[self.nextBtn setUserInteractionEnabled:NO];
		[self.nextBtn setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
	}
	
	return YES;
}


@end
