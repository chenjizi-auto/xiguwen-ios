//
//  DongtaiDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "DongtaiDetilViewController.h"
#import "DongtaiDetilViewModel.h"
#import "DongtaiDetilModel.h"
#import "HuifuiPL.h"
#import "DongraiDetilHeader.h"
#import "MJPhoto.h"
#import "DongtaiDetilModel.h"
#import "MJPhotoBrowser.h"

@interface DongtaiDetilViewController ()

@property (weak, nonatomic) IBOutlet UIButton *dianZanBtn;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) DongtaiDetilViewModel *viewModel;

@end

@implementation DongtaiDetilViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"动态详情";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}

- (void)popViewConDelay
{
    [self.refreshDataSubject sendNext:@YES];
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
#pragma mark - 点击事件

- (IBAction)dianZorPingLun:(UIButton *)sender {
    if (![UserDataNew UserLoginState]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserNotLoginIn_ToLogin" object:nil];
        return;
    }
    if (sender.tag == 0) {//评论
        
        [HuifuiPL showInView:self.view setid:self.viewModel.model.id block:^(NSString *date) {
            [self.table.mj_header beginRefreshing];
        }];
    }else {//点赞
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.id] forKey:@"id"];
        if (self.viewModel.model.myzan == 1) {
//            [NavigateManager showMessage:@"您已点过赞"];
//            return ;
            [self.viewModel.deleteDianzanCommand execute:dic];
        } else {
            [self.viewModel.dianzanCommand execute:dic];
        }
    }
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(DongtaiDetilModel *x) {
        @strongify(self);
    }];
    
    [self.viewModel.refreshdateSubject subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.viewModel.model.myzan = [x integerValue];
        self.superModel.shifouzan = self.viewModel.model.myzan;
        self.viewModel.model.zan += [x integerValue] ? 1 : -1;
        self.superModel.zan = self.viewModel.model.zan;
        [self showDianZan:[x integerValue]];
    }];
    [self.viewModel.deleguanzhuSubject subscribeNext:^(DongtaiDetilModel *x) {
        @strongify(self);
        self.viewModel.model.follow = 0;
        
        [self refreshHeaderGuanzhu];
        
    }];
    [self.viewModel.addguanzhuSubject subscribeNext:^(DongtaiDetilModel *x) {
        @strongify(self);
        self.viewModel.model.follow = 1;
        [self refreshHeaderGuanzhu];
        
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
    
    
    [self.table registerNib:[UINib nibWithNibName:@"DongtaiDetilTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DongtaiDetilTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"PinglunTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"PinglunTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    self.viewModel.isPinglun = 1;
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:@(self.id)forKey:@"id"];
        
        [self.viewModel.refreshDataCommand execute:dic];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        [self showDianZan:self.viewModel.model.myzan == 1];
        [self configHeader];
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
- (void)refreshHeaderGuanzhu {
    
    self.superModel.follow = self.viewModel.model.follow;
    DongraiDetilHeader *header = (DongraiDetilHeader *)self.table.tableHeaderView;
    if (self.viewModel.model.follow == 1) {
        [header.guanzhuBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
    }else {
        [header.guanzhuBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];
    }
}
- (void)configHeader {
    DongraiDetilHeader *header = [[NSBundle mainBundle]loadNibNamed:@"DongraiDetilHeader" owner:nil options:nil].firstObject;
    
    
    NSInteger zhangshu;
    if (self.viewModel.model.photourl.count == 0) {
        zhangshu = 0;
    }else if (self.viewModel.model.photourl.count > 0 && self.viewModel.model.photourl.count < 4) {
        zhangshu = 1;
    }else if (self.viewModel.model.photourl.count > 3 && self.viewModel.model.photourl.count < 7) {
        zhangshu = 2;
    }else {
        zhangshu = 3;
    }
    
    CGFloat cellWidth = ScreenWidth - 32;
    CGSize size = [self.viewModel.model.content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
    
    CGFloat width = (ScreenWidth - 60.0) / 3.0 + 10;
    header.frame = CGRectMake(0, 0, ScreenWidth, 64 + 75 + 13 + size.height + width * zhangshu);
    
    @weakify(self);
    [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x integerValue] == 0) {
            
            return ;
        } else if ([x integerValue] == 1){
            self.viewModel.isPinglun = 1;
        } else {
            self.viewModel.isPinglun = 0;
        }
        
        NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:0];    //刷新第3段
        [self.table setContentOffset:CGPointZero animated:NO];
        [self.table reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationNone];
    }];
    [header.gotoNextVc1 subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        if (![UserDataNew UserLoginState]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserNotLoginIn_ToLogin" object:nil];
            return;
        }
        if (self.viewModel.model.userid == [UserDataNew sharedManager].userInfoModel.user.userid) {
            [NavigateManager showMessage:@"不能关注自己哦~"];
            return;
        }
        [header.guanzhuBtn setImage:[UIImage imageNamed:self.viewModel.model.follow ? @"加关注":@"取消关注"] forState:UIControlStateNormal];
        
        if (self.viewModel.model.follow == 1) {//已关注
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.userid] forKey:@"id"];
            [self.viewModel.deleguanzhuCommand execute:dic];
            
            
        }else {//关注
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.userid] forKey:@"id"];
            [self.viewModel.addguanzhuCommand execute:dic];
        }
    }];
    [header.clickImageSubject subscribeNext:^(NSIndexPath *x) {
       @strongify(self);
        
        NSMutableArray *arr = [NSMutableArray array];
        for (PhotourldongtaiD *model in self.viewModel.model.photourl) {
            [arr addObject:model.photourl];
        }
        [self tapImage:arr index:x.row];
    }];
    [header.headerimage addTap_click:^{
        @strongify(self);
        if (self.index == 1) {
            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
            vc.id = self.viewModel.model.userid;
            [self pushToNextVCWithNextVC:vc];
        } else {
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = self.viewModel.model.userid;
            [self pushToNextVCWithNextVC:vc];
        }
        
    }];
    header.model = self.viewModel.model;
    self.table.tableHeaderView = nil;
    self.table.tableHeaderView = header;
}

//初始化viewModel
- (DongtaiDetilViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[DongtaiDetilViewModel alloc] init];
    }
    return _viewModel;
}

- (void)showDianZan:(BOOL)isDian {
    if (isDian) {
        
        [self.dianZanBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        [self.dianZanBtn setTitle:@"已点赞" forState:UIControlStateNormal];
    } else {
        [self.dianZanBtn setImage:[UIImage imageNamed:@"未点赞"] forState:UIControlStateNormal];
        [self.dianZanBtn setTitle:@"点赞" forState:UIControlStateNormal];
    }
    DongraiDetilHeader *header = (DongraiDetilHeader *)self.table.tableHeaderView;
    
    header.dianzanNumber.text = [NSString stringWithFormat:@"赞 %ld",self.viewModel.model.zan];
}

- (void)tapImage:(NSArray *)urls index:(NSInteger)index
{
    NSInteger count = urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        
        // 替换为中等尺寸图片
        NSString *url = urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = nil;//self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;//tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}



- (RACSubject *)refreshDataSubject {
    if (!_refreshDataSubject) {
        _refreshDataSubject = [RACSubject subject];
    }
    return _refreshDataSubject;
}
@end
