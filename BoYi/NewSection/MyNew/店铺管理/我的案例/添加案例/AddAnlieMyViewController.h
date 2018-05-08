//
//  AddAnlieMyViewController.h
//  BoYi
//
//  Created by heng on 2018/1/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "MyAnLieVCModel.h"

@interface AddAnlieMyViewController : FatherViewController

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, strong) MyAnLieVCModel *model;

@end
