//
//  SearchsjViewController.h
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "fenLeiModel.h"
#import "AnlieListModel.h"
#import "quyuModel.h"
@interface SearchsjViewController : FatherViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) NSString *content;
@property (assign, nonatomic) NSInteger typeQuan;
//加载首页分类列表
@property (assign, nonatomic) NSInteger typeFenleiguolai;

@property (strong,nonatomic) NSMutableArray <Shangjiatuanduilist *>*dataArray;


@property (weak, nonatomic) IBOutlet UITableView *leibieAndHuanjinTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tablesaixuanHeight;
@property (weak, nonatomic) IBOutlet UIView *zhegaiView;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *quyuName;

@property (strong, nonatomic) NSMutableArray <Fenleiarray *>*quanbuArray;
@property (strong, nonatomic) NSMutableArray <Quyuquarray *>*quyuArray;

@property (assign, nonatomic) NSInteger typeSearch;
@property (nonatomic, strong) NSArray <Shangjiatuanduilist *>*dataSJ;
@end
