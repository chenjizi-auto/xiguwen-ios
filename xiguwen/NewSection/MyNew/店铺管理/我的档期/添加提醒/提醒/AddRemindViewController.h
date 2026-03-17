//
//  AddRemindViewController.h
//  BoYi
//
//  Created by Niklaus on 2018/4/1.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "MyDangQiModel.h"

@interface AddRemindViewController : FatherViewController

@property (nonatomic, strong) DangQiDetailsModel *model;


@property (nonatomic, copy) void(^onComplete)(DangQiDetailsModel *model);
@property (nonatomic, assign) BOOL isEdit;// 是否修改/添加
@property (nonatomic, assign) NSInteger type;// 提醒类型
@property (nonatomic, assign) NSInteger index;// 编辑状态时用于判断所修改提醒在数组中的位置

@end
