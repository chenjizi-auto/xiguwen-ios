
//
//  HotViewController.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "DopTableViewCell.h"
#import "SDCycleScrollView.h"
#import "HotModel.h"
#import "quyuModel.h"
#import "fenLeiModel.h"

@interface HotViewController : FatherViewController<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

#pragma mark- as

#pragma mark- model

#pragma mark- view
@property (assign, nonatomic) NSInteger type;
#pragma mark- api
@property (strong,nonatomic) HotModel *model;
@property (strong, nonatomic) SDCycleScrollView *adView;
@property (strong, nonatomic) NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet UIView *tabheightview;


@property (weak, nonatomic) IBOutlet UITableView *tablexiala;
@property (strong, nonatomic) NSMutableArray <Fenleiarray *>*quanbuArray;
@property (strong, nonatomic) NSMutableArray <Quyuquarray *>*quyuArray;
@property (weak, nonatomic) IBOutlet UILabel *all;
@property (weak, nonatomic) IBOutlet UILabel *quyu;
@end
