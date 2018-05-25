//
//  LookFaYanGaoViewController.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "LookFaYanGaoViewController.h"

@interface LookFaYanGaoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textvieww;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseViewHeight;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@end

@implementation LookFaYanGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"婚礼宝典";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"删除" image:nil];
	[self.titleLabel setText:self.model.title];
    self.textvieww.text = self.model.content;
    if (isIPhoneX) {
        self.height.constant = 107;
    }
	
	self.baseView.layer.cornerRadius = 5;
	self.baseView.layer.masksToBounds = YES;
	self.textvieww.sd_layout.autoHeightRatio(0);
	// 设置高度
	[self.baseView setupAutoHeightWithBottomView:self.textvieww bottomMargin:10.0f];
	
//	[self layoutSubviews];
}

//- (void)layoutSubviews {
//	self.baseViewHeight.constant = self.textvieww.height+20;
////	[self.baseView setNeedsLayout];
//}

- (void)respondsToRightBtn {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否确认删除此婚礼宝典"message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
        NSDictionary *dic = @{@"id":@(self.model.id),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
        [[RequestManager sharedManager] requestUrl:URL_New_shanchufayangao
                                            method:POST
                                            loding:@""
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager showMessage:@"删除成功"];
                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       
                                                       [self popViewConDelay];;
                                                   });
                                                   
                                               }else{
                                                   
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           }];
    }];
    
    UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction*_Nonnull action) {
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
