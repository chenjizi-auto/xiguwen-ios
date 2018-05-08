//
//  ShopWanchengView.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShopWanchengView.h"

@implementation ShopWanchengView
+ (ShopWanchengView *)showInView:(UIView *)view orderid:(NSString *)orderid block:(void(^)(NSMutableDictionary *dic))block{
    ShopWanchengView *alert = [[[NSBundle mainBundle]loadNibNamed:@"ShopWanchengView" owner:self options:nil]lastObject];
    
    alert.frame = view.frame;
    alert.block = block;
    alert.isShang = @"yes";
    alert.orderid = orderid;
    [alert showOnView:view];
    return alert;
}

- (IBAction)allaction:(UIButton *)sender {
    if (sender.tag == 0) {
        self.isShang = @"yes";
        [self.shangBtn setImage:[UIImage imageNamed:@"勾选商品"] forState:UIControlStateNormal];
        [self.xiaBtn setImage:[UIImage imageNamed:@"未勾选商品"] forState:UIControlStateNormal];
    }else if (sender.tag == 1) {
        self.isShang = @"no";
        [self.shangBtn setImage:[UIImage imageNamed:@"未勾选商品"] forState:UIControlStateNormal];
        [self.xiaBtn setImage:[UIImage imageNamed:@"勾选商品"] forState:UIControlStateNormal];
    }else if (sender.tag == 2) {
        [self hidden];
    }else {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:self.orderid forKey:@"id"];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        if ([self.isShang isEqualToString:@"yes"]) {
            [dic setValue:@"1" forKey:@"paymethod"];
        }else {
            [dic setValue:@"2" forKey:@"paymethod"];
        }
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/paypartfinishorder"]
                                            method:POST
                                            loding:@""
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   
                                                   if (self.block) {
                                                       self.block(dic);
                                                   }
                                               }else {
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                               [self hidden];
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               [NavigateManager showMessage:@"请检查网络"];
                                               [self hidden];
                                           }];
        
        
    }
}
- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1;
        weakSelf.bgView.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}

- (void) hidden{
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgView.alpha = 0.01;
        //        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


@end
