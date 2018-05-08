//
//  SureDingdanNewSCViewController.m
//  BoYi
//
//  Created by heng on 2018/3/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SureDingdanNewSCViewController.h"
#import "SureDingdanNewSCViewModel.h"
#import "SureDingdanNewModel.h"
#import "ShouyinTaiViewController.h"
#import "ShouHuodizhiViewController.h"
#import "ShouHuodizhiModel.h"
@interface SureDingdanNewSCViewController (){
    NSString *shouhuoID,*number,*skuid,*content;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) SureDingdanNewSCViewModel *viewModel;
@property (strong,nonatomic) NSMutableArray <Addressarray *>*dataArray;
@property (strong,nonatomic) NSString *price;
@end

@implementation SureDingdanNewSCViewController
- (void)viewWillAppear:(BOOL)animated{
    [self getaddress];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (isIPhoneX) {
        self.height.constant = 84;
    }
    self.navigationItem.title = @"确认订单";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}
- (IBAction)dizhiaction:(UIButton *)sender {
    ShouHuodizhiViewController *dizhi = [[ShouHuodizhiViewController alloc] init];
    [self pushToNextVCWithNextVC:dizhi];
}
- (void)hejiMoney{
    
    float money = 0.00;
    for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
        for (int j = 0; j < self.viewModel.dataArray[i].goods.count; j ++) {
            money = money + [self.viewModel.dataArray[i].goods[j].price floatValue] * self.viewModel.dataArray[i].goods[j].quantity;
            
        }
    }
    self.number.text = [NSString stringWithFormat:@"共%ld件商品",self.viewModel.model.allcount];
    number = [NSString stringWithFormat:@"%ld",self.viewModel.model.allcount];
    self.price = [NSString stringWithFormat:@"%.2f",money];
    self.xiaoji.text = [NSString stringWithFormat:@"%.2f",money];
    self.zongji.text = [NSString stringWithFormat:@"¥ %.2f",money];
}
- (void)getaddress{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Address/addresslist"]
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           [NavigateManager hiddenLoadingMessage];
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.dataArray = [NSMutableArray array];
                                               [self.dataArray addObjectsFromArray:[Addressarray mj_objectArrayWithKeyValuesArray:response[@"data"]]];
                                               if (self.dataArray.count == 0) {
                                                   
                                               }else {
                                                   for (int i = 0; i < self.dataArray.count; i ++) {
                                                       Addressarray *model = self.dataArray[i];
                                                       if (model.hot) {
                                                           self.name.text = [NSString stringWithFormat:@"收货人:%@",model.username];
                                                           if ([model.province isBlankString]) {
                                                               self.address.text = [NSString stringWithFormat:@"收货地址:%@%@%@",model.city,model.county,model.site];
                                                           }else {
                                                               self.address.text = [NSString stringWithFormat:@"收货地址:%@%@%@%@",model.province,model.city,model.county,model.site];
                                                           }
                                                           shouhuoID = [NSString stringWithFormat:@"%ld",model.id];
                                                           
                                                           
                                                       }
                                                       
                                                   }
                                                   if ([[NSString stringWithFormat:@"%@",shouhuoID] isBlankString]) {
                                                       Addressarray *model = self.dataArray[0];
                                                       self.name.text = [NSString stringWithFormat:@"收货人:%@",model.username];
                                                       if ([model.province isBlankString]) {
                                                           self.address.text = [NSString stringWithFormat:@"收货地址:%@%@%@",model.city,model.county,model.site];
                                                       }else {
                                                           self.address.text = [NSString stringWithFormat:@"收货地址:%@%@%@%@",model.province,model.city,model.county,model.site];
                                                       }
                                                       shouhuoID = [NSString stringWithFormat:@"%ld",model.id];
                                                   }

                                               }
                                               
                                           }else{
                                               
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           
                                       }];
}

#pragma mark - 点击事件

- (IBAction)action:(UIButton *)sender {
    if ([[NSString stringWithFormat:@"%@",shouhuoID] isBlankString]) {
        [NavigateManager showMessage:@"请填写收货地址"];
        return;
    }
    if (self.type == 1) {
      //立即
        ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
        shou.price = self.price;
        NSMutableDictionary *dics = [[NSMutableDictionary alloc] init];
        [dics setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dics setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dics setObject:shouhuoID forKey:@"siteid"];
        [dics setObject:number forKey:@"number"];
        [dics setObject:@(self.viewModel.dataArray[0].goods[0].rec_id) forKey:@"skuid"];
        [dics setObject:@"" forKey:@"content"];
        
        shou.dicm3 = dics;
        shou.type = 3;
        [self pushToNextVCWithNextVC:shou];
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
//            [remarkarray addObject:self.viewModel.dataArray[i].liulan];
            
        }
        for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
            [liuyanidarray addObject:[NSString stringWithFormat:@"%ld",self.viewModel.dataArray[i].seller.userid]];
        }
        NSString *rec_id = [rec_idarray componentsJoinedByString:@"_"];
        NSString *remark = [remarkarray componentsJoinedByString:@"_"];
        
        NSDictionary *dic = @{@"address":shouhuoID,@"rec_id":rec_id,@"content":remark,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
        [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/cart/cartoorder"]
                                            method:POST
                                            loding:nil
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager hiddenLoadingMessage];
                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       
                                                       ShouyinTaiViewController *shou = [[ShouyinTaiViewController alloc] init];
                                                       shou.type = 4;
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
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"SureDingDanNewSCTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SureDingDanNewSCTableViewCell"];
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
        [self hejiMoney];
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
- (SureDingdanNewSCViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SureDingdanNewSCViewModel alloc] init];
    }
    return _viewModel;
}


@end
