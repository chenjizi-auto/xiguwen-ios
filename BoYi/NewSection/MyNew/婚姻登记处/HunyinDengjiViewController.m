/**
 *　　　　　　　 ┏┓       ┏┓+ +
 *　　　　　　　┏┛┻━━━━━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　 ┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 █████━█████  ┃+
 *　　　　　　　┃　　　　　　 ┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　 ┃ + +
 *　　　　　　　┗━━┓　　　 ┏━┛
 *               ┃　　  ┃
 *　　　　　　　　　┃　　  ┃ + + + +
 *　　　　　　　　　┃　　　┃　Code is far away from     bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　         神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　 ┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +
 *　　　　　　　　　 ┃┫┫　 ┃┫┫
 *　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +
 */
//
//  HunyinDengjiViewController.m
//  BoYi
//
//  Created by 陈伟 on 2018/4/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunyinDengjiViewController.h"
#import "HunyinDengjiViewModel.h"
#import "HunlyinAddressViewController.h"
@interface HunyinDengjiViewController () {
    NSArray * CityArray;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HunyinDengjiViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *searchText;
@property(nonatomic,strong)DiPuPickerView * pickerView;

@end

@implementation HunyinDengjiViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"婚姻登记处";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
//    [self.table.mj_header beginRefreshing];
    
    /**
     * 城市获取
     */
    [self.viewModel.CityViewModel.DataCommand execute:nil];
    
    [self.viewModel.CityViewModel.Subject subscribeNext:^(id  _Nullable x) {
    
        CityArray = [DipuCityModel mj_objectArrayWithKeyValuesArray:x];
    }];
}


#pragma mark - 点击事件

- (IBAction)clickChooseCity:(id)sender {
    
    [self.pickerView PickdataSources:CityArray  type:3];
}
- (IBAction)search:(id)sender {
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(HunyinDengjiModel *x) {
        @strongify(self);
        HunlyinAddressViewController *address = [[HunlyinAddressViewController alloc] init];
        address.address = x.title;
        [self pushToNextVCWithNextVC:address];
    }];
    
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        //        [NavigateManager showMessage:@"操作成功"];
        //        [self.table.mj_header beginRefreshing];
//    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"HunyinDengjiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunyinDengjiTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
//
//    //下拉刷新
//    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        @strongify(self);
//        //传入参数 进行刷新
//        [self.viewModel.refreshDataCommand execute:@{}];
//    }];
//
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {

        @strongify(self);

        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:YES];
//
//        //正在下啦
//        if (self.table.mj_header.isRefreshing) {
//
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
//                }];
//            }
//            [self.table.mj_header endRefreshing];
//        }
//
//        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//
//        }
//        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];

    }];
//    //处理请求失败
//    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
//        @strongify(self);
//        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
//        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
//    }];
}

//初始化viewModel
- (HunyinDengjiViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HunyinDengjiViewModel alloc] init];
    }
    return _viewModel;
}
- (DiPuPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[NSBundle mainBundle]loadNibNamed:@"DiPuPickerView" owner:self options:nil].firstObject;
        _pickerView.frame = CGRectMake(0, ScreenHeight + 200, ScreenWidth, 200);
        _pickerView.isCityChoose = YES;
        [self.view addSubview:_pickerView];
        __weak typeof(self)weakSelf = self;
        _pickerView.Mblock = ^(NSString *cityNames, NSString *citys,DiPuPickerType type) {
            if (type==city) {
                
                //                dispatch_async(dispatch_get_main_queue(), ^{
                //                    weakSelf.Address.text = cityNames;
//                [weakSelf.viewModel.dicInfo setObject:cityNames forKey:@"city"];
//                [weakSelf.table reloadData];
                //                });
                NSArray *arr = [cityNames componentsSeparatedByString:@","];
                weakSelf.searchText.text = [NSString stringWithFormat:@"%@,%@",arr[0],arr[1]];
                NSDictionary *info = @{@"province":arr[0],@"city":arr[1]};
                //传入参数 进行刷新
                [weakSelf.viewModel.refreshDataCommand execute:info];

                
            }
            
        };
    }
    return _pickerView;
}

@end
