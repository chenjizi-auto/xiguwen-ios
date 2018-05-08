//
//  ChangePasswordViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/9/1.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *PasswordAgain;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"修改密码";
    [self addPopBackBtn];
    
    
    RAC(self.saveBtn,backgroundColor) = [RACSignal combineLatest:@[self.password.rac_textSignal,self.PasswordAgain.rac_textSignal] reduce:^id _Nullable(NSString *passw,NSString *again) {
        
        return passw.length >= 6 && [again isEqualToString:passw] ? MAINCOLOR : RGBA(105, 105, 105, 1);
    }];
    RAC(self.saveBtn,enabled) = [RACSignal combineLatest:@[self.password.rac_textSignal,self.PasswordAgain.rac_textSignal] reduce:^id _Nullable(NSString *passw,NSString *again){
        
        return passw.length >= 6 && [again isEqualToString:passw] ? @YES : @NO;
    }];
    
}
- (IBAction)save:(id)sender {
    __weak typeof(self) weakSelf = self;
//    [NavigateManager showLoadingMessage:@"正在保存..."];
//    [[RequestManager sharedManager] updatePic:nil
//                                   parameters:@{@"username":USERID,
//                                                @"password":self.password.text,
//                                                @"validate_code":self.validate_code}
//                                     response:^(id response) {
//                                         if (response) {
//                                             [NavigateManager showMessage:@"修改成功"];
////                                             [UserData reWriteUserInfo:response[@"r"][@"cnName"] ForKey:@"cnName"];
//                                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                                 [weakSelf popViewControllerAtLastIndex:3];
//                                             });
//                                         } else {
//                                             [NavigateManager showMessage:@"修改失败，请重试"];
//                                         }
//                                     }];
    [[[RequestManager sharedManager] RACRequestUrl:URL_LOGIN_EDIT_PASSWORD
                                           method:POST
                                           loding:@""
                                              dic:@{@"username":USERID,
                                                    @"password":self.password.text,
                                                    @"validate_code":self.validate_code}] subscribeNext:^(id  _Nullable x) {
        [NavigateManager showMessage:@"修改成功"];
        //                                             [UserData reWriteUserInfo:response[@"r"][@"cnName"] ForKey:@"cnName"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf popViewControllerAtLastIndex:3];
        });

    }];
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
