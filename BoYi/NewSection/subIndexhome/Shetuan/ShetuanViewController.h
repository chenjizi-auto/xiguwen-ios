//
//  ShetuanViewController.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "quyuModel.h"
#import "fenLeiModel.h"
@interface ShetuanViewController : FatherViewController <UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (assign, nonatomic) NSInteger type;
@property (weak, nonatomic) IBOutlet UIView *tabheightview;


@property (weak, nonatomic) IBOutlet UITableView *tablexiala;
@property (strong, nonatomic) NSMutableArray <Fenleiarray *>*quanbuArray;
@property (strong, nonatomic) NSMutableArray <Quyuquarray *>*quyuArray;
@property (weak, nonatomic) IBOutlet UILabel *all;
@property (weak, nonatomic) IBOutlet UILabel *quyu;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baifenzhiHeight;
@end
