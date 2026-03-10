#import "IAPManager.h"
#import "UserVIPViewController.h"
#import "KaiTongVIPView.h"
#import "WeChatPayManager.h"
#import "ShouyinTaiViewController.h"
@interface UserVIPViewController ()<IAPManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, assign) NSInteger isOpenVip;
@property (weak, nonatomic) IBOutlet UIButton *openVipBtn;
@property (nonatomic, copy) NSDictionary *myInfo;

@end

@implementation UserVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.headerImage sd_setImageWithUrl:[UserDataNew sharedManager].userInfoModel.user.head];
	[self.nameLabel setText:[UserDataNew sharedManager].userInfoModel.user.nickname];
    //付款成功
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:ALIPAY_PAY_RESULT_NOTIFACATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if ([x.object integerValue] == 9000) {
            [NavigateManager showMessage:@"开通成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
	
	// 请求数据判断是否是会员
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_checkMemeberVip
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   weakSelf.isOpenVip = [[response[@"data"] objectForKey:@"isshopvip"] integerValue];
										   [weakSelf.openVipBtn setUserInteractionEnabled:weakSelf.isOpenVip == 0 ? YES : NO];
										   [weakSelf.openVipBtn setImage:[UIImage imageNamed:weakSelf.isOpenVip == 0 ? @"开通用户VIP" : @"已开通VIP"] forState:(UIControlStateNormal)];
                                           weakSelf.myInfo = response[@"data"];
										   
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];
}

- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	self.navigationController.navigationBarHidden = NO;
	
}

- (IBAction)popToVIew:(UIButton *)sender {
	
	[self popViewConDelay];
}


- (IBAction)turnOn:(UIButton *)sender {
    
    
    
    [self requestPay];
//    __weak typeof(self) weakSelf = self;
//    [KaiTongVIPView showInView:weakSelf.view block:^(NSDictionary *dic) {
//
//        [weakSelf requestPay];
        //            NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
        
        //            [weakSelf.timeBtn setTitle:dateString forState:UIControlStateNormal];
        //            [weakSelf.dicm setObject:dateString forKey:@"schedule_date"];
//    }];
}
- (void)requestPay {
    // 请求数据判断是否是会员
    WeakSelf(self);
    ShouyinTaiViewController *vc = [[ShouyinTaiViewController alloc] init];
    vc.type = 6;
    vc.price = self.myInfo[@"vipmoney"];
    [weakSelf pushToNextVCWithNextVC:vc];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
