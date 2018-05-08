//
//  XieshangLishiViewController.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "XieshangLishiViewController.h"
#import "XieshangLishiViewModel.h"
#import "XieshangLishiModel.h"
@interface XieshangLishiViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) XieshangLishiViewModel *viewModel;
@property (strong,nonatomic)NSString *mobile;
@property (strong,nonatomic)NSString *shop_im;
@property (strong,nonatomic)NSString *user_im;

@end

@implementation XieshangLishiViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"协商历史";
    if (isIPhoneX) {
        self.height.constant = 84;
    }
    if (self.type == 1 || self.type == 3) {
        [self.sixinNameBtn setTitle:@"私信商家" forState:UIControlStateNormal];
    }else {
        [self.sixinNameBtn setTitle:@"私信买家" forState:UIControlStateNormal];
    }
    self.viewModel.isHunqin = self.isHunqin;
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self getData];
    
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        //im
        if (self.type == 1 || self.type == 3) {
            NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%@",self.shop_im] type:NIMSessionTypeP2P];
            NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%@",self.user_im] type:NIMSessionTypeP2P];
            NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else {
        if (self.mobile) {
            NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.mobile];
            CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
            if (version >= 10.0) {
                /// 大于等于10.0系统使用此openURL方法
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
            }
        }
    }
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Xieshangarray *x) {
        @strongify(self);
    }];
}
- (void)getData{
    
    NSString *url = self.isHunqin ? [HOMEURL stringByAppendingString:@"appapi/ordershq/xieshang"] :[HOMEURL stringByAppendingString:@"appapi/orders/xieshang"];
    
    [[RequestManager sharedManager] requestUrl:url
                                        method:POST
                                        loding:nil
                                           dic:@{@"fundid":@(self.id)}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.viewModel.dataArray = [NSMutableArray array];
 
                                               [self.viewModel.dataArray addObjectsFromArray:[Xieshangarray mj_objectArrayWithKeyValuesArray:response[@"data"]]];
                                               
                                                self.mobile = response[@"data"][@"shop"][@"mobile"];
                                                self.shop_im = response[@"data"][@"shop"][@"shop_im"];
                                                self.user_im = response[@"data"][@"shop"][@"user_im"];
                                         
                                               [self.table reloadData];
                                               
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];
                                       }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"XieshangLishiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XieshangLishiTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"MaiJiaShenqingTuikuanTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"MaiJiaShenqingTuikuanTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"MaiJiaTongYiTuiHuoTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"MaiJiaTongYiTuiHuoTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"MaiJiaYiTuiHuoTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"MaiJiaYiTuiHuoTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    /*
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{@"fundid":@(self.id)}];
        
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        //
//        self.mobile = x[@"mobile"];
//        self.shop_im = x[@"shop"][@"shop_im"];
//        self.user_im = x[@"shop"][@"user_im"];
        //


        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
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
     */
}

//初始化viewModel
- (XieshangLishiViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[XieshangLishiViewModel alloc] init];
    }
    return _viewModel;
}


@end
