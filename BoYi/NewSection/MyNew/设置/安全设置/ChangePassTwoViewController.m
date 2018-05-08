//
//  ChangePassTwoViewController.m
//  BoYi
//
//  Created by heng on 2018/1/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChangePassTwoViewController.h"

@interface ChangePassTwoViewController ()
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *OldPassword;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *NewPassword;

@end

@implementation ChangePassTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addPopBackBtn];
    self.navigationItem.title = _isPayPw ? @"修改支付密码" : @"修改登录密码";
    if (!_isPayPw) {
        self.NewPassword.keyboardType = UIKeyboardTypeDefault;
        self.OldPassword.keyboardType = UIKeyboardTypeDefault;
    }
    self.OldPassword.delegate = self;
    self.NewPassword.delegate = self;
    self.OldPassword.inputAccessoryView = [self addToolbar];
    self.NewPassword.inputAccessoryView = [self addToolbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)complete:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.phone forKey:@"mobile"];
    [dic setObject:self.ver forKey:@"code"];
    [dic setObject:self.NewPassword.text forKey:@"password"];
    if (_isPayPw) {
        [dic setObject:self.OldPassword.text forKey:@"repassword"];
    }
    
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:_isPayPw ? URL_repaypwd : URL_New_findpasstwo
                                            method:POST
                                            loding:@"提交中..."
                                               dic:dic] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        [NavigateManager showMessage:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
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
