//
//  NewForGetPassTwoViewController.m
//  BoYi
//
//  Created by heng on 2018/1/25.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NewForGetPassTwoViewController.h"

@interface NewForGetPassTwoViewController ()<UITextFieldDelegate>

@end

@implementation NewForGetPassTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    [self addPopBackBtn];
    if (isIPhoneX) {
        self.height.constant = 94;
    }
    [self addTargetMethod];
    self.newpass.delegate = self;
    self.oldpass.delegate = self;
    self.newpass.inputAccessoryView = [self addToolbar];
    self.oldpass.inputAccessoryView = [self addToolbar];
}
-(void)addTargetMethod{
    [self.newpass addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.oldpass addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textField1TextChange:(UITextField *)textField{
    
    if (self.newpass.text.length != 0 && self.oldpass.text.length != 0) {
        self.nextBtn.backgroundColor = MAINCOLOR;
        [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.nextBtn.userInteractionEnabled = YES;
    }else {
        self.nextBtn.backgroundColor = RGBA(217, 217, 217, 1);
        [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.nextBtn.userInteractionEnabled = NO;
    }
    
}
- (IBAction)over:(UIButton *)sender {
    
    if (self.newpass.text.length == 0 || self.oldpass.text.length == 0) {
        [NavigateManager showMessage:@"密码不能为空"];
        return;
    }
    if (![self.newpass.text isEqualToString:self.newpass.text]) {
        [NavigateManager showMessage:@"密码不一致"];
        return;
    }
    
    NSDictionary *dic = @{@"code":self.code,@"mobile":self.iphone,@"password":self.newpass.text};
    [[RequestManager sharedManager] requestUrl:URL_New_findpasstwo
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:response[@"message"]];
                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   
                                                   
                                                   int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                                                   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
                                               });
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"找回密码失败"];
                                           
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

@end
