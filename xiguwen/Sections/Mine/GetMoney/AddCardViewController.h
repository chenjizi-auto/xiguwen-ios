//
//  AddCardViewController.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "GetMoneyViewController.h"

@interface AddCardViewController : FatherViewController

@property (strong,nonatomic) RACSubject *refreshSubject;
@property (strong,nonatomic) GetMoneyModel *model;
@end
