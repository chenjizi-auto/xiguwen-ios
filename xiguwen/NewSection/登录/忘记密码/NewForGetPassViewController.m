//
//  NewForGetPassViewController.m
//  BoYi
//
//  Created by heng on 2018/1/25.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NewForGetPassViewController.h"
#import "JKCountDownButton.h"
#import "NewForGetPassTwoViewController.h"
@interface NewForGetPassViewController ()<UITextFieldDelegate>

@end

@implementation NewForGetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    [self addPopBackBtn];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 94;
    }
    self.iphone.delegate = self;
    self.code.delegate = self;
    self.iphone.inputAccessoryView = [self addToolbar];
    self.code.inputAccessoryView = [self addToolbar];
    [self addTargetMethod];
}
-(void)addTargetMethod{
    [self.iphone addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.code addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textField1TextChange:(UITextField *)textField{
    
    if (self.iphone.text.length == 11 && self.code.text.length == 6) {
        self.nextBtn.backgroundColor = MAINCOLOR;
        [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.nextBtn.userInteractionEnabled = YES;
    }else {
        self.nextBtn.backgroundColor = RGBA(217, 217, 217, 1);
        [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.nextBtn.userInteractionEnabled = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)action:(JKCountDownButton *)sender {
    
    if (self.iphone.text.length == 11) {
        [[RequestManager sharedManager] requestUrl:URL_New_getcode
                                            method:POST
                                            loding:@""
                                               dic:@{@"mobile":self.iphone.text,@"type":@"findpwd"}
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
                                               }else{
                                                   
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                               [NavigateManager showMessage:@"发送短信失败"];
                                               
                                           }];
    }else {
        [NavigateManager showMessage:@"请填写正确的手机格式"];
    }
}
- (IBAction)next:(UIButton *)sender {
    if (self.iphone.text.length != 11) {
        [NavigateManager showMessage:@"手机格式错误"];
        return;
    }
    if (self.code.text.length != 6) {
        [NavigateManager showMessage:@"验证码格式错误"];
        return;
    }
    
    [[RequestManager sharedManager] requestUrl:URL_New_findpassone
                                        method:POST
                                        loding:@""
                                           dic:@{@"mobile":self.iphone.text,@"code":self.code.text}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               NewForGetPassTwoViewController *vc = [[NewForGetPassTwoViewController alloc] init];
                                               vc.code = self.code.text;
                                               vc.iphone = self.iphone.text;
                                               [self pushToNextVCWithNextVC:vc];
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"发送短信失败"];
                                           
                                       }];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}

@end
