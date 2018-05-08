//
//  UserZhuCeViewController.h
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "JKCountDownButton.h"
@interface UserZhuCeViewController : FatherViewController
@property (weak, nonatomic) IBOutlet UITextField *iphone;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *againPassword;
@property (weak, nonatomic) IBOutlet UIButton *xieyiWord;

@property (nonatomic,assign)NSInteger tpye;

@property (weak, nonatomic) IBOutlet UIButton *bangBtn;
@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *userid;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weight;

@property (weak, nonatomic) IBOutlet UIButton *xuanzeCity;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end
