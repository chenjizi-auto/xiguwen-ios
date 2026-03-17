//
//  ShangJiaVIPViewController.m
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangJiaVIPViewController.h"
#import "KaiTongVIPView.h"
#import "WeChatPayManager.h"
#import "ShouyinTaiViewController.h"
#import "IAPManager.h"
@interface ShangJiaVIPViewController ()<IAPManagerDelegate>

@property (nonatomic, assign) NSInteger isOpenVip;
@property (nonatomic, copy) NSDictionary *priceInfo ;
@property (weak, nonatomic) IBOutlet UIButton *openVipBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ShangJiaVIPViewController

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

-(void) showPage{
    WeakSelf(self);
    [[RequestManager sharedManager] requestUrl:URL_checkShopVip
                                        method:POST
                                        loding:@""
                                           dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
                                                 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
        weakSelf.isOpenVip = [[response[@"data"] objectForKey:@"isshopvip"] integerValue];
        [weakSelf.openVipBtn setUserInteractionEnabled:weakSelf.isOpenVip == 0 ? YES : NO];
        [weakSelf.openVipBtn setImage:[UIImage imageNamed:weakSelf.isOpenVip == 0 ? @"开通商家VIP" : @"已开通VIP"]  forState:(UIControlStateNormal)];
                                           weakSelf.priceInfo = response[@"data"];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
	// 请求数据判断是否是会员
    [self showPage];
}


- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	self.navigationController.navigationBarHidden = NO;
	
}

- (IBAction)popToView:(UIButton *)sender {
	[self popViewConDelay];
}


- (IBAction)turnOn:(UIButton *)sender {
    
    if (_isOpenVip) {
        
    }
    
	__weak typeof(self) weakSelf = self;
	KaiTongVIPView *view = [KaiTongVIPView showInView:weakSelf.view block:^(NSDictionary *dic) {
		
		
		//            NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
		
		//            [weakSelf.timeBtn setTitle:dateString forState:UIControlStateNormal];
		//            [weakSelf.dicm setObject:dateString forKey:@"schedule_date"];
//        [weakSelf requestPay:dic];
        if(YES){
            
        }else{
            WeakSelf(self);
            ShouyinTaiViewController *vc = [[ShouyinTaiViewController alloc] init];
            vc.type = 8;
            vc.dicm8 = [[NSMutableDictionary alloc] initWithDictionary:dic];
            vc.price = dic[@"money"];
            [weakSelf pushToNextVCWithNextVC:vc];
        }
	}];
    view.paySuccess = ^(NSString *model) {
        NSLog(@"apple pay model id is  %@ ",model);
        [IAPManager sharedManager].IAPDelegate = weakSelf;
        [[IAPManager sharedManager] addTheIAPObserver];
        [[IAPManager sharedManager] getProductInfo:model];
    };
    view.dicData = self.priceInfo;
	
}

//- (IBAction)turnOn:(UIButton *)sender {
//
//}
- (void)requestPay:(NSDictionary *)dic {
    
    
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dicInfo setObject:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dicInfo setObject:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];

    
    WeakSelf(self);
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Member/flowsheetshop"]
                                        method:POST
                                        loding:@""
                                           dic:dicInfo
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                           [WeChatPayManager payWithType:1 info:response[@"data"] vc:weakSelf block:^(NSDictionary *response) {
                                               
                                           }];
                                           } else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:error.localizedDescription];
                                       }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)sendIAPPaySuccessFunction:(NSString*)environment receipt:(NSString*)receipt{
    
    NSLog(@"sendIAPPaySuccessFunction %@ ",receipt);
    NSString *newReceipt = [receipt stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    // 请求数据判断是否是会员
    NSString *applePay =   [HOMEURL stringByAppendingString:@"appapi/applepay/verifyReceipt"];
    [[RequestManager sharedManager] requestUrl:applePay
                                        method:POST
                                        loding:@""
                                           dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
                                                 @"ios_data":newReceipt,
                                                 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                            [self showPage];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:error.domain];
                                       }];
    
    
    
//    NSDictionary *dic = @{@"receipt_data":receipt,@"goods_id":self.model.r_id,@"user_id":[UserManager userInfo].userid};
//    [HttpUtils applepayWithParameters:dic success:^(id response) {
//        if ([response[@"code"] intValue] == 1) {
//            [self getPriceList];
//            [NavigateManager showMessage:@"充值成功"];
//        }else{
//           [SVProgressHUD showSuccessWithStatus:response[@"message"]];
//        }
//    } failure:^(NSError *error) {
//        [NavigateManager showMessage:@"充值失败"];
//    }];
}


- (void)IAPFailedWithWrongInfor:(NSString *)informationStr {
    [NavigateManager showMessage:informationStr];
}

- (void)IAPPaySuccessFunctionWithBase64:(NSString *)base64Str {
//        NSLog(@"base64Str=%@",base64Str);
        NSString *sandbox;
        //判断环境
    #if  defined(DEBUG)
        sandbox = @"0";
    #else
        sandbox = @"1";
    #endif
        NSLog(@"环境====%@",sandbox);
        [self sendIAPPaySuccessFunction:sandbox receipt:base64Str];
}
@end
