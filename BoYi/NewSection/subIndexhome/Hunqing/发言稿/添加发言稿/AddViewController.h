//
//  AddViewController.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "FayangaoModel.h"
#import "UItextViewWithPlaceHloder.h"
@interface AddViewController : FatherViewController
@property (nonatomic, strong) Fayangaoarray *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *content;

@end

