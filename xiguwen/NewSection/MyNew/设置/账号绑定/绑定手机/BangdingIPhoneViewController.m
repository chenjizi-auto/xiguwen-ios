//
//  BangdingIPhoneViewController.m
//  BoYi
//
//  Created by heng on 2018/1/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "BangdingIPhoneViewController.h"
#import "BangdingArterView.h"
#import "JKCountDownButton.h"

@interface BangdingIPhoneViewController ()
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *phone;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *ver;
@property (weak, nonatomic) IBOutlet JKCountDownButton *verTypeBtn;
@property (strong,nonatomic) RACCommand *getCodeCommand;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation BangdingIPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"改绑手机号";
    [self addPopBackBtn];
    if (_newPhone) {
        self.phone.enabled = YES;
        self.phone.placeholder = @"请输入新绑定手机号";
    } else {
        self.phone.enabled = NO;
        self.phone.text = [UserDataNew sharedManager].userInfoModel.user.mobile;
    }
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
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 64.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)next {
    if (_newPhone) {

        [self successacAlert];
        
    } else {
        BangdingIPhoneViewController *vc = [[BangdingIPhoneViewController alloc] init];
        vc.newPhone = YES;
        vc.code = self.ver.text;
        vc.mobile = self.phone.text;
        [self pushToNextVCWithNextVC:vc];
    }
}

- (void)successacAlert {
    __weak typeof(self) weakSelf = self;
    BangdingArterView *piker = [BangdingArterView showInView:weakSelf.view title:@"绑定成功" message:@"更改绑定手机成功！"];
    piker.block = ^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    };
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
    NSString *type = _newPhone ? @"register" : @"findpwd ";
    [self.getCodeCommand execute:@{@"mobile":self.phone.text,
                                   @"type":type}];
}

/**
 注册
 
 @param sender 按钮
 */
- (IBAction)completeBtn:(id)sender {
    
    // 收起键盘
    [self.view endEditing:YES];
    if (self.phone.text.length != 11) {
        [NavigateManager showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (self.ver.text.length != 6) {
        [NavigateManager showMessage:@"请输入正确的验证码"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    
    NSString *url;
    if (_newPhone) {
        url = [HOMEURL stringByAppendingString:@"appapi/index/upmobiles"];
        
        [dic setObject:self.phone.text forKey:@"xmobile"];
        [dic setObject:self.ver.text forKey:@"xcode"];
        [dic setObject:self.mobile forKey:@"mobile"];
        [dic setObject:self.code forKey:@"code"];
    } else {
        [dic setObject:self.phone.text forKey:@"mobile"];
        [dic setObject:self.ver.text forKey:@"code"];
        
        url = [HOMEURL stringByAppendingString:@"appapi/index/upmobile"];
    }
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:url
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
