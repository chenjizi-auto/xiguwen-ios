//
//  MapViewController.m
//  BoYi
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MapViewController.h"
#import "MapViewModel.h"
#import "MapHeaderView.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MapViewModel *viewModel;

@end

@implementation MapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    [self addPopBackBtn];
    
    [self setupTableView];
}


#pragma mark - 点击事件



#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MapTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MapTableViewCell"];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.rowHeight = 40;
    @weakify(self);
    
    [self.viewModel.refreshDataCommand execute:@{@"where":@""}];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];

        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    
    MapHeaderView *type = [[NSBundle mainBundle]loadNibNamed:@"MapHeaderView" owner:nil options:nil].firstObject;
    type.frame = CGRectMake(0, 0, ScreenWidth, 120);
    [type.gotoNextVc subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        NSLog(@"%@",x);
        switch ([x integerValue]) {
            case 0:
                //                [self pushToNextvcWithNextVCTitle:@"MerchantOrderViewController"];
                break;
            case 1:
                //                [self pushToNextvcWithNextVCTitle:@"GoodsManagerViewController"];
                break;
            case 2:
                //                [self pushToNextvcWithNextVCTitle:@"GoodsManagerViewController"];
                break;
            case 3:
                //                [self pushToNextvcWithNextVCTitle:@"GoodsManagerViewController"];
                break;
            case 4:
                //                [self pushToNextvcWithNextVCTitle:@"GoodsManagerViewController"];
                break;
            case 5:
                //                [self pushToNextvcWithNextVCTitle:@"GoodsManagerViewController"];
                break;
            case 6:
                //                [self pushToNextvcWithNextVCTitle:@"GoodsManagerViewController"];
                break;
            default:
                break;
        }
        
    }];
    self.table.tableHeaderView = type;
}

//初始化viewModel
- (MapViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MapViewModel alloc] init];
    }
    return _viewModel;
}


@end
