//
//  PushXuqiuViewController.h
//  BoYi
//
//  Created by heng on 2017/12/28.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "UItextViewWithPlaceHloder.h"
#import "MyXuqiuModel.h"
@interface PushXuqiuViewController : FatherViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *titlename;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *typebtn;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *diqubtn;

@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *price;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *xuqiu;
@property (weak, nonatomic) IBOutlet UIImageView *gongkaiIMAGE;
@property (weak, nonatomic) IBOutlet UIImageView *sureImage;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (nonatomic, strong) MyXuqiuModel *model;
@property (nonatomic, assign) BOOL isEdit;

@property (weak, nonatomic) IBOutlet UIView *pianyi1;


@end
