//
//  AskViewController.m
//  BoYi
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AskViewController.h"
#import "AskSuccessViewController.h"
#import "JKCountDownButton.h"

@interface AskViewController ()
@property (weak, nonatomic) IBOutlet JKCountDownButton *verTypeBtn;

@property (weak, nonatomic) IBOutlet UITextField *code;
@end

@implementation AskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线咨询";
    
    [self addPopBackBtn];
    self.content.placeholder = @"请填写您要咨询的问题,我们的顾问马上与您联系";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getcode:(JKCountDownButton *)sender {

    if ([_phoneNumber.text isPhoneNumber]) {
        [[RequestManager sharedManager] requestUrl:URL_LOGIN_ACCOUNT_GETSMSCODE
                                            method:POST
                                            loding:@""
                                               dic:@{@"mobile":_phoneNumber.text}
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"status"] integerValue] == 200) {
                                                   [NavigateManager showMessage:@"发送成功"];

                                                   sender.enabled = NO;
                                                   //button type要 设置成custom 否则会闪动
                                                   [sender startWithSecond:60.0];
                                            
                                                   [sender setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
                                                   [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                                                       NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                                                       return title;
                                                   }];
                                                   [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                                                       countDownButton.enabled = YES;
                                                 
                                                       [sender setTitleColor:RGBA(255, 83, 122, 1) forState:UIControlStateNormal];
                                                       return @"点击重新获取";  
                                                       
                                                   }];
                                               }
                                               
                                               
                                               
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                               [NavigateManager showMessage:@"发送短信失败"];
                                               
                                           }];
    }else {
        [NavigateManager showMessage:@"请填写正确的手机格式"];
    }
    
}

- (IBAction)action:(UIButton *)sender {
    if (![_phoneNumber.text isPhoneNumber]) {
        [NavigateManager showMessage:@"请填写正确的手机格式"];
        return;
    }
    if (_code.text.length == 0) {
        [NavigateManager showMessage:@"请填写验证码"];
        return;
    }
    if (_content.text.length == 0 ) {
        [NavigateManager showMessage:@"请填写咨询内容"];
        return;
    }
    
    [[RequestManager sharedManager] requestUrl:URL_ANLIE_ASK
                                        method:POST
                                        loding:nil
                                           dic:@{@"mobile":_phoneNumber.text,@"vcode":_code.text,@"descn":_content.text}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           
                                           if ([response[@"status"] isEqualToString:@"200"]) {
                                               AskSuccessViewController *askSuccess = [[AskSuccessViewController alloc] init];
                                               askSuccess.idString = @"";
                                               [self pushToNextVCWithNextVC:askSuccess];
                                               return;
                                           }
                                           
                                           
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
 
                                           [NavigateManager showMessage:@"提交失败"];
                                           
                                       }];
    
}


#pragma mark - 网络请求


@end
