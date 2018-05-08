//
//  RenZhenXYViewController.h
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "CertificationDataModel.h"

@interface RenZhenXYViewController : FatherViewController

@property (nonatomic, strong) InstituteAuth *model;
@property (nonatomic, assign) BOOL isChanged;//是不是修改提交
@end
