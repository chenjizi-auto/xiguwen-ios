//
//  AddViewController.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"婚礼宝典";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
	
	self.titleTF.delegate = self;
	self.titleTF.inputAccessoryView = [self addToolbar];
	
	self.content.delegate = self;
	self.content.inputAccessoryView = [self addToolbar];
    self.content.placeholder = @"请输入婚礼宝典内容";
    if (self.model) {//编辑
		[self.titleTF setText:self.model.title];
        self.content.text = self.model.content;
    }
    if (isIPhoneX) {
        self.height.constant = 84;
    }
}
- (void)respondsToRightBtn {
    if (self.model) {//编辑

        if (self.titleTF.text.length == 0) {
            [NavigateManager showMessage:@"请填写标题"];
            return;
        }
		
		if (self.titleTF.text.length > 9) {
			[NavigateManager showMessage:@"请将标题字数控制在9个以内"];
			return;
		}
		
        if (self.content.text.length == 0) {
            [NavigateManager showMessage:@"请填写内容"];
            return;
        }
        NSDictionary *dic = @{@"content":self.content.text,@"title":self.titleTF.text,@"id":@(self.model.id),@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
        [[RequestManager sharedManager] requestUrl:URL_New_xiugaifayangao
                                            method:POST
                                            loding:@""
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager showMessage:@"编辑成功"];
//                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
                                                       [self popViewConDelay];;
//                                                   });
													   
                                               }else{
                                                   
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           }];
    }else {//添加
        if (self.titleTF.text.length == 0) {
            [NavigateManager showMessage:@"请填写标题"];
            return;
        }
        if (self.content.text.length == 0) {
            [NavigateManager showMessage:@"请填写内容"];
            return;
        }
        NSDictionary *dic = @{@"content":self.content.text,@"title":self.titleTF.text,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
        [[RequestManager sharedManager] requestUrl:URL_New_addfayangao
                                            method:POST
                                            loding:@""
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager showMessage:@"添加成功"];
//                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       
                                                       [self popViewConDelay];;
//                                                   });
													   
                                               }else{
                                                   
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           }];
    }
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//	if (self.titleTF.text.length >= 12) {
//		self.titleTF.text = [self.titleTF.text substringToIndex:9];
//	}
//	return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
