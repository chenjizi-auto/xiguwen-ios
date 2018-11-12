//
//  SCchangeJIageViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SCchangeJIageViewController.h"

@interface SCchangeJIageViewController ()

@end

@implementation SCchangeJIageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改价格";
    [self addRightBtnWithTitle:@"确定" image:nil];
    [self addPopBackBtn];
    if (self.model.goods.count > 0) {
        [self.goodsImage sd_setImageWithUrl:self.model.goods[0].goods_image placeHolder:[UIImage imageNamed:@"占位图片"]];
        self.shopName.text = self.model.goods[0].goods_name;
        self.yanseChima.text = [NSString stringWithFormat:@"%@",self.model.goods[0].specification];
        self.priceD.text = [NSString stringWithFormat:@"¥ %@",self.model.goods[0].price];
        self.number.text = [NSString stringWithFormat:@"x %ld",self.model.goods[0].quantity];
    }
    self.changeJinge.delegate = self;
    self.changeJinge.inputAccessoryView = [self addToolbar];
}

- (void)respondsToRightBtn {
    if (self.changeJinge.text.length == 0) {
        [NavigateManager showMessage:@"总价不能为空"];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.changeJinge.text forKey:@"newprice"];
    [dic setValue:@(self.model.order_id) forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/modiorderprice"]
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
