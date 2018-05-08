//
//  DongtaiDetilViewController.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "HunqinQuanModel.h"
@interface DongtaiDetilViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (nonatomic,assign)NSInteger id;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)Hunqinnewarray *superModel;
@property (nonatomic,strong)RACSubject *refreshDataSubject;
@end
