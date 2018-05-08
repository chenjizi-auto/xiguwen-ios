//
//  ShopcityViewController.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShopcityViewController.h"
#import "ShopcityViewModel.h"
#import "ShopcityModel.h"
#import "SDCycleScrollView.h"
#import "AllTpyeViewController.h"
#import "NewShangjiaViewController.h"
#import "AnlieNewDetilViewController.h"
#import "ShangpinNewDetilViewController.h"
#import "BaojiaDetilViewController.h"
#import "BannerWebViewController.h"
#import "fenLeiModel.h"
#import "ShangchengSubViewController.h"
#import "ShangchengsjNewDetilViewController.h"
#import "ShangpinNewDetilViewController.h"
#import "ShopcityModel.h"
#import "ShangchengFenleiViewController.h"
#import "ShangChengListNewViewController.h"
#import "shangchengNewlistViewController.h"
@interface ShopcityViewController ()<SDCycleScrollViewDelegate>{
   
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShopcityViewModel *viewModel;
@property (strong, nonatomic) SDCycleScrollView *adView;
@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation ShopcityViewController

- (void)viewWillAppear:(BOOL)animated{
    
    if ([[UserData UserDefaults:@"isRefreshing2"] isEqualToString:@"yes"]) {
        [self.table.mj_header beginRefreshing];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self setupTableView];
    [self setupBannerView];
    [self.table.mj_header beginRefreshing];
}

#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Youlove *x) {
        @strongify(self);
        ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
        vc.shangpinID = x.shopid;
        [self pushToNextVCWithNextVC:vc];
    }];
    //分累
    [self.viewModel.typeSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Fenleiarray *model = x;
        if (model.occupationid == 10000) {
            ShangchengFenleiViewController *all = [[ShangchengFenleiViewController alloc] init];
            [self.navigationController pushViewController:all animated:YES];
            
        }else {
            ShangChengListNewViewController *anlist = [[ShangChengListNewViewController alloc] init];
            anlist.id = model.id;
            [self pushToNextVCWithNextVC:anlist];
        }
        
    }];
    //qu关注
    [self.viewModel.deleguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x[@"code"] integerValue] == 0 ) {
            //刷新视图
            self.viewModel.model.remenshangpin[self.viewModel.index - 3].afollow = 0;
      
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }
        
    }];
    //add关注
    [self.viewModel.addguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        if ([x[@"code"] integerValue] == 0 ) {
            //刷新视图
            self.viewModel.model.remenshangpin[self.viewModel.index - 3].afollow = 1;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }
    }];
    //热门推荐6按钮 广告
    [self.viewModel.hotHuoFiveBtnSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.viewModel.model.xiaoguanggaoyi.count > 0) {
            NSInteger index;

            if ([x integerValue] == 0) {
                index = self.viewModel.model.youhaohuo.adid;
            }else if ([x integerValue] == 1) {
                index = self.viewModel.model.bimai.rmhd1.adid;
            }else if ([x integerValue] == 2) {
                index = self.viewModel.model.bimai.rmhd2.adid;
            }else if ([x integerValue] == 3) {
                index = self.viewModel.model.bimai.rmhd3.adid;
            }else if ([x integerValue] == 4) {
                index = self.viewModel.model.bimai.rmhd4.adid;
            }else {
                index = self.viewModel.model.bimai.rmhd5.adid;
            }
            shangchengNewlistViewController *vc = [[shangchengNewlistViewController alloc] init];
            vc.id = index;
            vc.statusFlag = [x integerValue];
            [self pushToNextVCWithNextVC:vc];
        }
    }];
    //热门品牌
    [self.viewModel.hotxiaopinpaisixBtnSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger index;
        
        if ([x integerValue] == 0) { //小广告
            if([NSStringFormatter(self.viewModel.model.xiaoguanggaoyi[0].src) isBlankString]) {
                if (self.viewModel.model.xiaoguanggaoyi[0].aptype == 1) {//婚庆商家
                    
                    NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
                    vc.shopid = self.viewModel.model.xiaoguanggaoyi[0].aptid;
                    [self pushToNextVCWithNextVC:vc];
                }else if (self.viewModel.model.xiaoguanggaoyi[0].aptype == 2){//商城商家
                    ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
                    vc.id = self.viewModel.model.xiaoguanggaoyi[0].aptid;
                    [self pushToNextVCWithNextVC:vc];
                }else if (self.viewModel.model.xiaoguanggaoyi[0].aptype == 3){//案例
                    
                    AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
                    vc.anlieID = self.viewModel.model.xiaoguanggaoyi[0].aptid;
                    [self pushToNextVCWithNextVC:vc];
                }else if (self.viewModel.model.xiaoguanggaoyi[0].aptype == 5){//商品
                    
                    ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
                    vc.shangpinID = self.viewModel.model.xiaoguanggaoyi[0].aptid;
                    [self pushToNextVCWithNextVC:vc];
                }else {//报价
                    BaojiaDetilViewController *index = [[BaojiaDetilViewController alloc] init];
                    
                    index.baojiaid = self.viewModel.model.xiaoguanggaoyi[0].aptid;
                    [self pushToNextVCWithNextVC:index];
                }
            }else {
                BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
                bannerweb.hidesBottomBarWhenPushed = YES;
                bannerweb.urlString = NSStringFormatter(self.viewModel.model.xiaoguanggaoyi[0].src);
                [self pushToNextVCWithNextVC:bannerweb];
            }
        }else {
            
//            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
//            vc.id = self.viewModel.model.renmenpinpai[[x integerValue] - 1].adid;
//            [self pushToNextVCWithNextVC:vc];
            
            if([NSStringFormatter(self.viewModel.model.renmenpinpai[[x integerValue] - 1].src) isBlankString]) {
                if (self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptype == 1) {//婚庆商家
                    
                    NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
                    vc.shopid = self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptid;
                    [self pushToNextVCWithNextVC:vc];
                }else if (self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptype == 2){//商城商家
                    ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
                    vc.id = self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptid;
                    [self pushToNextVCWithNextVC:vc];
                }else if (self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptype == 3){//案例
                    
                    AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
                    vc.anlieID = self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptid;
                    [self pushToNextVCWithNextVC:vc];
                }else if (self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptype == 5){//商品
                    
                    ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
                    vc.shangpinID = self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptid;
                    [self pushToNextVCWithNextVC:vc];
                }else {//报价
                    BaojiaDetilViewController *index = [[BaojiaDetilViewController alloc] init];
                    
                    index.baojiaid = self.viewModel.model.renmenpinpai[[x integerValue] - 1].aptid;
                    [self pushToNextVCWithNextVC:index];
                }
            }else {
                BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
                bannerweb.hidesBottomBarWhenPushed = YES;
                bannerweb.urlString = NSStringFormatter(self.viewModel.model.renmenpinpai[[x integerValue] - 1].src);
                [self pushToNextVCWithNextVC:bannerweb];
            }
        }
    }];
}

#pragma mark - public api

- (void)setupBannerView {
    @weakify(self);
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    header.backgroundColor = [UIColor whiteColor];
    self.adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 170) delegate:self placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.adView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.adView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.adView.pageDotColor = RGBA(220, 146, 196, 1);
    self.adView.autoScrollTimeInterval = 5.0;
    self.adView.showPageControl = YES;
    [header addSubview:self.adView];
    self.table.tableHeaderView = header;
}
#pragma mark - 点击事件
//banner 点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    Guanggaolunbosc *model = self.photos[index];
    
    if ([NSStringFormatter(model.src) isBlankString]) {
        if (model.aptype == 1) {//婚庆商家
            
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }else if (model.aptype == 2){//商城商家
            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
            vc.id = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }else if (model.aptype == 3){//案例
            
            AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
            vc.anlieID = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }else if (model.aptype == 5){//商品
            
            ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
            vc.shangpinID = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }else {//报价
            BaojiaDetilViewController *vc = [[BaojiaDetilViewController alloc] init];
            vc.baojiaid = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }
    }else {
        BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
        bannerweb.hidesBottomBarWhenPushed = YES;
        bannerweb.urlString = NSStringFormatter(model.src);
        [self pushToNextVCWithNextVC:bannerweb];
    }
}
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"HunqinTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunqinTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"shangchengTwoTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"shangchengTwoTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"shangchengThreeTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"shangchengThreeTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"shangchengFourTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"shangchengFourTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    [self.viewModel.fenleilistDataCommand execute:@{}];
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setValue:@(_curPage) forKey:@"p"];
        
//        if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
//
//            [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
//        }
        if ([UserDataNew sharedManager].userInfoModel.token.token) {
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [self.viewModel.refreshDataCommand execute:dic];
        }else {
            [self.viewModel.refreshDataCommand execute:dic];
        }
        [UserData UserDefaults:@"no" key:@"isRefreshing2"];
        
    }];
    [self.viewModel.fenleilistUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        //分类数据处理
        self.viewModel.fenleiArray = [Fenleiarray mj_objectArrayWithKeyValuesArray:x];
        
        NSMutableArray *arrayName = [[NSMutableArray alloc] init];
        NSMutableArray *arrayID = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.viewModel.fenleiArray.count; i ++) {
            Fenleiarray *model = self.viewModel.fenleiArray[i];

            [arrayName addObject:[NSString stringWithFormat:@"%@",model.wapname]];
            [arrayID addObject:@(model.occupationid)];
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrayName forKey:@"zhiweinameSC"];
        [[NSUserDefaults standardUserDefaults] setObject:arrayID forKey:@"zhiweiidSC"];
        
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
//        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        ShopcityModel *model = [[ShopcityModel alloc] init];
        
        model = [ShopcityModel mj_objectWithKeyValues:x];
        self.viewModel.model = model;
        self.photos = [NSMutableArray arrayWithArray:model.guanggaolunbo];
        [self configDataForHeaderCode:self.photos];
        
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
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
- (void)configDataForHeaderCode:(NSMutableArray *)array{
    NSMutableArray *ay = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        
        Guanggaolunbosc *model = array[i];
        [ay addObject: model.wapimg];
        
    }
    self.adView.imageURLStringsGroup = ay;
}
//初始化viewModel
- (ShopcityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShopcityViewModel alloc] init];
    }
    return _viewModel;
}


@end
