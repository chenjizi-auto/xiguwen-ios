//
//  AddshouhuoViewController.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "UItextViewWithPlaceHloder.h"
#import "ShouHuodizhiModel.h"

@interface AddshouhuoViewController : FatherViewController<UITextViewDelegate>

@property (nonatomic,strong)Addressarray *model;
@property (nonatomic,assign)BOOL isBianji;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *iphone;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *xiangziAddress;
@property (weak, nonatomic) IBOutlet UISwitch *isMonren;

@property (weak, nonatomic) IBOutlet UIButton *addressbtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end
