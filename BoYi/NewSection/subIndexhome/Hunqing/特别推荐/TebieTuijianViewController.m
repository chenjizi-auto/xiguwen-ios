//
//  TebieTuijianViewController.m
//  BoYi
//
//  Created by heng on 2018/1/4.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "TebieTuijianViewController.h"
#import "TebieTuijianViewModel.h"
#import "TebietuijianHeaderView.h"
#import "TebieTuijianModel.h"
#import "AnlieListViewController.h"
#import "BannerWebViewController.h"
#import "NewShangjiaViewController.h"
#import "ShangchengsjNewDetilViewController.h"
#import "AnlieNewDetilViewController.h"
#import "ShangpinNewDetilViewController.h"
#import "BaojiaDetilViewController.h"

@interface TebieTuijianViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) TebieTuijianViewModel *viewModel;
@property (strong,nonatomic) ShareNewmodel *sharemodel;
@end

@implementation TebieTuijianViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"特别推荐";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    [self addRightBtnWithTitle:nil image:@"分享的副本"];
    [self shareData];
}
- (void)respondsToRightBtn {
    if (self.sharemodel) {
        [CwShareManager shareWebPageToPlatformWithUrl:self.sharemodel.url
                                                image:self.sharemodel.image
                                                title:self.sharemodel.title
                                                descr:self.sharemodel.descr
                                                   vc:self
                                           completion:^(id data, NSError *error) {
                                               
                                           }];
    }
}
- (void)shareData{
    NSDictionary *dic = @{@"id":@(self.guanggaoID),@"type":@"1"};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxianghunqiga"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.sharemodel = [ShareNewmodel mj_objectWithKeyValues:response[@"data"]];
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];
                                           
                                       }];
}
#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Guanggaoarray *x) {
        @strongify(self);


        Guanggaoarray *model = x;
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
    }];
    
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"TebieTuijianTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TebieTuijianTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
//    TebietuijianHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"TebietuijianHeaderView" owner:nil options:nil].firstObject;
//    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
//    header.frame = CGRectMake(0, 0, ScreenWidth, 170);
//    
//    self.table.tableHeaderView = header;
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
//        guanggaoID
        [self.viewModel.refreshDataCommand execute:@{@"id":@(self.guanggaoID)}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{@"id":@(self.guanggaoID)}];
//                }];
//            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//            
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//            
//        }
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
- (TebieTuijianViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TebieTuijianViewModel alloc] init];
    }
    return _viewModel;
}


@end
