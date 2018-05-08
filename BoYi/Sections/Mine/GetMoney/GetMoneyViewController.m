//
//  GetMoneyViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "GetMoneyViewController.h"
#import "AddCardViewController.h"
#import "MyBanksViewController.h"

@interface GetMoneyViewController ()
    
@property (weak, nonatomic) IBOutlet UIView *NoCardView;
@property (weak, nonatomic) IBOutlet UIButton *getMoneyBtn;
@property (weak, nonatomic) IBOutlet UITextField *money;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *cardNumber;
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;

@property (strong,nonatomic) NSMutableArray <GetMoneyModel *>*cardArray;

@end

@implementation GetMoneyViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我要提现";
    [self addPopBackBtn];
    
    [self addRightBtnWithTitle:@"明细" image:nil];
    RAC(self.getMoneyBtn,backgroundColor) = [RACSignal combineLatest:@[self.money.rac_textSignal] reduce:^id _Nullable(NSString *money){
        
        return money.length > 0 && [money floatValue] >= 1 ? MAINCOLOR : RGBA(105, 105, 105, 1);
    }];
    RAC(self.getMoneyBtn,enabled) = [RACSignal combineLatest:@[self.money.rac_textSignal] reduce:^id _Nullable(NSString *money){
        
        return money.length > 0 && [money floatValue] >= 1 ? @YES : @NO;
    }];

    
    
    [self loadData];
}


#pragma mark - 点击事件


/**
 修改银行卡信息

 @param sender 按钮
 */
- (IBAction)changeBankInfo:(id)sender {
    
    MyBanksViewController *vc = [[MyBanksViewController alloc] init];
    vc.isChoose = YES;
    @weakify(self);
    [vc.chooseBankSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        self.cardArray = @[x].mutableCopy;
        [self showInfo];
        
    }];
    [self pushToNextVCWithNextVC:vc];
}

/**
 右边点击事件
 */
- (void)respondsToRightBtn {
    [self pushToNextvcWithNextVCTitle:@"GetMoneyListViewController"];
}

/**
 绑定银行卡
 */
- (IBAction)bindCard:(id)sender {
    AddCardViewController *vc = [[AddCardViewController alloc] init];
    @weakify(self);
    [vc.refreshSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [self loadData];
    }];
    [self pushToNextVCWithNextVC:vc];
}

/**
 提现

 @param sender 按钮
 */
- (IBAction)getMoney:(id)sender {
    
//    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:URL_insertCardLog
                                            method:POST
                                            loding:@"提交中..."
                                               dic:@{@"cardid":@(self.cardArray.firstObject.id),
                                                     @"money":self.money.text,
                                                     @"creater":USERID,
                                                     @"userid":@([UserData sharedManager].userInfoModel.id)}] subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        [NavigateManager showMessage:@"提现申请提交成功，请等待审核"];
    }];
    
}


#pragma mark - public api
/**
 展示
 */
- (void)showInfo {
    
    
    
    self.bankName.text = self.cardArray.firstObject.cardname;
    self.cardNumber.text = self.cardArray.firstObject.cardnumber;
    
    
}

#pragma mark - private api

- (void)loadDataShow:(id)data {
    if (!self.cardArray) {
        self.cardArray = [NSMutableArray array];
    } else {
        [self.cardArray removeAllObjects];
    }
    
    [self.cardArray addObjectsFromArray:[GetMoneyModel mj_objectArrayWithKeyValuesArray:data]];
}



/**
 请求
 */
- (void)loadData {
    
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:URL_FIND_ALL_CARD
                                            method:POST
                                            loding:@"加载中..."
                                               dic:@{@"userid":@([UserData sharedManager].userInfoModel.id)}]
                                    subscribeNext:^(id  _Nullable x) {
        //
                                        @strongify(self);
                                        
                                        if ([x count] == 0) {
                                            self.NoCardView.hidden = NO;
                                        } else {
                                            
                                            self.NoCardView.hidden = YES;
                                            [self loadDataShow:x];
                                            [self showInfo];
                                        }
                                        
    }];
    
}

@end

@implementation GetMoneyModel



@end
