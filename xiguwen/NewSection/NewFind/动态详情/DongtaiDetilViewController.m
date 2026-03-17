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
#import "FindReportViewController.h"

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
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftItemsSupplementBackButton = NO;
    [self setupBackButton];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}

- (void)setupBackButton {
    [self addPopBackBtn];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self clearNavigationButtonBackgrounds];
}

- (void)clearNavigationButtonBackgrounds {
    [self clearNavigationButtonBackgroundForItem:self.navigationItem.leftBarButtonItem];
}

- (void)clearNavigationButtonBackgroundForItem:(UIBarButtonItem *)item {
    UIView *view = item.customView;
    NSInteger depth = 0;
    while (view && depth < 4) {
        view.backgroundColor = UIColor.clearColor;
        view.layer.cornerRadius = 0.0;
        view.layer.masksToBounds = NO;
        if ([view isKindOfClass:[UIControl class]]) {
            UIControl *control = (UIControl *)view;
            control.selected = NO;
            control.highlighted = NO;
        }
        view = view.superview;
        depth++;
    }
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
    if (!self.viewModel.model) {
        [NavigateManager showMessage:@"数据加载中，请稍后"];
        return;
    }
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
    self.viewModel.tableView        = self.table;
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
    if (!self.viewModel.model) {
        return;
    }
    DongraiDetilHeader *header = [[NSBundle mainBundle]loadNibNamed:@"DongraiDetilHeader" owner:nil options:nil].firstObject;
    
    
    NSInteger photoCount = 0;
    NSArray *photos = ([self.viewModel.model.photourl isKindOfClass:[NSArray class]] ? self.viewModel.model.photourl : @[]);
    for (id item in photos) {
        NSString *urlString = nil;
        if ([item isKindOfClass:[PhotourldongtaiD class]]) {
            urlString = ((PhotourldongtaiD *)item).photourl;
        } else if ([item isKindOfClass:[NSDictionary class]]) {
            urlString = item[@"photourl"] ?: item[@"url"];
        } else if ([item isKindOfClass:[NSString class]]) {
            urlString = (NSString *)item;
        }
        if (urlString.length > 0) {
            photoCount += 1;
        }
    }
    
    CGFloat gridHeight = [DongraiDetilHeader gridHeightForPhotoCount:photoCount];
    
    @weakify(self);
    [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (!self.viewModel.model) {
            [NavigateManager showMessage:@"数据加载中，请稍后"];
            return;
        }
        if ([x integerValue] == 88) {
            [FindReportViewController showDiscomfortContentAlertWithNav:self.navigationController dyid:self.id results:^(BOOL isSuccess) {
                @strongify(self);
                if (self.didShieldReload) {
                    self.didShieldReload();
                }
                [self.navigationController popViewControllerAnimated:true];
            }];
            return;
        }
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
        if (!self.viewModel.model) {
            [NavigateManager showMessage:@"数据加载中，请稍后"];
            return;
        }
        
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
        NSArray *urls = header.hotArray ?: @[];
        if (urls.count == 0) {
            [NavigateManager showMessage:@"图片不可用"];
            return;
        }
        [self tapImage:urls index:x.row];
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
    UIView *tabBar = [header viewWithTag:9011];
    tabBar.hidden = YES;
    header.frame = CGRectMake(0, 0, ScreenWidth, 1);
    [header setNeedsLayout];
    [header layoutIfNeeded];
    CGFloat headerHeight = [self headerContentHeightForHeader:header excludingView:tabBar];
    header.frame = CGRectMake(0, 0, ScreenWidth, headerHeight);
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
    [self.viewModel updateStickyHeader];
}

- (void)tapImage:(NSArray *)urls index:(NSInteger)index
{
    NSInteger count = urls.count;
    if (count == 0) {
        return;
    }
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    NSInteger targetIndex = NSNotFound;
    for (NSInteger i = 0; i < count; i++) {
        id item = urls[i];
        NSString *urlString = ([item isKindOfClass:[NSString class]] ? (NSString *)item : nil);
        if (urlString.length == 0) {
            continue;
        }
        NSURL *url = [NSURL URLWithString:urlString];
        if (!url) {
            continue;
        }
        if (i == index) {
            targetIndex = photos.count;
        }
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = url; // 图片路径
        photo.srcImageView = nil;// 来源于哪个UIImageView
        [photos addObject:photo];
    }
    if (photos.count == 0) {
        [NavigateManager showMessage:@"图片不可用"];
        return;
    }
    if (targetIndex == NSNotFound) {
        targetIndex = 0;
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = targetIndex;
    browser.photos = photos;
    [browser show];
}



- (RACSubject *)refreshDataSubject {
    if (!_refreshDataSubject) {
        _refreshDataSubject = [RACSubject subject];
    }
    return _refreshDataSubject;
}

- (CGFloat)headerContentHeightForHeader:(UIView *)header excludingView:(UIView *)excluded {
    CGFloat maxY = 0.0;
    for (UIView *subview in header.subviews) {
        if (subview == excluded || subview.hidden || subview.alpha <= 0.01) {
            continue;
        }
        CGFloat bottom = CGRectGetMaxY(subview.frame);
        if (bottom > maxY) {
            maxY = bottom;
        }
    }
    return ceil(maxY);
}
@end
