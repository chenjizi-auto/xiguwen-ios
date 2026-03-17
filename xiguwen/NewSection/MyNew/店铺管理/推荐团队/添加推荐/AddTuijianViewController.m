//
//  AddTuijianViewController.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddTuijianViewController.h"

@interface AddTuijianViewController ()
@property (weak, nonatomic) IBOutlet UITextField *serialTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation AddTuijianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加推荐";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
    self.serialTF.delegate = self;
    self.serialTF.inputAccessoryView = [self addToolbar];
    self.weightTF.delegate = self;
    self.weightTF.inputAccessoryView = [self addToolbar];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 52.0;
}

- (void)respondsToRightBtn {
    // 保存推荐团队
	
	if (self.serialTF.text.length <= 0) {
		[NavigateManager showMessage: @"请填写编号"];
		return;
	}
	
	if (self.weightTF.text.length <= 0) {
		[NavigateManager showMessage: @"请填写排序"];
		return;
	}
	
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_addTeam
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
												 @"weight":@([self.weightTF.text integerValue]),
												 @"shopcode":@([self.serialTF.text integerValue])}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"添加成功"];
											   [weakSelf popViewConDelay];
										   } else {
											   [NavigateManager showMessage: response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"添加失败"];
									   }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
