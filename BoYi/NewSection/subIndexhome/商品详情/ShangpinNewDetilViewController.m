//
//  ShangpinNewDetialViewController.m
//  BoYi
//
//  Created by heng on 2017/12/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangpinNewDetilViewController.h"
#import "shangpinShopCar.h"
#import "shangpinnewModel.h"
#import "SureDingdanNewSCViewController.h"
#import "shangpinHeaderView.h"
#import "shangpinOneTableViewCell.h"
#import "shangpinTwoTableViewCell.h"

@interface ShangpinNewDetilViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (strong,nonatomic) shangpinnewModel *model;
@property (strong,nonatomic) ShareNewmodel *sharemodel;

@property (strong,nonatomic) shangpinHeaderView *header;
@end

@implementation ShangpinNewDetilViewController
//- (void)viewWillAppear:(BOOL)animated {
//    
//    self.navigationController.navigationBarHidden = YES;
//    [super viewWillAppear:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = NO;
//    [super viewWillDisappear:animated];
//}
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    [self addPopBackBtn];
    [self setupTableView];
    [self getData];
    [self addRightBtnWithTitle:@"" image:@"分享的副本"];
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
- (void)setupTableView {
    
    [self.table registerNib:[UINib nibWithNibName:@"AnlieNewDetilTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnlieNewDetilTableViewCell"];
    //    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.header = [[NSBundle mainBundle]loadNibNamed:@"shangpinHeaderView" owner:nil options:nil].firstObject;
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    self.header.frame = CGRectMake(0, 0, ScreenWidth, 571);
    @weakify(self);
    [self.header.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
        vc.id = self.model.user.userid;
        [self pushToNextVCWithNextVC:vc];
    }];
    self.table.delegate             = self;
    self.table.dataSource           = self;
    self.table.emptyDataSetDelegate = self;
    self.table.emptyDataSetSource   = self;
    self.table.tableHeaderView = self.header;
}
- (void)getData{
    
//    @(self.shangpinID)
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([UserDataNew sharedManager].userInfoModel.token.token) {
        
        
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:@(self.shangpinID) forKey:@"id"];
    }else {
        [dic setValue:@(self.shangpinID) forKey:@"id"];
    }
    
    
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/User/commoditydetailsapp"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.model = [shangpinnewModel mj_objectWithKeyValues:response[@"data"]];
                                              
                                    self.isguanzhu.image = [UIImage imageNamed:self.model.shangpin.shopf ? @"已关注":@"关注"];
                                               self.header.model = self.model;
                                               [self.table reloadData];
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"mess age"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];

                                       }];
    [[RequestManager sharedManager] requestUrl:URL_New_share
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

- (IBAction)share:(UIButton *)sender {
    //分享
    
}

- (IBAction)payAC:(UIButton *)sender {
    if (![UserDataNew UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
    if (sender.tag == 0) {
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.user.userid] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) {
  
        if (self.model.user.mobile) {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:]];
            NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.model.user.mobile];
            CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
            if (version >= 10.0) {
                /// 大于等于10.0系统使用此openURL方法
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
            }

        }else  {
            [NavigateManager showMessage:@"暂无联系方式"];
        }
    }else if (sender.tag == 2) {
        if (self.model.shangpin.shopf) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.model.shangpin.shopid] forKey:@"id"];
            
            [self dianquxiao:dic];
        }else {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.model.shangpin.shopid] forKey:@"id"];
            [self dian:dic];
        }
    }else if (sender.tag == 3) {
        [shangpinShopCar showInView:self.view dic:self.model block:^(NSDictionary *dic) {
            NSLog(@"%@",dic);
            NSMutableDictionary *dicc = [[NSMutableDictionary alloc] init];
            [dicc setObject:dic[@"number"] forKey:@"quantity"];
            [dicc setObject:dic[@"skuid"] forKey:@"spec_id"];
            [dicc setObject:dic[@"token"] forKey:@"token"];
            [dicc setObject:dic[@"userid"] forKey:@"userid"];
            [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/cart/add"]
                                                method:POST
                                                loding:@""
                                                   dic:dicc
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   
                                                   
                                                   sender.enabled = YES;
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       [NavigateManager showMessage:@"已添加到购物车"];
                                                   }else{
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                                   
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   sender.enabled = YES;
                                                   [NavigateManager showMessage:@"网络连接失败"];
                                               }];
        }];
    }else {
        [shangpinShopCar showInView:self.view dic:self.model block:^(NSDictionary *dic) {
            NSLog(@"%@",dic);
            
            SureDingdanNewSCViewController *sure = [[SureDingdanNewSCViewController alloc] init];
            sure.type = 1;
            sure.dic = dic;
            [self pushToNextVCWithNextVC:sure];
        }];
    }
}

- (IBAction)popAC:(UIButton *)sender {
    [self popViewConDelay];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
- (void)dian:(NSDictionary *)dic{

    [[RequestManager sharedManager] requestUrl:URL_New_shangpinGuanzhu
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {

                                               self.isguanzhu.image = [UIImage imageNamed:@"已关注"];
                                               self.model.shangpin.shopf = 1;
                                           }else{

                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {

                                       }];
}
- (void)dianquxiao:(NSDictionary *)dic{
    
    [[RequestManager sharedManager] requestUrl:URL_New_shangpinquxiaoGuanzhu
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.isguanzhu.image = [UIImage imageNamed:@"关注"];
                                               self.model.shangpin.shopf = 0;
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.model) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        
        NSInteger zhangshu = self.model.shangpin.shopimg.count;
        return 34 +  240 * zhangshu + 20;
        //108 文字高度
    }else {
        NSInteger zhangshu = self.model.tebietuijian.count;
        
        return 76 +  185 * (zhangshu / 2 + zhangshu % 2) + 10;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        
        shangpinOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shangpinOneTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"shangpinOneTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else {
        shangpinTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shangpinTwoTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"shangpinTwoTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.model = self.model;
        @weakify(self);
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            TebietuijianSP *model = x;
            ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
            vc.shangpinID = model.shopid;
            [self pushToNextVCWithNextVC:vc];
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
}
@end

