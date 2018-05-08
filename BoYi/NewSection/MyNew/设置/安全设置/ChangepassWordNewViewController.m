//
//  ChangepassWordNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChangepassWordNewViewController.h"
#import "ChangePassTwoViewController.h"
#import "JKCountDownButton.h"

@interface ChangepassWordNewViewController ()
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *phone;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *ver;
@property (strong,nonatomic) RACCommand *getCodeCommand;
@property (weak, nonatomic) IBOutlet JKCountDownButton *verTypeBtn;

@end

@implementation ChangepassWordNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.ifForgetPw) {
        self.navigationItem.title = @"忘记密码";
        self.phone.enabled = YES;
    } else {
        self.navigationItem.title = _isPayPw ? @"修改支付密码" : @"修改登录密码";
        self.phone.text = [UserDataNew sharedManager].userInfoModel.user.mobile;
    }
    
    [self addPopBackBtn];
    
    
    //获取验证码结果
    @weakify(self); [self.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [NavigateManager showMessage:@"验证码获取成功"];
       
        //button type要 设置成custom 否则会闪动
        [self.verTypeBtn startWithSecond:60.0];
        self.verTypeBtn.enabled = NO;
        self.verTypeBtn.backgroundColor = [UIColor grayColor];
        [self.verTypeBtn didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        [self.verTypeBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            
            self.verTypeBtn.backgroundColor = MAINCOLOR;
            return @"重新获取";
        }];
    }];
    self.phone.delegate = self;
    self.ver.delegate = self;
    self.phone.inputAccessoryView = [self addToolbar];
    self.ver.inputAccessoryView = [self addToolbar];
}
- (void)next {
    
    ChangePassTwoViewController *iphone = [[ChangePassTwoViewController alloc] init];
    iphone.isPayPw = self.isPayPw;
    iphone.phone = self.phone.text;
    iphone.ver = self.ver.text;
    [self pushToNextVCWithNextVC:iphone];
}
/**
 获取验证码
 
 @param sender 按钮
 */
- (IBAction)getCodeBtn:(JKCountDownButton *)sender {
    if (self.phone.text.length != 11) {
        [NavigateManager showMessage:@"请输入正确的手机号码"];
        return;
    }
    //获取验证码
    [self.getCodeCommand execute:@{@"mobile":self.phone.text,
                                   @"type":@"findpwd"}];
}

/**
 注册
 
 @param sender 按钮
 */
- (IBAction)completeBtn:(id)sender {
    if (self.phone.text.length != 11) {
        [NavigateManager showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (self.ver.text.length != 6) {
        [NavigateManager showMessage:@"请输入正确的验证码"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.phone.text forKey:@"mobile"];
    [dic setObject:self.ver.text forKey:@"code"];
    
    
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:URL_New_findpassone
                                            method:POST
                                            loding:@"提交中..."
                                               dic:dic] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [self next];
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



//获取验证码
- (RACCommand *)getCodeCommand {
    
    if (!_getCodeCommand) {
        
        
        _getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_getcode
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _getCodeCommand;
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
