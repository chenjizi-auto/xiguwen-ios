//
//  AnlieListSearchViewController.h
//  BoYi
//
//  Created by heng on 2017/12/27.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "leixingAndHuanjinModel.h"
#import "AnlieListSearchModel.h"

@interface AnlieListSearchViewController : FatherViewController<UITableViewDelegate,UITableViewDataSource>

#pragma mark- as

#pragma mark- model
@property (assign, nonatomic) NSInteger types;
#pragma mark- view
@property (assign, nonatomic) NSInteger typeHuan;
@property (strong, nonatomic) NSMutableArray <Leixingandhuanjin *>*huanjinArray;
@property (strong, nonatomic) NSMutableArray <Leixingandhuanjin *>*leixingArray;

@property (weak, nonatomic) IBOutlet UITableView *leibieAndHuanjinTable;

@property (weak, nonatomic) IBOutlet UITextField *search;
#pragma mark- api
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tablesaixuanHeight;
@property (weak, nonatomic) IBOutlet UIView *zhegaiView;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *huanjinName;

@property (assign, nonatomic) NSInteger typeSearch;
@property (nonatomic, strong) NSArray <Anlielistsearcharray *>*dataAL;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end
