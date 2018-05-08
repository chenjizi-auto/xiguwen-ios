//
//  FindPasswordViewController.m
//  ThreeAsk_New
//
//  Created by Yifei Li on 2017/8/8.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "JKCountDownButton.h"

@interface FindPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgain;
@property (weak, nonatomic) IBOutlet JKCountDownButton *verTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *CompleteBtn;
@property (weak, nonatomic) IBOutlet UITextField *code;
//获取验证码
@property (nonatomic, strong) RACCommand *getCodeCommand;
@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addPopBackBtn];
    //显示颜色
    RAC(self.CompleteBtn,backgroundColor) = [RACSignal combineLatest:@[self.userName.rac_textSignal,
                                                                       self.Password.rac_textSignal,
                                                                       self.code.rac_textSignal,
                                                                       self.passwordAgain.rac_textSignal]
                                             
                                                              reduce:^id _Nullable(NSString *name,
                                                                                   NSString *Password,
                                                                                   NSString *code,
                                                                                   NSString *passwordAgain) {
                                                                  
                                                                  if ([Password isEqualToString:passwordAgain] && name.length == 11 && passwordAgain.length >= 6 && code.length == 6) {
                                                                      return MAINCOLOR;
                                                                  }
                                                                  return RGBA(128, 128, 128, 1);
                                                              }];
    //显示enble
    RAC(self.CompleteBtn,enabled) = [RACSignal combineLatest:@[self.userName.rac_textSignal,
                                                                       self.Password.rac_textSignal,
                                                                       self.code.rac_textSignal,
                                                                       self.passwordAgain.rac_textSignal]
                                             
                                                              reduce:^id _Nullable(NSString *name,
                                                                                   NSString *Password,
                                                                                   NSString *code,
                                                                                   NSString *passwordAgain) {
                                                                  
                                                                  if ([Password isEqualToString:passwordAgain] && name.length == 11 && passwordAgain.length >= 6 && code.length == 6) {
                                                                      return @YES;
                                                                  }
                                                                  return @NO;
                                                              }];
    
    [self showLoadingWithLoading:@"获取验证码中..." command:self.getCodeCommand];
    
    @weakify(self);
    
    [[self.verTypeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
     
        @strongify(self);
        [self.getCodeCommand execute:@{@"mobile":self.userName.text}];
    }];
    
    //获取验证码结果
    [self.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [NavigateManager showMessage:@"验证码获取成功"];
        [self.verTypeBtn startWithSecond:60];
    }];
    
}
//获取验证码
- (RACCommand *)getCodeCommand {
    
    if (!_getCodeCommand) {
        
        
        _getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [[RequestManager sharedManager] RACRequestUrl:URL_LOGIN_ACCOUNT_GETSMSCODE
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _getCodeCommand;
}
/**
 点击完成

 @param sender 按钮
 */
- (IBAction)complete:(id)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.userName.text forKey:@"username"];
    [dic setObject:self.code.text forKey:@"validate_code"];
    [dic setObject:self.Password.text forKey:@"password"];
    
    
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:URL_LOGIN_EDIT_PASSWORD
                                            method:POST
                                            loding:@"提交中..."
                                               dic:dic] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [NavigateManager showMessage:@"修改成功，请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
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
