//
//  HotViewController.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "HotViewController.h"
#import "HotViewModel.h"
#import "ShaiXuanHot.h"
#import "HotModel.h"
#import "NewShangjiaViewController.h"
#import "AnlieNewDetilViewController.h"
#import "ShangpinNewDetilViewController.h"
#import "BaojiaDetilViewController.h"
#import "BannerWebViewController.h"
#import "fenLeiModel.h"
#import "ShangchengsjNewDetilViewController.h"
#import "HotListViewController.h"

@interface HotViewController (){
    NSInteger p;
    NSInteger _ceilingprice,//最高价
//    _cityid,//当前城市
    _college,//是否学院认证1是 2不是
    _comprehensive,//综合排序 值1
    _countyid,//区域id查询
    _floorprice,//最低价
    _isshopvip,//否会员商家1是2否
    _type,//全部（职业id）
    _p,//默认第一页1
    _platform,//是否平台认证1是 2不是
    _rows,//默认10条
    _sincerity,//是否诚信认证1是 2不是
    _team,//商家类型，1个人，2团队
    _types;//1今日推荐2本周人气3本月人气4本周热门5本月热门
    
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HotViewModel *viewModel;
@property(nonatomic,strong) ShaiXuanHot *shaixuanView;
@property(nonatomic,assign)NSInteger curPage;
@end

@implementation HotViewController
- (void)viewWillAppear:(BOOL)animated{
    
    if ([[UserData UserDefaults:@"isRefreshing3"] isEqualToString:@"yes"]) {
        [self.table.mj_header beginRefreshing];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    [self setupBannerView];
}


#pragma mark - 点击事件


- (void)setupBannerView {
    
    _ceilingprice = -1;//最高价
    _college = -1;//是否学院认证1是 2不是
    _comprehensive = -1;//综合排序 值1
    _countyid = -1;//区域id查询
    _floorprice = -1;//最低价
    _isshopvip = -1;//否会员商家1是2否
    _type = -1;//全部（职业id）
    _platform = -1,//是否平台认证1是 2不是
    _sincerity = -1,//是否诚信认证1是 2不是
    _team = -1;//商家类型，1个人，2团队
    _types = 1;
    
}

- (IBAction)allction:(UIButton *)sender {
 
    
   
}

#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Remensjhot *x) {
        @strongify(self);
        if (x.usertype == 1) {//商城
            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
            vc.id = x.userid;
            [self pushToNextVCWithNextVC:vc];
        }else {//婚庆
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = x.userid;
            [self pushToNextVCWithNextVC:vc];
        }
    }];
    [self.viewModel.pushUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger index = [x integerValue];
        HotListViewController *vc = [[HotListViewController alloc] init];
        vc.typeswu = index + 1;
        [self pushToNextVCWithNextVC:vc];
    }];
    
    [self.viewModel.bannerUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger index = [x integerValue];
        Guanggaolunbohot *model = self.viewModel.model.guanggaolunbo[index];
        if ([NSStringFormatter(model.src) isBlankString]) {
            if (model.aptype == 1) {//婚庆商家
                
                NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
                vc.shopid = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else if (model.aptype == 2){//商城商家
                
            }else if (model.aptype == 3){//案例
                
                AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
                vc.anlieID = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else if (model.aptype == 5){//商品
                
                ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
                vc.shangpinID = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else {//报价
                BaojiaDetilViewController *index = [[BaojiaDetilViewController alloc] init];
                
                index.baojiaid = model.aptid;
                [self pushToNextVCWithNextVC:index];
            }
        }else {
            BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
            bannerweb.hidesBottomBarWhenPushed = YES;
            bannerweb.urlString = NSStringFormatter(model.src);
            [self pushToNextVCWithNextVC:bannerweb];
        }
    }];
    
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"HotTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HotTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HotContentTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HotContentTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"hotoneTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"hotoneTableViewCell"];
    
   
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    //类别和区域
//    [self.viewModel.fenleilistDataCommand execute:@{}];
//    [self.viewModel.getquyuDataCommand execute:@{@"city":@([UserDataNew sharedManager].userInfoModel.user.cityid)}];
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        _curPage = 1;
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
            
            [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
        }
        [dic setValue:@(_curPage) forKey:@"p"];
        if (_ceilingprice != -1) {
            [dic setValue:@(_ceilingprice) forKey:@"ceilingprice"];
        }
        
        if (_college != -1) {
            [dic setValue:@(_college) forKey:@"college"];
        }
        if (_comprehensive == 1) {
            [dic setValue:@(_comprehensive) forKey:@"comprehensive"];
        }
//        if (![[NSString stringWithFormat:@"%ld",[UserDataNew sharedManager].userInfoModel.user.countyid] isBlankString]) {
//            
//            [dic setValue:@([UserDataNew sharedManager].userInfoModel.user.cityid) forKey:@"countyid"];
//        }
        if (_floorprice != -1) {
            [dic setValue:@(_floorprice) forKey:@"floorprice"];
        }
        if (_isshopvip != -1) {
            [dic setValue:@(_isshopvip) forKey:@"isshopvip"];
        }
        if (_type != -1) {
            [dic setValue:@(_type) forKey:@"type"];
        }
        if (_types != -1) {
            [dic setValue:@(_types) forKey:@"types"];
        }
        
        if (_platform != -1) {
            [dic setValue:@(_platform) forKey:@"platform"];
        }
        if (_sincerity != -1) {
            [dic setValue:@(_sincerity) forKey:@"sincerity"];
        }
        if (_team != -1) {
            [dic setValue:@(_team) forKey:@"team"];
        }
        
        [self.viewModel.refreshDataCommand execute:dic];
        [UserData UserDefaults:@"no" key:@"isRefreshing3"];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        HotModel *model = [[HotModel alloc] init];
        
        model = [HotModel mj_objectWithKeyValues:x];
        self.viewModel.model = model;
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    _curPage ++;
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                        
                        [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
                    }
                    [dic setValue:@(_curPage) forKey:@"p"];
                    
                    if (_ceilingprice != -1) {
                        [dic setValue:@(_ceilingprice) forKey:@"ceilingprice"];
                    }
                    
                    [dic setValue:@(_college) forKey:@"college"];
                    
                    if (_comprehensive == 1) {
                        [dic setValue:@(_comprehensive) forKey:@"comprehensive"];
                    }
                    //                    if (![[NSString stringWithFormat:@"%ld",[UserDataNew sharedManager].userInfoModel.user.countyid] isBlankString]) {
                    //
                    //                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.user.cityid) forKey:@"countyid"];
                    //                    }
                    if (_floorprice != -1) {
                        [dic setValue:@(_floorprice) forKey:@"floorprice"];
                    }
                    [dic setValue:@(_isshopvip) forKey:@"isshopvip"];
                    
                    if (_type != -1) {
                        [dic setValue:@(_type) forKey:@"type"];
                    }
                    [dic setValue:@(_platform) forKey:@"platform"];
                    [dic setValue:@(_sincerity) forKey:@"sincerity"];
                    [dic setValue:@(_team) forKey:@"team"];
                    
                    [self.viewModel.refreshDataCommand execute:dic];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}


//初始化viewModel
- (HotViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HotViewModel alloc] init];
    }
    return _viewModel;
}


@end
