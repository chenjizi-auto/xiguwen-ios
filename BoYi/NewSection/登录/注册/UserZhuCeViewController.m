//
//  UserZhuCeViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "UserZhuCeViewController.h"
#import "UserXieyiViewController.h"
#import "AppDelegate.h"
#import "CwChooseAreaPikerView.h"
@interface UserZhuCeViewController ()<UITextFieldDelegate>{
    NSString *_city,*_county,*_province;
}
@property (weak, nonatomic) IBOutlet UIButton *chuBtn;
@property (strong, nonatomic) UIButton *markBtn;
@end

@implementation UserZhuCeViewController
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
    [self chushi];
    _province = @"";
    _city = @"";
    _county = @"";
    if (IS_IPHONE_5) {
        self.weight.constant = 60;
        self.height.constant = 140;
        
    }
    
}
- (void)chushi{
    self.iphone.delegate = self;
    self.code.delegate = self;
    self.passWord.delegate = self;
    self.againPassword.delegate = self;
    self.iphone.inputAccessoryView = [self addToolbar];
    self.code.inputAccessoryView = [self addToolbar];
    self.againPassword.inputAccessoryView = [self addToolbar];
    self.passWord.inputAccessoryView = [self addToolbar];
    if (self.tpye == 4) {
        [self.bangBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    }
//    [self.iphone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.iphone setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
//    [self.code setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.code setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
//    [self.passWord setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.passWord setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
//    [self.againPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.againPassword setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"注册即同意《用户协议》"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:NSMakeRange(5,6)];
    [self.xieyiWord setAttributedTitle:str forState:(UIControlStateNormal)];
    [self.yinsizhengceButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
}
- (IBAction)yinsizhengceAction:(UIButton *)sender {
    //用户协议
    UserXieyiViewController *xieyi = [[UserXieyiViewController alloc] init];
    xieyi.url = @"http://www.boyihunjia.com/wap/news/privacy_protocol.html";
    [self pushToNextVCWithNextVC:xieyi];
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
    }else if (sender.tag == 1) {
        //注册
        if (self.tpye == 4) {
            [self zhucethress];
        }else {
            [self zhuce];
        }
        
    }else if (sender.tag == 2) {
        if (self.tpye == 3) {
            [self popViewConDelay];
        }else {
            int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
            
        }
    }else {
        //用户协议
        UserXieyiViewController *xieyi = [[UserXieyiViewController alloc] init];
        xieyi.isXieyi = YES;
        [self pushToNextVCWithNextVC:xieyi];
        
    }
}
- (IBAction)xuanzetionac:(UIButton *)sender {
    
    __weak typeof(self)weakSelf = self;
    
    [CwChooseAreaPikerView showInView:self.view block:^(NSString *province, NSString *city, NSString *area) {
        
        
        if ([province isEqualToString:city]) {
          
            _city = city;
            _county = area;
            _province = @"";
            [weakSelf.xuanzeCity setTitle:[NSString stringWithFormat:@"%@%@",city,area] forState:UIControlStateNormal];
        }else {
            _province = province;
            _city = city;
            _county = area;
            [weakSelf.xuanzeCity setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,area] forState:UIControlStateNormal];
        }
        
        
        
    }];
}


- (void)zhucethress{
    if (self.iphone.text.length != 11) {
        [NavigateManager showMessage:@"手机格式错误"];
        return;
    }
    if (self.code.text.length != 6) {
        [NavigateManager showMessage:@"验证码格式错误"];
        return;
    }
    if (self.passWord.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写密码"];
        return;
    }
    if (![self.passWord.text isEqualToString:self.againPassword.text]) {
        [NavigateManager showMessage:@"密码不一致"];
        return;
    }
    if ([self.xuanzeCity.titleLabel.text isEqualToString:@"请选择城市"]) {
        [NavigateManager showMessage:@"请选择城市"];
        return;
    }

    NSDictionary *dic = [[NSDictionary alloc] init];
    if ([_province isEqualToString:@""]) {
        dic = @{@"code":self.code.text,@"mobile":self.iphone.text,@"password":self.passWord.text,@"passwords":self.againPassword.text,@"type":@(3),@"token":self.token,@"userid":self.userid,@"city":_city,@"county":_county};
    }else {
        dic = @{@"code":self.code.text,@"mobile":self.iphone.text,@"password":self.passWord.text,@"passwords":self.againPassword.text,@"type":@(3),@"token":self.token,@"userid":self.userid,@"city":_city,@"county":_county,@"province":_province};
    }
    
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/index/setmobilepass"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"注册成功"];
                                             
                                               
                                               
                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   //        [NavigateManager hiddenLoadingMessage];
                                                   [self popViewConDelay];
                                               });
                                               
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"注册失败"];
                                           
                                       }];
}
- (void)zhuce{
    if (self.iphone.text.length != 11) {
        [NavigateManager showMessage:@"手机格式错误"];
        return;
    }
    if (self.code.text.length != 6) {
        [NavigateManager showMessage:@"验证码格式错误"];
        return;
    }
    if (self.passWord.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写密码"];
        return;
    }
    if (![self.passWord.text isEqualToString:self.againPassword.text]) {
        [NavigateManager showMessage:@"密码不一致"];
        return;
    }
    if ([self.xuanzeCity.titleLabel.text isEqualToString:@"请选择城市"]) {
        [NavigateManager showMessage:@"请选择城市"];
        return;
    }
    NSDictionary *dic = [[NSDictionary alloc] init];
    if ([_province isEqualToString:@""]) {
        dic = @{@"code":self.code.text,@"mobile":self.iphone.text,@"password":self.passWord.text,@"repassword":self.againPassword.text,@"type":@(self.tpye),@"city":_city,@"county":_county};
    }else {        
        dic = @{@"code":self.code.text,@"mobile":self.iphone.text,@"password":self.passWord.text,@"repassword":self.againPassword.text,@"type":@(self.tpye),@"city":_city,@"county":_county,@"province":_province};
    }
    
    
    [[RequestManager sharedManager] requestUrl:URL_New_register
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"注册成功"];
                                               if (self.tpye == 3) {
                                                   [self popViewConDelay];
                                               }else {
                                                   int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                                                   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];

                                               }
                                            
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"注册失败"];
                                           
                                       }];
}

- (IBAction)getcode:(JKCountDownButton *)sender {
    if (self.tpye == 4) {
        if (self.iphone.text.length == 11) {
            [[RequestManager sharedManager] requestUrl:URL_New_getcode
                                                method:POST
                                                loding:@""
                                                   dic:@{@"mobile":self.iphone.text}
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       [NavigateManager showMessage:@"发送成功"];
                                                       
                                                       sender.enabled = NO;
                                                       //button type要 设置成custom 否则会闪动
                                                       [sender startWithSecond:60.0];
                                                       
                                                       [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                                       [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                                                           NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                                                           return title;
                                                       }];
                                                       [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                                                           countDownButton.enabled = YES;
                                                           
                                                           [sender setTitleColor:MAINCOLOR forState:UIControlStateNormal];
                                                           return @"点击重新获取";
                                                       }];
                                                   }else {
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   
                                                   [NavigateManager showMessage:@"发送短信失败"];
                                                   
                                               }];
        }else {
            [NavigateManager showMessage:@"请填写正确的手机格式"];
        }
    }else {
        if (self.iphone.text.length == 11) {
            [[RequestManager sharedManager] requestUrl:URL_New_getcode
                                                method:POST
                                                loding:@""
                                                 dic:@{@"mobile":self.iphone.text,@"type":@"register"}
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       [NavigateManager showMessage:@"发送成功"];
                                                       
                                                       sender.enabled = NO;
                                                       //button type要 设置成custom 否则会闪动
                                                       [sender startWithSecond:60.0];
                                                       
                                                       [sender setTitleColor:MAINCOLOR forState:UIControlStateNormal];
                                                       [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                                                           NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                                                           return title;
                                                       }];
                                                       [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                                                           countDownButton.enabled = YES;
                                                           
                                                           [sender setTitleColor:MAINCOLOR forState:UIControlStateNormal];
                                                           return @"点击重新获取";
                                                       }];
                                                   }else {
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   
                                                   [NavigateManager showMessage:@"发送短信失败"];
                                                   
                                               }];
        }else {
            [NavigateManager showMessage:@"请填写正确的手机格式"];
        }
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}
@end
