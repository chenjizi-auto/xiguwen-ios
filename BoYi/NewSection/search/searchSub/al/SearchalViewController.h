//
//  SearchalViewController.h
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "leixingAndHuanjinModel.h"
#import "AnlieListSearchModel.h"
@interface SearchalViewController : FatherViewController<UITableViewDelegate,UITableViewDataSource>
#pragma mark- view
@property (strong ,nonatomic) NSString *content;
@property (assign, nonatomic) NSInteger typeHuan;
@property (strong, nonatomic) NSMutableArray <Leixingandhuanjin *>*huanjinArray;
@property (strong, nonatomic) NSMutableArray <Leixingandhuanjin *>*leixingArray;

@property (weak, nonatomic) IBOutlet UITableView *leibieAndHuanjinTable;


#pragma mark- api
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tablesaixuanHeight;
@property (weak, nonatomic) IBOutlet UIView *zhegaiView;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *huanjinName;

@property (assign, nonatomic) NSInteger typeSearch;
@property (nonatomic, strong) NSArray <Anlielistsearcharray *>*dataAL;
@end
