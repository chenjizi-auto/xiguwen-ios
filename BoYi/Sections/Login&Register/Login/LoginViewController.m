//
//  LoginViewController.m
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/5.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "LoginViewController.h"
#import "CwLoginViewModel.h"
#import "AppDelegate.h"


@interface LoginViewController ()<UITextFieldDelegate> {
    BOOL isReceived ;
}

@property (strong,nonatomic) CwLoginViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *loginBtn;


@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showInfo];
    self.navigationItem.title = @"登录";
    [self actionEvent];
    [self.Password setSecureTextEntry:YES];
    self.userName.delegate = self;
    self.Password.delegate = self;
    // 登录成功
//    @weakify(self);
//    [[self.viewModel.refreshUISubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [app ConfirmRootViewController];
//        //把自身清除掉
//        [self.navigationController removeFromParentViewController];
//    }];
    
    // 三方登录成功
//    @weakify(self);
//    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        
//        //登录成功
//        [NavigateManager showMessage:@"登录成功"];
//        //存用户信息
//        [UserData WriteUserInfo:x];
//        //         //云信登录
//        [[CwChatManager sharedManager] FirstLoginWithInfo:x[@"userInfo"]];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            [app ConfirmRootViewController];
//            //把自身清除掉
//            [self.navigationController removeFromParentViewController];
//        });
//        
//    }];
    
}

- (void)showInfo {

    //赋值
    RAC(self.viewModel,userName) = self.userName.rac_textSignal;
    RAC(self.viewModel,userPassword) = self.Password.rac_textSignal;
    

    @weakify(self);
    self.viewModel.isPhoneSignal = [[self.userName rac_signalForControlEvents:UIControlEventEditingChanged]
                                    map:^id _Nullable(__kindof UIControl * _Nullable value) {
                                        
                                        @strongify(self);
                                        return @(self.userName.text.length == 11);
    }];
    
//    是不是正确的密码
    self.viewModel.isCodeRightSignal = [[self.Password rac_signalForControlEvents:UIControlEventEditingChanged]
                                    map:^id _Nullable(__kindof UIControl * _Nullable value) {
                                        
                                        @strongify(self);
                                        return @(self.Password.text.length >= 6);
                                    }];

//    验证码 颜色
    RAC(self.loginBtn,backgroundColor) = [RACSignal combineLatest:@[self.userName.rac_textSignal,self.Password.rac_textSignal]
                                                             reduce:^id _Nullable(NSString *mobile,NSString *password) {
    
                                                                 return (mobile.length == 11 && password.length >= 6) ? MAINCOLOR :RGBA(128, 128, 128, 1);
                                                             }];
    //    验证码 颜色
//    RAC(self.loginBtn,enabled) = [RACSignal combineLatest:@[self.userName.rac_textSignal,self.Password.rac_textSignal]
//                                                           reduce:^id _Nullable(NSString *mobile,NSString *password) {
//                                                               
//                                                               return (mobile.length == 11 && password.length >= 6) ? @YES : @NO;
//                                                           }];
    

}

/**
 返回
 */
- (IBAction)back:(id)sender {
    [self popViewConDelay];
}


- (void)actionEvent {
    
    
    @weakify(self);
    //登录
    self.loginBtn.rac_command = self.viewModel.refreshDataCommand;
//    [[self.loginBtn.rac_command.executionSignals flatten] subscribeNext:^(id  _Nullable x) {
//        
//    }];
    //
    [self.viewModel.refreshDataCommand.executionSignals.switchToLatest
     subscribeNext:^(id  _Nullable x) {
    
         @strongify(self);
    
         [NavigateManager showMessage:@"登录成功"];
         [UserData WriteUserInfo:x];
    
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             
//             AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//             [app ConfirmRootViewController];
//             //把自身清除掉
//             [self.navigationController removeFromParentViewController];
             [self dismissViewControllerAnimated:YES completion:NULL];
         });

         
     }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}


- (CwLoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CwLoginViewModel alloc] init];
    }
    return _viewModel;
}

- (void)dealloc
{
    DLog(@"%@页面已被销毁",self.title);
}
@end
