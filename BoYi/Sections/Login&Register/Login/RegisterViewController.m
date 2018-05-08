//
//  RegisterViewController.m
//  ThreeAsk_New
//
//  Created by Yifei Li on 2017/8/8.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import "RegisterViewController.h"
#import "JKCountDownButton.h"
#import "RegisterViewModel.h"
#import "WirteInfoViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet JKCountDownButton *verTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *CompleteBtn;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *joinUserName;
@property (strong,nonatomic) RegisterViewModel *viewModel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    [self addPopBackBtn];
    [self dataBlock];
    
    
    //赋值
    RAC(self.viewModel,userName) = self.userName.rac_textSignal;
    RAC(self.viewModel,userPassword) = self.Password.rac_textSignal;
    
    //获取验证码
//    self.verTypeBtn.rac_command = self.viewModel.getCodeCommand;
    [self showLoadingWithLoading:@"获取验证码中..." command:self.viewModel.getCodeCommand];
//    self.CompleteBtn.rac_command = self.viewModel.LoginCommand;
    [self showLoadingWithLoading:@"正在注册..." command:self.viewModel.getCodeCommand];
    
    @weakify(self);
    
    self.viewModel.isPhoneSignal = [[self.userName rac_signalForControlEvents:UIControlEventEditingChanged]
                                    map:^id _Nullable(__kindof UIControl * _Nullable value) {
                                        
                                        @strongify(self);
                                        return @(self.userName.text.length == 11);
                                    }];
    
    //    是不是正确的验证码
    self.viewModel.isCanGetCodeDown = [[self.Password rac_signalForControlEvents:UIControlEventEditingChanged]
                                        map:^id _Nullable(__kindof UIControl * _Nullable value) {
                                            
                                            @strongify(self);
                                            return @(self.Password.text.length == 6);
                                        }];
    
    //    验证码 颜色
    RAC(self.CompleteBtn,backgroundColor) = [RACSignal combineLatest:@[self.userName.rac_textSignal,self.code.rac_textSignal,self.Password.rac_textSignal]
                                                             reduce:^id _Nullable(NSString *name,NSString *code,NSString *password) {
    
                                                                 return (name.length == 11 && code.length == 6 && password.length >= 6) ? MAINCOLOR :RGBA(128, 128, 128, 1);
                                                             }];
    //    验证码 颜色
//    RAC(self.CompleteBtn,enabled) = [RACSignal combineLatest:@[self.userName.rac_textSignal,self.code.rac_textSignal,self.Password.rac_textSignal]
//                                                              reduce:^id _Nullable(NSString *name,NSString *code,NSString *password) {
//    
//                                                                  return (name.length == 11 && code.length == 6 && password.length >= 6) ? @YES : @NO;
//                                                              }];
    

}

#pragma mark - 数据回调

- (void)dataBlock {
    
    @weakify(self);
    
    //获取验证码结果
    [self.viewModel.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
         
         @strongify(self);
         [NavigateManager showMessage:@"验证码获取成功"];
         [self.verTypeBtn startWithSecond:60];
     }];
    
    [self.viewModel.LoginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       
        @strongify(self);
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
        WirteInfoViewController *vc = [story instantiateViewControllerWithIdentifier:@"WirteInfoViewController"];
        UIButton *btn = (UIButton *)[[[self.view viewWithTag:1500] viewWithTag:100] viewWithTag:200];
        vc.phone = self.userName.text;
        vc.isMerchant = !btn.selected;
        [self pushToNextVCWithNextVC:vc];
        
    }];
}

#pragma mark - 点击事件
/**
 顶部选择
 
 @param sender 个人，商家
 */
- (IBAction)ChooseType:(UIButton *)sender {
    [self.view endEditing:YES];
    [sender.superview viewWithTag:300].hidden = NO;
    sender.selected = YES;
    NSInteger tag = sender.tag == 200 ? 201 : 200;
    UIView *otherView = [sender.superview.superview viewWithTag:tag - 100];
    UIButton *btn = (UIButton *)[otherView viewWithTag:tag];
    btn.selected = NO;
    [otherView viewWithTag:300].hidden = YES;
    
//    [self isChooseMerchant:sender.tag == 201];
}
/**
 获取验证码

 @param sender 按钮
 */
- (IBAction)getCodeBtn:(id)sender {
    if (self.userName.text.length != 11) {
        [NavigateManager showMessage:@"请输入正确的手机号码"];
        return;
    }
    [self.viewModel.getCodeCommand execute:@{@"mobile":self.userName.text}];
}

/**
 注册

 @param sender 按钮
 */
- (IBAction)completeBtn:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.userName.text forKey:@"username"];
    [dic setObject:self.code.text forKey:@"validate_code"];
    [dic setObject:self.Password.text forKey:@"password"];
    if (self.joinUserName.text.length == 11) {
        [dic setObject:self.joinUserName.text forKey:@"mobile"];
    }
    UIButton *btn = (UIButton *)[[[self.view viewWithTag:1500] viewWithTag:100] viewWithTag:200];
    [dic setObject:btn.selected ? @2 : @3 forKey:@"userType"];
    [self.viewModel.LoginCommand execute:dic];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}
- (RegisterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RegisterViewModel alloc] init];
    }
    return _viewModel;
}

@end
