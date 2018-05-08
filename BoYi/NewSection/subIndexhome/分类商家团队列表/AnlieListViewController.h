//
//  AnlieListViewController.h
//  BoYi
//
//  Created by heng on 2017/12/18.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "fenLeiModel.h"
#import "AnlieListModel.h"
#import "quyuModel.h"

@interface AnlieListViewController : FatherViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet IB_DESIGN_Textfield *guanjianziText;
#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (strong, nonatomic) NSString *titlew;

@property (assign, nonatomic) NSInteger typeFenleiguolai;

@property (assign, nonatomic) NSInteger typeQuan;

@property (weak, nonatomic) IBOutlet UIButton *shangjiaBtn;
@property (weak, nonatomic) IBOutlet UIView *shangjiaView;

@property (weak, nonatomic) IBOutlet UIButton *tuanduiBtn;
@property (weak, nonatomic) IBOutlet UIView *tuanduiView;


//加载首页分类列表


@property (strong,nonatomic) NSMutableArray <Shangjiatuanduilist *>*dataArray;


@property (weak, nonatomic) IBOutlet UITableView *leibieAndHuanjinTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tablesaixuanHeight;
@property (weak, nonatomic) IBOutlet UIView *zhegaiView;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *quyuName;

@property (strong, nonatomic) NSMutableArray <Fenleiarray *>*quanbuArray;
@property (strong, nonatomic) NSMutableArray <Quyuquarray *>*quyuArray;
@property (weak, nonatomic) IBOutlet UIView *canzhaowuView;

@property (assign, nonatomic) NSInteger typeSearch;
@property (nonatomic, strong) NSArray <Shangjiatuanduilist *>*dataSJ;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baifenzhiHeight;

@end
