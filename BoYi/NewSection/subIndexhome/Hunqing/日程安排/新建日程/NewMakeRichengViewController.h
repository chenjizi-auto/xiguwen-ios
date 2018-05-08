//
//  NewMakeRichengViewController.h
//  BoYi
//
//  Created by heng on 2018/1/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "RiChengNewModel.h"

@interface NewMakeRichengViewController : FatherViewController

@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *star;
@property (weak, nonatomic) IBOutlet UILabel *end;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (nonatomic, strong) Newrichengarray *model;
@property (nonatomic, assign) BOOL isEdit;

@end
