//
//  HuifuiPL.m
//  BoYi
//
//  Created by heng on 2018/3/1.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HuifuiPL.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation HuifuiPL

+ (HuifuiPL *)showInView:(UIView *)view setid:(NSInteger)setid block:(void(^)(NSString *date))block{
    IQKeyboardManager.sharedManager.enable = false;
    HuifuiPL *alert = [[[NSBundle mainBundle]loadNibNamed:@"HuifuiPL" owner:self options:nil]lastObject];
    alert.frame = view.frame;
    alert.text.placeholder = @"写评论/回复…";
    alert.block = block;
    alert.id = setid;
    [alert.text becomeFirstResponder];
    [alert showOnView:view];
    return alert;
}
- (IBAction)cancle:(id)sender {
    [self hidden];
}
- (IBAction)sure:(id)sender {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [dic setValue:@(self.id) forKey:@"id"];
    [dic setValue:self.text.text forKey:@"comm"];
    
    [[RequestManager sharedManager] requestUrl:URL_New_dongtaipinglun
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               if (self.block) {
                                                   self.block(self.text.text);
                                               }
                                               
                                           }else{
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                           [self hidden];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [self hidden];
                                       }];
    
    
}

- (void)showOnView:(UIView *)view {
    self.alpha = 0.01;
    self.bgview.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1;
        weakSelf.bgview.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}

- (void) hidden{
    [self.text resignFirstResponder];
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgview.alpha = 0.01;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
