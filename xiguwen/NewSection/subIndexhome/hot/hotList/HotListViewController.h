//
//  HotListViewController.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "DopTableViewCell.h"
#import "HotModel.h"
#import "quyuModel.h"
#import "fenLeiModel.h"

@interface HotListViewController : FatherViewController<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) NSInteger type;
#pragma mark- api
@property (strong,nonatomic) HotModel *model;

@property (weak, nonatomic) IBOutlet UIView *tabheightview;


@property (weak, nonatomic) IBOutlet UITableView *tablexiala;
@property (strong, nonatomic) NSMutableArray <Fenleiarray *>*quanbuArray;
@property (strong, nonatomic) NSMutableArray <Quyuquarray *>*quyuArray;
@property (weak, nonatomic) IBOutlet UILabel *all;
@property (weak, nonatomic) IBOutlet UILabel *quyu;

@property (assign, nonatomic) NSInteger typeswu;


@end
