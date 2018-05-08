//
//  BaojiaDetilViewController.m
//  BoYi
//
//  Created by heng on 2017/12/23.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "BaojiaDetilViewController.h"
#import "BaojiaDetilViewModel.h"
#import "BaojiaDetilModel.h"
#import "baojiaShopCar.h"
#import "NewShangjiaViewController.h"
#import "SureDingdanNewViewController.h"


@interface BaojiaDetilViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) BaojiaDetilViewModel *viewModel;
@property (strong,nonatomic) ShareNewmodel *sharemodel;
@end

@implementation BaojiaDetilViewController


- (IBAction)gouwuche:(UIButton *)sender {
    
    if (sender.tag == 0) {
        [self.table setContentOffset:CGPointMake(0,0) animated:YES];
    }else {
        SHopcarTwoViewController *orderSub = [[SHopcarTwoViewController alloc] init];
        orderSub.titleColorSelected = MAINCOLOR;
        orderSub.menuViewStyle = WMMenuViewStyleLine;
        orderSub.automaticallyCalculatesItemWidths = YES;
        orderSub.progressWidth = 40;
        orderSub.progressViewIsNaughty = YES;
        orderSub.scrollEnable = NO;
        orderSub.index = 0;
        orderSub.showOnNavigationBar = NO;
        orderSub.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:orderSub];
        
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"报价详情";
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
- (IBAction)popAC:(UIButton *)sender {
    [self popViewConDelay];
}
- (void)shareData{
    NSDictionary *dic = @{@"id":@(self.baojiaid)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxiangbaojia"]
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

- (IBAction)allAction:(UIButton *)sender {
    if (![UserDataNew UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
    if (sender.tag == 0) {
        //im
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.viewModel.model.user.userid] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) {
        if (self.viewModel.model.user.mobile) {
            NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.viewModel.model.user.mobile];
            CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
            if (version >= 10.0) {
                /// 大于等于10.0系统使用此openURL方法
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
            }
        }
    }else if (sender.tag == 2) {
        if (self.viewModel.model.userf) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.baojia.quotationid] forKey:@"id"];
            [self.viewModel.deleguanzhuCommand execute:dic];
        }else {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.baojia.quotationid] forKey:@"id"];
            [self.viewModel.addguanzhuCommand execute:dic];
        }
    }else if (sender.tag == 3) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":self.viewModel.model.baojia.name,@"header":[NSString stringWithFormat:@"%@",self.viewModel.model.baojia.imglist[0]],@"price":[NSString stringWithFormat:@"%@",self.viewModel.model.baojia.price],@"temporarypay":self.viewModel.model.baojia.temporarypay}];
        NSMutableArray *array;
        [AddShopCar showInView:self.view array:array dic:dic string:S_Integer(self.viewModel.model.baojia.quotationid) block:^(NSDictionary *dic) {
    
            [NavigateManager showMessage:@"已添加到购物车"];
        }];
    }else {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":self.viewModel.model.baojia.name,@"header":[NSString stringWithFormat:@"%@",self.viewModel.model.baojia.imglist[0]],@"price":[NSString stringWithFormat:@"%@",self.viewModel.model.baojia.price],@"temporarypay":self.viewModel.model.baojia.temporarypay}];
        NSMutableArray *array;
        [baojiaShopCar showInView:self.view array:array dic:dic string:S_Integer(self.viewModel.model.baojia.quotationid) block:^(NSDictionary *dic) {
            NSString *baojiaid = dic[@"baojiaid"];
            NSString *paytype = dic[@"paytype"];
            NSString *quantity = dic[@"quantity"];
            NSString *baojiadate = dic[@"baojiadate"];
            NSString *baojiatime = dic[@"baojiatime"];
            NSDictionary *dicm = @{@"baojiadate":baojiadate,@"baojiatime":baojiatime,@"baojiaid":baojiaid,@"paytype":paytype,@"quantity":quantity,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
            
            SureDingdanNewViewController *sure = [[SureDingdanNewViewController alloc] init];
            sure.dic = dicm;
            sure.type = 1;
            [self pushToNextVCWithNextVC:sure];
        }];
    }
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    //点击其他的案列
    [self.viewModel.selectItemSubject subscribeNext:^(Youlikebaojia *x) {
        @strongify(self);
        BaojiaDetilViewController *baojia = [[BaojiaDetilViewController alloc] init];
        baojia.baojiaid = x.quotationid;
        [self pushToNextVCWithNextVC:baojia];
//        self.baojiaid = x.quotationid;
//        [self.table.mj_header beginRefreshing];
    }];
    //查看商家详情
    [self.viewModel.lookSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NewShangjiaViewController *new = [[NewShangjiaViewController alloc] init];
        new.shopid = self.viewModel.model.user.userid;
        [self pushToNextVCWithNextVC:new];
    }];
    //关注
    [self.viewModel.addguanUISubject subscribeNext:^(id  _Nullable x) {
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.model.userf = 1;
            self.isGuanzhuImage.image = [UIImage imageNamed:@"已关注"];
        }
    }];
    //取消关注
    [self.viewModel.deleteguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.model.userf = 0;
            self.isGuanzhuImage.image = [UIImage imageNamed:@"关注"];
        }
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"BaojiaDetilTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BaojiaDetilTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        
        if ([UserDataNew UserLoginState]) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:@(self.baojiaid) forKey:@"id"];
            [self.viewModel.refreshDataCommand execute:dic];
        }else {
            [self.viewModel.refreshDataCommand execute:@{@"id":@(self.baojiaid)}];
        }
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        if (self.viewModel.model.userf) {
            self.isGuanzhuImage.image = [UIImage imageNamed:@"已关注"];
        }else {
            self.isGuanzhuImage.image = [UIImage imageNamed:@"关注"];
        }
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

//初始化viewModel
- (BaojiaDetilViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BaojiaDetilViewModel alloc] init];
    }
    return _viewModel;
}


@end
