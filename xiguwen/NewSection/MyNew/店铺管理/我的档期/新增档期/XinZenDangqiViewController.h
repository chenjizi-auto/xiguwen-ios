//
//  XinZenDangqiViewController.h
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "MyDangQiModel.h"

@interface XinZenDangqiViewController : FatherViewController

@property (nonatomic, strong) DangQiDetailsModel *model;

@property (nonatomic, assign) BOOL isEdit;// 是修改还是新建

@end
