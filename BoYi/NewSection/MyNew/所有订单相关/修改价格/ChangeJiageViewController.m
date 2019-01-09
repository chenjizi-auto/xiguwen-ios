//
//  ChangeJiageViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChangeJiageViewController.h"

@interface ChangeJiageViewController ()

@end

@implementation ChangeJiageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改价格";
    [self addRightBtnWithTitle:@"确定" image:nil];
    [self addPopBackBtn];
    
    [self.goodsImage sd_setImageWithUrl:self.model.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = self.model.baojia_name;
    self.time.text = self.model.specification;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",self.model.baojia_price];
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",self.model.yuandingjin];
    self.number.text = [NSString stringWithFormat:@"x %ld",self.model.quantity];
    
    if (self.model.paytype == 1) {
        self.isMoneyType.text = @"全款";
    }else if (self.model.paytype == 2) {
        self.isMoneyType.text = @"定金+尾款";
    }else {
        self.isMoneyType.text = @"定金+线下";
    }
    if (self.model.paytype == 1) {//全款
        self.viewType.hidden = YES;
        self.tiename.text = @"单价改为：";
        
        
    }else {
        self.viewType.hidden = NO;
        self.tiename.text = @"定金改为：";
        self.changeDJ.placeholder = @"请输入修改后的定金";
    }
    self.changeDingJing.delegate = self;
    self.changeDingJing.inputAccessoryView = [self addToolbar];
    self.changeDJ.delegate = self;
    self.changeDJ.inputAccessoryView = [self addToolbar];

}
- (void)respondsToRightBtn {
    
    if (self.model.paytype == 1) {//全款
        if (self.changeDJ.text.length == 0) {
            [NavigateManager showMessage:@"单价不能为空"];
            return;
        }
    }else {
        if (self.changeDJ.text.length == 0) {
            
            [NavigateManager showMessage:@"定金不能为空"];
            return;
        }
        if (self.changeDJ.text.length == 0) {
            [NavigateManager showMessage:@"尾款不能为空"];
            return;
        }
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.model.paytype == 1) {//全款
        [dic setValue:self.changeDJ.text forKey:@"price"];
        [dic setValue:@(self.model.order_id) forKey:@"id"];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    }else {
        [dic setValue:self.changeDJ.text forKey:@"price"];
        [dic setValue:self.changeDingJing.text forKey:@"weikuanprice"];
        [dic setValue:@(self.model.order_id) forKey:@"id"];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    }
    
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/modiprice"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已修改成功"];
                                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   [self popViewConDelay];
                                               });
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"请检查网络"];
                                           
                                       }];
}



@end
