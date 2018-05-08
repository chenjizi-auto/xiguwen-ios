//
//  HunqinQuanViewController.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "fenLeiModel.h"
#import "HunqinClickHiddenView.h"

@interface HunqinQuanViewController : FatherViewController<UITableViewDelegate,UITableViewDataSource>

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIImageView *zuixinImage;
@property (weak, nonatomic) IBOutlet UIImageView *remenImage;
@property (strong, nonatomic) NSMutableArray <Fenleiarray *>*quanbuArray;


@property (weak, nonatomic) IBOutlet HunqinClickHiddenView *tabheightview;


@property (weak, nonatomic) IBOutlet UITableView *tablexiala;
@property (weak, nonatomic) IBOutlet UIButton *allBTN;

@end
