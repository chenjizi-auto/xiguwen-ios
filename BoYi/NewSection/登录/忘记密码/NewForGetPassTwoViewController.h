//
//  NewForGetPassTwoViewController.h
//  BoYi
//
//  Created by heng on 2018/1/25.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface NewForGetPassTwoViewController : FatherViewController

@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *iphone;

@property (weak, nonatomic) IBOutlet UITextField *newpass;
@property (weak, nonatomic) IBOutlet UITextField *oldpass;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@end
