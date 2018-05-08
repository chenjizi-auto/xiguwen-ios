//
//  AddTixingViewController.h
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "MyDangQiModel.h"

@interface AddTixingViewController : FatherViewController

@property (nonatomic, strong) DangQiDetailsModel *model;// 提醒数组
@property (nonatomic, copy) void(^onComplete)(DangQiDetailsModel *model);

@end
