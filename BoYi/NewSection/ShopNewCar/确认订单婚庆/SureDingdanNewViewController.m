//
//  SureDingdanNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "SureDingdanNewViewController.h"
#import "SureDingdanNewViewModel.h"
#import "SureDingdanNewModel.h"
#import "ShouyinTaiViewController.h"
@interface SureDingdanNewViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) SureDingdanNewViewModel *viewModel;
@property (strong,nonatomic) NSString *price;
@end

@implementation SureDingdanNewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 84;
    }
    self.navigationItem.title = @"确认订单";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    NSLog(@"%@",self.navigationController);
}


#pragma mark - 点击事件

- (IBAction)action:(UIButton *)sender {
    if (self.type == 1) {//确认订单
        __weak typeof(self)weakSelf = self;
        NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:self.dic];
        dictM[@"remark"] = self.viewModel.note ? self.viewModel.note : @"";
        self.dic = dictM;
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/buyweddingapp"] method:POST loding:@"" dic:self.dic progress:nil success:^(NSURLSessionDataTask *task, id response) {
            if ([response[@"code"] integerValue] == 0) {
                ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
                shou.price = [NSString stringWithFormat:@"%@",self.viewModel.model.cartlist[0].goods[0].heji];
                NSMutableDictionary *dics = [[NSMutableDictionary alloc] initWithDictionary:weakSelf.dic];
                shou.dicm1 = dics;
                shou.orderNumber = response[@"data"];
                shou.type = 1;
                [weakSelf pushToNextVCWithNextVC:shou];
            }else{
                [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [NavigateManager showMessage:@"网络连接失败"];
        }];
        
    }else {
        [NavigateManager showLoadingMessage:@"正在提交..."];
        NSMutableArray *rec_idarray = [NSMutableArray array];
        NSMutableArray *liuyanidarray = [NSMutableArray array];
        NSMutableArray *remarkarray = [NSMutableArray array];
        for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
            for (int j = 0; j < self.viewModel.dataArray[i].goods.count; j ++) {
                [rec_idarray addObject:[NSString stringWithFormat:@"%ld",self.viewModel.dataArray[i].goods[j].rec_id]];
            }
        }
        for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
            [remarkarray addObject:self.viewModel.dataArray[i].liulan];
            
        }
        for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
            [liuyanidarray addObject:[NSString stringWithFormat:@"%ld",self.viewModel.dataArray[i].seller.userid]];
        }
        NSString *rec_id = [rec_idarray componentsJoinedByString:@"_"];
        NSString *liuyanid = [liuyanidarray componentsJoinedByString:@"_"];
        NSString *remark = [remarkarray componentsJoinedByString:@"_"];
        
        NSDictionary *dic = @{@"liuyanid":liuyanid,@"rec_id":rec_id,@"remark":remark,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/carthq/carttoorder"]
                                            method:POST
                                            loding:nil
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager hiddenLoadingMessage];
                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       
                                                       ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
                                                       shou.type = 2;
                                                       shou.bianhao = response[@"data"];
                                                       shou.price = self.price;
                                                       [self pushToNextVCWithNextVC:shou];
                                                   });
                                                   
                                               }else {
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               [NavigateManager showMessage:@"网络链接失败"];
                                               
                                           }];
        
    }
    
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(SureDingdanNewModel *x) {
        @strongify(self);
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
    
    
    [self.table registerNib:[UINib nibWithNibName:@"SureDingdanNewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SureDingdanNewTableViewCell"];
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
        self.viewModel.type = self.type;
        if (self.type == 1) {
            [self.viewModel.refreshDataCommand execute:self.dic];
        }else {
            NSDictionary *dicc = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),@"rec_id":self.idPingjie};
            [self.viewModel.refreshDataCommand execute:dicc];
        }
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        //刷新视图
        [self.table reloadData];
        [self hejiMoney];
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}
- (void)hejiMoney{
    
    float money = 0.00;
    for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
        for (int j = 0; j < self.viewModel.dataArray[i].goods.count; j ++) {
            if (self.viewModel.dataArray[i].goods[j].paytype == 1) {//quan
                money = money + [self.viewModel.dataArray[i].goods[j].price floatValue] * self.viewModel.dataArray[i].goods[j].quantity;
            }else {//ding
                money = money + [self.viewModel.dataArray[i].goods[j].partprice floatValue] * self.viewModel.dataArray[i].goods[j].quantity;
            }
            
        }
    }
    self.number.text = [NSString stringWithFormat:@"共%ld件商品",self.viewModel.model.allcount];
    if (self.viewModel.model.cartlist.count > 0) {
        if (self.viewModel.model.cartlist[0].goods.count > 0) {
            self.price = [NSString stringWithFormat:@"%@",self.viewModel.model.cartlist[0].goods[0].heji] ;
            self.xiaoji.text = [NSString stringWithFormat:@"¥ %@",self.viewModel.model.cartlist[0].goods[0].heji];
            self.zongji.text = [NSString stringWithFormat:@"¥ %@",self.viewModel.model.cartlist[0].goods[0].heji];
        }
    }
    
}
//初始化viewModel
- (SureDingdanNewViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SureDingdanNewViewModel alloc] init];
    }
    return _viewModel;
}


@end
