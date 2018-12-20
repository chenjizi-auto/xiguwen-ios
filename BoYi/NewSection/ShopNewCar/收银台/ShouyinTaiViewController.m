//
//  ShouyinTaiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShouyinTaiViewController.h"
#import "ShouyinTableViewCell.h"
#import "WeChatPayManager.h"
#import "HunQinOrderSubViewController.h"
#import "MyNewViewController.h"
#import "XLPasswordView.h"

#import <CommonCrypto/CommonCrypto.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZLHTTPSessionManager.h"
#import "ZLIntegralGoodsOrderDetailViewController.h"


@interface ShouyinTaiViewController ()<UITableViewDelegate,UITableViewDataSource,XLPasswordViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *namess;
@property (nonatomic, strong) XLPasswordView *passwordView;
@property (strong,nonatomic) NSMutableArray *isSele;

///订单id(支付时，后台会给，支付后，根据需求跳转到订单详情)
@property (nonatomic,strong) NSString *orderId;

@end

@implementation ShouyinTaiViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收银台";
    if (isIPhoneX) {
        self.height.constant = 96;
    }
    [self addPopBackBtn];
    self.images = @[@"支付宝支付",@"微信支付",@"账户余额支付"];
    self.namess = @[@"支付宝支付",@"微信支付",@"账户余额支付"];
    
    self.hejiprice.text = [NSString stringWithFormat:@"￥%@",self.price];
    NSArray *sele = @[@0,@0,@0,@0];
    self.isSele = [NSMutableArray arrayWithArray:sele];
    [self.table registerNib:[UINib nibWithNibName:@"ShouyinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShouyinTableViewCell"];
    self.table.delegate             = self;
    self.table.dataSource           = self;
    //付款成功
    @weakify(self);
    
    __weak typeof(self)weakSelf = self;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALIPAY_PAY_RESULT_NOTIFACATION object:nil];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:ALIPAY_PAY_RESULT_NOTIFACATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if ([x.object integerValue] == 9000) {
            [NavigateManager showMessage:@"付款成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.type == 6 || self.type == 8) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else {
                    if (weakSelf.integral) {
                        weakSelf.interfaceType == ZLCheckstandInterfaceTypeIntegralSureOrder
                        //前往订单详情
                        ? [weakSelf goToIntegralGoodsOrderDetail]
                        //回到订单详情
                        : [weakSelf popViewConDelay];
                    }else {
                        self.navigationController.tabBarController.selectedIndex = 4;
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }
            });
        }
    }];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WECHAT_PAY_RESULT_NOTIFACATION object:nil];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WECHAT_PAY_RESULT_NOTIFACATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if ([x.object integerValue] == 0) {
            [NavigateManager showMessage:@"付款成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.type == 6 || self.type == 8) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else {
                    if (weakSelf.integral) {
                        weakSelf.interfaceType == ZLCheckstandInterfaceTypeIntegralSureOrder
                        //前往订单详情
                        ? [weakSelf goToIntegralGoodsOrderDetail]
                        //回到订单详情
                        : [weakSelf popViewConDelay];
                    }else {
                        self.navigationController.tabBarController.selectedIndex = 4;
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }
            });
        }
    }];
}

- (void)popViewConDelay{
    if (self.integral) {
        if (self.reloadPreviousPageData) {
            self.reloadPreviousPageData();
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (XLPasswordView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[XLPasswordView alloc] init];
        _passwordView.delegate = self;
    }
    return _passwordView;
}
- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password {
    
    //积分商品余额支付
    if (self.integral) {
        [self balancePay:password];
        return;
    }
    
    
    // 输入密码位数已满时调用
    [self.passwordView clearPassword];
    [self.passwordView hidePasswordView];
    if (self.type == 1) {//婚庆立即购买
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/carthq/moneypaywedding"] method:POST loding:@"" dic:@{@"pwd":password, @"id":self.orderNumber, @"token":[UserDataNew sharedManager].userInfoModel.token.token, @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)} progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                [NavigateManager showMessage:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.tabBarController.selectedIndex = 4;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [NavigateManager showMessage: response[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:@"支付失败"];
        }];
    }else if (self.type == 2) {
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/carthq/moneypaywedding"] method:POST loding:@"" dic:@{@"pwd":password, @"pid":self.bianhao, @"token":[UserDataNew sharedManager].userInfoModel.token.token, @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)} progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                [NavigateManager showMessage:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.tabBarController.selectedIndex = 4;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [NavigateManager showMessage: response[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:@"支付失败"];
        }];
    }else if (self.type == 3) {
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/cart/shopmoneypay"] method:POST loding:@"" dic:@{@"pwd":password, @"id":self.orderNumber, @"token":[UserDataNew sharedManager].userInfoModel.token.token, @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)} progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                [NavigateManager showMessage:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.tabBarController.selectedIndex = 4;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [NavigateManager showMessage: response[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:@"支付失败"];
        }];
    }else if (self.type == 4) {
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/cart/shopmoneypay"] method:POST loding:@"" dic:@{@"pwd":password, @"id":self.bianhao, @"token":[UserDataNew sharedManager].userInfoModel.token.token, @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)} progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                [NavigateManager showMessage:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.tabBarController.selectedIndex = 4;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [NavigateManager showMessage: response[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:@"支付失败"];
        }];
    }else if (self.type == 5) {
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Authentication/zhifu"] method:POST loding:@"" dic:@{@"id":self.bianhao, @"pwd":password, @"token":[UserDataNew sharedManager].userInfoModel.token.token, @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid), @"pay":@"yue"} progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                [NavigateManager showMessage:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.tabBarController.selectedIndex = 4;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else{
                [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:@"网络连接失败"];
        }];
    }else if (self.type == 7) {
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/carthq/moneypayweddingwk"] method:POST loding:@"" dic:@{@"pwd":password, @"orderid":self.bianhao, @"token":[UserDataNew sharedManager].userInfoModel.token.token, @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)} progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                [NavigateManager showMessage:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.tabBarController.selectedIndex = 4;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [NavigateManager showMessage: response[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:@"支付失败"];
        }];
    }else if (self.type == 6) {
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Member/flowsheet"] method:POST loding:@"" dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token, @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid), @"money":self.price, @"type":@"yue", @"pwd":password} progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [NavigateManager showMessage:response[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:error.localizedDescription];
        }];
    }else if (self.type == 8) {
        WeakSelf(self);
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:self.dicm8];
        [dicInfo setObject:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dicInfo setObject:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dicInfo setObject:@"yue" forKey:@"type"];
        [dicInfo setObject:password forKey:@"pwd"];
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Member/flowsheetshop"] method:POST loding:@"" dic:dicInfo progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                [NavigateManager hiddenLoadingMessage];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [NavigateManager showMessage:response[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:error.localizedDescription];
        }];
    }
}

- (IBAction)sureAC:(UIButton *)sender {
    
    //积分商品结算
    if (self.integral) {
        [self settlement];
        return;
    }
    
    
    NSInteger index = 0;
    [self.dicm setObject:@"" forKey:@"typeus"];
    [self.dicm1 setObject:@"" forKey:@"typeus"];
    [self.dicm3 setObject:@"" forKey:@"type"];
    if ([self.isSele[0] integerValue] == 1) {
        [self.dicm setObject:@"alipay" forKey:@"typeus"];
        [self.dicm1 setObject:@"alipay" forKey:@"typeus"];
        [self.dicm3 setObject:@"alipay" forKey:@"type"];
        index = 1;
    }
    if ([self.isSele[1] integerValue] == 1) {
        [self.dicm setObject:@"wxpay" forKey:@"typeus"];
        [self.dicm1 setObject:@"wxpay" forKey:@"typeus"];
        [self.dicm3 setObject:@"wxpay" forKey:@"type"];
        index = 2;
    }
    if ([self.isSele[2] integerValue] == 1) {
        [self.dicm setObject:@"yue" forKey:@"typeus"];
        [self.dicm1 setObject:@"yue" forKey:@"typeus"];
        [self.dicm3 setObject:@"yue" forKey:@"type"];
        index = 3;
    }
    if (index == 0) {
        [NavigateManager showMessage:@"请选择支付方式"];
        return;
    }
    NSString *idbianhao;
    if (index == 1) {
        idbianhao = @"alipay";
    }
    if (index == 2) {
        idbianhao = @"wxpay";
    }
    if (index == 3) {
        
    }
    //婚庆立即购买
    if (self.type == 1) {
        if (index == 3) {
            [self.passwordView showPasswordInView:self.view];
        }else {
            [self.dicm1 setObject:@"" forKey:@"remark"];
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/example/hunqindindanapp"] method:POST loding:@"" dic:@{@"id":self.orderNumber,@"type":idbianhao} progress:nil success:^(NSURLSessionDataTask *task, id response) {
                [NavigateManager hiddenLoadingMessage];
                sender.enabled = YES;
                if ([response[@"code"] integerValue] == 0) {
                    [NavigateManager hiddenLoadingMessage];
                    [WeChatPayManager payWithType:index info:response[@"data"] vc:self block:^(NSDictionary *response) {
                    }];
                }else{
                    [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                sender.enabled = YES;
                [NavigateManager showMessage:@"网络连接失败"];
            }];
//            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/buyweddingapp"] method:POST loding:@"" dic:self.dicm1 progress:nil success:^(NSURLSessionDataTask *task, id response) {
//                if ([response[@"code"] integerValue] == 0) {
//
//                }else{
//                    sender.enabled = YES;
//                    [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
//                }
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                sender.enabled = YES;
//                [NavigateManager showMessage:@"网络连接失败"];
//            }];
        }
    }
    if (self.type == 2) {
        if (index == 3) {
            [self.passwordView showPasswordInView:self.view];
        }else {
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/example/hunqindindanapp"] method:POST loding:@"" dic:@{@"id":self.bianhao,@"type":idbianhao} progress:nil success:^(NSURLSessionDataTask *task, id response) {
                [NavigateManager hiddenLoadingMessage];
                sender.enabled = YES;
                if ([response[@"code"] integerValue] == 0) {
                    [NavigateManager hiddenLoadingMessage];
                    [WeChatPayManager payWithType:index info:response[@"data"] vc:self block:^(NSDictionary *response) {
                    }];
                }else{
                    [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                sender.enabled = YES;
                [NavigateManager showMessage:@"网络连接失败"];
            }];
        }
    }
    if (self.type == 3) {
        if (index == 3) {
            [self.passwordView showPasswordInView:self.view];
        }else {
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/example/zhifudindanapp"] method:POST loding:@"" dic:@{@"id":self.orderNumber,@"type":idbianhao} progress:nil success:^(NSURLSessionDataTask *task, id response) {
                [NavigateManager hiddenLoadingMessage];
                sender.enabled = YES;
                if ([response[@"code"] integerValue] == 0) {
                    [NavigateManager hiddenLoadingMessage];
                    [WeChatPayManager payWithType:index info:response[@"data"] vc:self block:^(NSDictionary *response) {
                    }];
                }else{
                    [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                sender.enabled = YES;
                [NavigateManager showMessage:@"网络连接失败"];
            }];
//            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/createorderapp"] method:POST loding:@"" dic:self.dicm3 progress:nil success:^(NSURLSessionDataTask *task, id response) {
//                if ([response[@"code"] integerValue] == 0) {
//
//                }else{
//                    sender.enabled = YES;
//                    [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
//                }
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                sender.enabled = YES;
//                [NavigateManager showMessage:@"网络连接失败"];
//            }];
        }
    }
    if (self.type == 4) {
        if (index == 3) {
            [self.passwordView showPasswordInView:self.view];
        }else {
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/example/zhifudindanapp"] method:POST loding:@"" dic:@{@"id":self.bianhao,@"type":idbianhao} progress:nil success:^(NSURLSessionDataTask *task, id response) {
                [NavigateManager hiddenLoadingMessage];
                sender.enabled = YES;
                if ([response[@"code"] integerValue] == 0) {
                    [NavigateManager hiddenLoadingMessage];
                    [WeChatPayManager payWithType:index info:response[@"data"] vc:self block:^(NSDictionary *response) {
                    }];
                }else{
                    [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                sender.enabled = YES;
                [NavigateManager showMessage:@"网络连接失败"];
            }];
        }
    }
    if (self.type == 5) {
        if (index == 3) {
            [self.passwordView showPasswordInView:self.view];
        }else {
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Authentication/zhifu"] method:POST loding:@"" dic:@{@"id":self.bianhao, @"pay":idbianhao} progress:nil success:^(NSURLSessionDataTask *task, id response) {
                [NavigateManager hiddenLoadingMessage];
                sender.enabled = YES;
                if ([response[@"code"] integerValue] == 0) {
                    [NavigateManager hiddenLoadingMessage];
                    [WeChatPayManager payWithType:index info:response[@"data"] vc:self block:^(NSDictionary *response) {
                    }];
                }else{
                    [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                sender.enabled = YES;
                [NavigateManager showMessage:@"网络连接失败"];
            }];
        }
    }
    if (self.type == 7) {
        if (index == 3) {
            [self.passwordView showPasswordInView:self.view];
        }else {
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/example/weikuanzhifuapp"] method:POST loding:@"" dic:@{@"id":self.bianhao,@"type":idbianhao} progress:nil success:^(NSURLSessionDataTask *task, id response) {
                [NavigateManager hiddenLoadingMessage];
                sender.enabled = YES;
                if ([response[@"code"] integerValue] == 0) {
                    [NavigateManager hiddenLoadingMessage];
                    [WeChatPayManager payWithType:index info:response[@"data"] vc:self block:^(NSDictionary *response) {
                        NSLog(@"c");
                    }];
                }else{
                    [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                sender.enabled = YES;
                [NavigateManager showMessage:@"网络连接失败"];
            }];
        }
    }else if (self.type == 6) {
        if (index == 3) {
            [self.passwordView showPasswordInView:self.view];
        }else {
            WeakSelf(self);
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Member/flowsheet"] method:POST loding:@"" dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token, @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid), @"money":self.price, @"type":idbianhao} progress:nil success:^(NSURLSessionDataTask *task, id response) {
                if ([response[@"code"] integerValue] == 0) {
                    [NavigateManager hiddenLoadingMessage];
                    [WeChatPayManager payWithType:index info:response[@"data"] vc:weakSelf block:^(NSDictionary *response) {
                    }];
                } else {
                    [NavigateManager showMessage:response[@"message"]];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [NavigateManager showMessage:error.localizedDescription];
            }];
        }
    }else if (self.type == 8) {
        if (index == 3) {
            [self.passwordView showPasswordInView:self.view];
        }else {
            WeakSelf(self);
            NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:self.dicm8];
            [dicInfo setObject:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dicInfo setObject:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dicInfo setObject:idbianhao forKey:@"type"];
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Member/flowsheetshop"] method:POST loding:@"" dic:dicInfo progress:nil success:^(NSURLSessionDataTask *task, id response) {
                if ([response[@"code"] integerValue] == 0) {
                    [NavigateManager hiddenLoadingMessage];
                    [WeChatPayManager payWithType:index info:response[@"data"] vc:weakSelf block:^(NSDictionary *response) {
                    }];
                } else {
                    [NavigateManager showMessage:response[@"message"]];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [NavigateManager showMessage:error.localizedDescription];
            }];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShouyinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShouyinTableViewCell"];
    cell.image.image = [UIImage imageNamed:self.images[indexPath.row]];
    cell.name.text = self.namess[indexPath.row];
    cell.gouImage.hidden = [self.isSele[indexPath.row] integerValue] == 1 ? NO : YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (int i = 0; i < self.isSele.count; i++) {
        NSArray *sele = @[@0,@0,@0,@0];
        [self.isSele removeAllObjects];
        self.isSele = [NSMutableArray arrayWithArray:sele];
    }
    [self.isSele replaceObjectAtIndex:indexPath.row withObject:@1];
    [tableView reloadData];
}


/**---------------------------------------- 新增 -------------------------------------------**/

#pragma mark - Settlement 结算
- (void)settlement {
    NSInteger number = 0;
    BOOL isDidSelected = NO;
    for (NSInteger index = 0; index < self.isSele.count; index++) {
        NSInteger value = [self.isSele[index] integerValue];
        if (value) {
            isDidSelected = YES;
            number = index;
            break;
        }
    }
    if (!isDidSelected) {
        [NavigateManager showMessage:@"请选择支付方式"];
        return;
    }
    (number > 1)
    //余额支付，调起软键盘验证支付密码
    ? [self.passwordView showPasswordInView:self.view]
    //金钱支付，使用支付宝、微信等平台API
    : [self integralGoodsMoneyPayWithType:number];
}

#pragma mark - IntegralGoodsMoneyPay 平台支付
- (void)integralGoodsMoneyPayWithType:(BOOL)isWeChat {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"ordersn"] = self.bianhao;
    dictM[@"type"] = isWeChat ? @"wxpay" : @"alipay";
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    __weak typeof(self)weakSelf = self;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/xuxianjinzhifu" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if ([responseObject[@"code"] integerValue]) {
                [NavigateManager showMessage:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
                return;
            }
            weakSelf.orderId = responseObject[@"orderid"];
            isWeChat
            //微信支付
            ? [weakSelf weChatPayWithResponseObject:responseObject[@"data"]]
            //支付宝支付
            : [weakSelf alipayWithOrderString:responseObject[@"data"][@"data"]];
            return;
        }
    }];
}
- (void)alipayWithOrderString:(NSString *)orderString {
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"boyi028" callback:^(NSDictionary *resultDic) {}];
}
- (void)weChatPayWithResponseObject:(NSDictionary *)responseObject {
    if (![WXApi isWXAppInstalled]) {
        [NavigateManager showMessage:@"用户未安装微信"];
        return;
    }
    if (![WXApi isWXAppSupportApi]) {
        [NavigateManager showMessage:@"当前微信的版本不支持微信支付"];
        return;
    }
    //集成请求字符串
    PayReq *req=[[PayReq alloc] init];
    req.openID = responseObject[@"appid"];
    req.partnerId = responseObject[@"partnerid"];
    req.prepayId = responseObject[@"prepayid"];
    req.nonceStr = responseObject[@"noncestr"];
    req.timeStamp = [responseObject[@"timestamp"] intValue];
    req.package = responseObject[@"package"];
    req.sign = responseObject[@"sign"] ;
    //唤起微信
    [WXApi sendReq:req];
}
- (NSString *)MD5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), digest); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

#pragma mark - BalancePay 余额支付
- (void)balancePay:(NSString *)password {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"ordersn"] = self.bianhao;
    dictM[@"pwd"] = password;
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    __weak typeof(self)weakSelf = self;
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.boyihunjia.com/appapi/integral/yuezhifu" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if ([responseObject[@"code"] integerValue]) {
                [NavigateManager showMessage:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
                return;
            }
            if (weakSelf.interfaceType == ZLCheckstandInterfaceTypeIntegralSureOrder) {
                //前往订单详情
                weakSelf.orderId = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
                [weakSelf goToIntegralGoodsOrderDetail];
            }else {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            return;
        }
    }];
}

#pragma mark - GoToIntegralGoodsOrderDetail 去往订单详情页
- (void)goToIntegralGoodsOrderDetail {
    ZLIntegralGoodsOrderDetailViewController *integralGoodsOrderDetailVc = [ZLIntegralGoodsOrderDetailViewController new];
    integralGoodsOrderDetailVc.keyId = self.orderId;
    integralGoodsOrderDetailVc.token = [UserDataNew sharedManager].userInfoModel.token.token;
    integralGoodsOrderDetailVc.userId = [NSString stringWithFormat:@"%ld",[UserDataNew sharedManager].userInfoModel.token.userid];
    integralGoodsOrderDetailVc.interfaceType = ZLOrderDetailInterfaceTypeCheckstandInterface;
    [self.navigationController pushViewController:integralGoodsOrderDetailVc animated:YES];
}

/**---------------------------------------- 结束 -------------------------------------------**/

@end

