//
//  ChangePhoneViewController.m
//  BoYi
//
//  Created by Chen on 2017/8/13.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "JKCountDownButton.h"
#import "ChangePasswordViewController.h"

@interface ChangePhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *ver;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
@property (weak, nonatomic) IBOutlet JKCountDownButton *verTypeBtn;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addPopBackBtn];
    
    switch (self.style) {
        case ChangePhoneStyleNewPhone:
        {
            [self.SureBtn setTitle:@"提交" forState:UIControlStateNormal];
            self.navigationItem.title = @"更改绑定手机";
        }
            break;
        case ChangePhoneStyleChangePassword:
        {
            self.navigationItem.title = @"更改密码";
        }
            break;
    
        default:
            self.navigationItem.title = @"更改绑定手机";
            break;
    }
    @weakify(self);
    RAC(self.SureBtn,backgroundColor) = [RACSignal combineLatest:@[self.phone.rac_textSignal,self.ver.rac_textSignal] reduce:^id _Nullable{
        @strongify(self);
        return self.phone.text.length == 11 && self.ver.text.length == 6 && [self.phone.text isEqualToString:[UserData sharedManager].userInfoModel.username] ? MAINCOLOR : RGBA(105, 105, 105, 1);
    }];
    RAC(self.SureBtn,enabled) = [RACSignal combineLatest:@[self.phone.rac_textSignal,self.ver.rac_textSignal] reduce:^id _Nullable{
        @strongify(self);
        return self.phone.text.length == 11 && self.ver.text.length == 6 && [self.phone.text isEqualToString:[UserData sharedManager].userInfoModel.username] ? @YES : @NO;
    }];
}
//
- (IBAction)getCode:(id)sender {
    
    
    if (self.phone.text.length != 11) {
        [NavigateManager showMessage:@"请输入正确的手机号"];
        return;
    }
    
    @weakify(self);
    
    [[[RequestManager sharedManager] RACRequestUrl:URL_LOGIN_ACCOUNT_GETSMSCODE
                                           method:POST
                                           loding:nil
                                              dic:@{@"mobile":self.phone.text}] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [NavigateManager showMessage:@"验证码获取成功"];
        [self.verTypeBtn startWithSecond:60];
    }];
    
}
- (IBAction)sure:(id)sender {
    
//    [self pushToNextvcWithNextVCTitle:@"ChangePasswordViewController"];
    ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
    vc.validate_code = self.ver.text;
    [self pushToNextVCWithNextVC:vc];
}

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
