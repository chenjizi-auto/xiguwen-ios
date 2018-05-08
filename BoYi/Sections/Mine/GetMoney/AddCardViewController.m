//
//  AddCardViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AddCardViewController.h"

@interface AddCardViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *bankName;
@property (weak, nonatomic) IBOutlet UITextField *cardNumbe;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = self.model ? @"修改银行卡" : @"新建银行卡";
    [self addPopBackBtn];
    
    if (self.model) {
        self.userName.text = self.model.name;
        self.bankName.text = self.model.cardname;
        self.cardNumbe.text = self.model.cardnumber;
    }
    
//    @weakify(self);
    RAC(self.saveBtn,backgroundColor) = [RACSignal combineLatest:@[self.userName.rac_textSignal,
                                                                   self.bankName.rac_textSignal,
                                                                   self.cardNumbe.rac_textSignal] reduce:^id _Nullable(NSString *name,NSString *bankName,NSString *card){
    
        return name.length > 0 && bankName.length > 0 && card.length >= 16 ? MAINCOLOR : RGBA(105, 105, 105, 1);
    }];
    RAC(self.saveBtn,enabled) = [RACSignal combineLatest:@[self.userName.rac_textSignal,
                                                                   self.bankName.rac_textSignal,
                                                                   self.cardNumbe.rac_textSignal] reduce:^id _Nullable(NSString *name,NSString *bankName,NSString *card){
                                                                       
                                                                       return name.length > 0 && bankName.length > 0 && card.length >= 16 ? @YES : @NO;
                                                                   }];
}

/**
 保存

 @param sender 按钮
 */
- (IBAction)save:(id)sender {
    
    
    @weakify(self);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"name":self.userName.text,
                                                                               @"cardname":self.bankName.text,
                                                                               @"cardnumber":self.cardNumbe.text,
                                                                               @"userid":@([UserData sharedManager].userInfoModel.id),
                                                                               @"username":USERID}];
    if (self.model) {
        [dic setObject:@(self.model.id) forKey:@"id"];
    }
    
    
    [[[RequestManager sharedManager] RACRequestUrl:self.model ? URL_updateCardById : URL_INSERT_CARD
                                            method:POST
                                            loding:@"加载中..."
                                               dic:dic] subscribeNext:^(id  _Nullable x) {
        //
        @strongify(self);
        [NavigateManager showMessage:self.model ? @"修改成功" : @"添加成功"];
        
        //刷新
        [self.refreshSubject sendNext:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self popViewConDelay];
        });
        
    }];
}



- (RACSubject *)refreshSubject {
    if (!_refreshSubject) {
        _refreshSubject = [RACSubject subject];
    }
    return _refreshSubject;
}

@end
