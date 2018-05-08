//
//  ShetuanDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShetuanDetilViewController.h"
#import "ShetuanDetilViewModel.h"
#import "ShetuanDetilModel.h"
#import "shetuanChengyuanModel.h"
#import "shetuanZuppinModel.h"
#import "ShetuanLinxiModel.h"
#import "HuifuiPL.h"
#import "HunqinQuanModel.h"
#import "DongtaiDetilViewController.h"
@interface ShetuanDetilViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShetuanDetilViewModel *viewModel;
@property (strong,nonatomic) ShareNewmodel *sharemodel;

@end

@implementation ShetuanDetilViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.navigationItem.title = @"星辰策划师团队";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    [self shareData];
    [self addRightBtnWithTitle:nil image:@"分享的副本"];
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
    NSDictionary *dic = @{@"id":@(self.id)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxiangassociation"]
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
//- (IBAction)popaction:(UIButton *)sender {
//    [self popViewConDelay];
//}
//
//- (IBAction)popAC:(UIButton *)sender {
//    [self popViewConDelay];
//}

#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    //首页
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Dynamiclist *model  = x;
        
        Hunqinnewarray *modelnew = [[Hunqinnewarray alloc] init];
        modelnew.zan = model.myzan;
        modelnew.follow = model.follow;
        
        
        DongtaiDetilViewController *dongtai = [[DongtaiDetilViewController alloc] init];
        dongtai.id = model.id;
        dongtai.superModel = modelnew;
        
        [self pushToNextVCWithNextVC:dongtai];
    }];
    //作品
    [self.viewModel.zuopinUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        self.viewModel.modelZuopin = [shetuanZuppinModel mj_objectWithKeyValues:x];
        
        
    }];
    //成员
    [self.viewModel.chengyuanUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewModel.modelChengyuan = [shetuanChengyuanModel mj_objectWithKeyValues:x];
    }];
    //联系方式
    [self.viewModel.lianxifangshiUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewModel.modellianxi = [ShetuanLinxiModel mj_objectWithKeyValues:x];
    }];
    //评论
    [self.viewModel.pinglunseleUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger i = [x integerValue];
        [HuifuiPL showInView:self.view setid:i block:^(NSString *date) {
            [self.table.mj_header beginRefreshing];
        }];
    }];
    
    
    //点击回调
//商家详情
    [self.viewModel.selectRenSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        NSDictionary *dic = x;
        if ([dic[@"usertype"] isEqualToString:@"1"]) {
            
            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
            vc.id = [[NSString stringWithFormat:@"%@",dic[@"userid"]] integerValue];
            [self pushToNextVCWithNextVC:vc];
        }else {
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = [[NSString stringWithFormat:@"%@",dic[@"userid"]] integerValue];
            [self pushToNextVCWithNextVC:vc];
        }
        
        
    }];
    //作品详情
    [self.viewModel.selectZuopinSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
        vc.anlieID = [x integerValue];
        [self pushToNextVCWithNextVC:vc];
    }];
    //联系人
    [self.viewModel.selectLianxiRenmSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSString *ip = x;
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",ip];
        CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (version >= 10.0) {
            /// 大于等于10.0系统使用此openURL方法
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }];
    [self.viewModel.loginubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self isLogin];
    }];
    [self.viewModel.guanzhuUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.table.mj_header beginRefreshing];
    }];
    
    
}
- (void)isLogin{
    if (![UserDataNew UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
}
#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShetuanDetilTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShetuanDetilTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"DongtaiHeaderTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"DongtaiHeaderTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"DongtaiTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"DongtaiTableViewCell"];
    
    [self.table registerNib:[UINib nibWithNibName:@"ChengyuanOneTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ChengyuanOneTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ChengyuanTwoTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ChengyuanTwoTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ChengyuanThreeTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ChengyuanThreeTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.viewModel.markType = 0;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if ([UserDataNew UserLoginState]) {
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        }
        
        [dic setValue:@(self.id) forKey:@"id"];
        [dic setValue:@"100" forKey:@"rows"];
        
        [self.viewModel.refreshDataCommand execute:dic];
        [self.viewModel.chengyuanDataCommand execute:dic];
        
        [self.viewModel.zuopinDataCommand execute:@{@"id":@(self.id)}];
        [self.viewModel.lianxifangshiDataCommand execute:@{@"id":@(self.id)}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        self.viewModel.modelIndex = [ShetuanDetilModel mj_objectWithKeyValues:x];
        
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
}

//初始化viewModel
- (ShetuanDetilViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShetuanDetilViewModel alloc] init];
    }
    return _viewModel;
}


@end
