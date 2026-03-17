//
//  NewPeopleDetilViewController.m
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewPeopleDetilViewController.h"
#import "NewPeopleDetilViewModel.h"
#import "MapCollectionViewCell.h"
#import "ZuoPinCollectionViewCell.h"
#import "AddShopCar.h"
#import "fuwuModel.h"
#import "ScheduleModel.h"
#import "ShopCarList.h"
#import "SurePayViewController.h"
#import "UIImage+GIF.h"
#import "TeamCollectionViewCell.h"
#import "FindDetailViewController.h"
#import "VideoViewController.h"
#import "NewHeaderDetil.h"
#import "EvaluationManagementModel.h"
@interface NewPeopleDetilViewController ()<UIScrollViewDelegate,FSCalendarDelegate,FSCalendarDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}

@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (strong,nonatomic)NSMutableArray *reamArray;
@property (strong,nonatomic)NSMutableArray *fuwuxiangArray;
@property (strong,nonatomic)NSMutableArray *dangqiArray;

@property (assign,nonatomic)BOOL isGuanzhuMark;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NewPeopleDetilViewModel *viewModel;

@end

@implementation NewPeopleDetilViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    [self addPopBackBtn];
    
    [self setupTableView];
}


#pragma mark - 点击事件



#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"NewPeopleDetilTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewPeopleDetilTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self headerView];
    @weakify(self);
    
    NSString *city = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
    self.viewModel.userId = self.userId;
    [self.viewModel.refreshDataCommand execute:@{@"user_id":self.userId, @"city":city}];
    
    [self.viewModel.fuwuXiangmuCommand execute:@{@"userId":self.userId}];
    
    
    //look
    if ([UserData UserLoginState]) {
        [self.viewModel.GetShopDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id), @"followuserid":self.userId}];
    }
    
    [self.viewModel.addguanUISubject subscribeNext:^(id  _Nullable x) {
        
        
        if (x[@"r"]) {
            if ([x[@"status"] integerValue] == 200) {
                self.isGuanzhuMark = YES;
                
                [self isChangeGuanzhu];
            }
            
        }
        
    }];
    [self.viewModel.deleteguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if (x[@"r"]) {
            if ([x[@"status"] integerValue] == 200) {
                self.isGuanzhuMark = NO;
                [self isChangeGuanzhu];
            }
            
        }
        
    }];
    //关注
    [self.viewModel.guanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if (x[@"r"]) {
            
            if ([x[@"r"] integerValue] == 1) {

                self.isGuanzhuMark = YES;

            }else {

                self.isGuanzhuMark = NO;
            }

            [self isChangeGuanzhu];
        }
        
        
    }];
    //    总数据请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [self.viewModel.PLGLCommand execute:@{@"userId":self.userId,
                                              @"curPage":@1,
                                              @"pageSize":@100}];
        //数据处理
        
        self.viewModel.model = [peopleDetailModel mj_objectWithKeyValues:x];
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        //刷新视图
        NewHeaderDetil *header = (NewHeaderDetil *)self.table.tableHeaderView;
        header.model = self.viewModel.model;
        [self.table reloadData];
    }];
    //评论
    [self.viewModel.PLGLSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        self.viewModel.arrayPL  = [NSMutableArray array];
        
        NSMutableArray *ar = [EvaluationManagementModel mj_objectArrayWithKeyValuesArray:x[@"r"][@"rows"]];
        for (int i = 0; i < ar.count; i ++) {
            EvaluationManagementModel *model = ar[i];
            if (model.customCommont) {
                [self.viewModel.arrayPL addObject:ar[i]];
            }
        }
        NewHeaderDetil *header = (NewHeaderDetil *)self.table.tableHeaderView;
        header.getNumberString = self.viewModel.arrayPL.count == 0 ? @"0":[NSString stringWithFormat:@"%lu",(unsigned long)self.viewModel.arrayPL.count];
        [self.table reloadData];
    }];
    
    //服务项
    [self.viewModel.fuwuxiangmuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        self.fuwuxiangArray = [Esarrayqw mj_objectArrayWithKeyValuesArray:x[@"r"]];
        
    }];
    [self.viewModel.lookDQUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [self.dangqiArray removeAllObjects];
        [self.dangqiArray addObjectsFromArray:[ScheduleModel mj_objectArrayWithKeyValuesArray:x[@"r"]]];
       
    }];
    [self.viewModel.selectZuoSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        ExamplelistYQ *model = x;
        if (model.exampleType == 3) {
            
            FindDetailViewController *find = [[FindDetailViewController alloc] init];
            find.idString = [NSString stringWithFormat:@"%ld",(long)model.id];
            [self pushToNextVCWithNextVC:find];
            
        }else {
            VideoViewController *video = [[VideoViewController alloc] init];
            video.urlString = model.descn;
            [self pushToNextVCWithNextVC:video];
        }
        
    }];
    [self.viewModel.selectTuanSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        
        self.userId = x;
        
        NSString *city = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
        
        self.viewModel.userId = self.userId;
        
        [self.viewModel.refreshDataCommand execute:@{@"user_id":self.userId, @"city":city}];
        
        [self.viewModel.fuwuXiangmuCommand execute:@{@"userId":self.userId}];
    
        
    }];
    
    
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
        [self.table reloadData];
    }];
}

#pragma mark - 点击事件

- (void)isChangeGuanzhu{
    NewHeaderDetil *header = (NewHeaderDetil *)self.table.tableHeaderView;
    if (self.isGuanzhuMark) {
        header.isMarkGuanzhu = YES;
        self.guanzhulabel.textColor = RGBA(255, 83, 132, 1);
        self.guanzhuimage.image = [UIImage imageNamed:@"关注"];
    }else {

        self.guanzhulabel.textColor = RGBA(102, 102, 102, 1);
        self.guanzhuimage.image = [UIImage imageNamed:@"关注_灰"];
        header.isMarkGuanzhu = NO;
    }
    [self.table reloadData];
}



- (void)headerView{
    
    NewHeaderDetil *header = [[NSBundle mainBundle]loadNibNamed:@"NewHeaderDetil" owner:nil options:nil].firstObject;
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.frame = CGRectMake(0, 0, ScreenWidth, 280);
    self.table.tableHeaderView = header;
    @weakify(self);
    [header.gotoNextVcBtn subscribeNext:^(id  _Nullable x) {
        
        
        NSIndexPath *scrollIndexPath;
        
        @strongify(self);
        if ([x integerValue] == 11) {
            scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        }else if ([x integerValue] == 12){
            scrollIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        }else if ([x integerValue] == 13){
            scrollIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        }else {
            scrollIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        }
        [self.table scrollToRowAtIndexPath:scrollIndexPath
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }];
    [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
        
        
        @strongify(self);
        //是否登录
        if (![UserData UserLoginState]) {
            //预约cell
            NewLoginViewController *vc = [[NewLoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
        [self isGuanzhuaction];

    }];
    
}
- (void)isGuanzhuaction{
    if (self.isGuanzhuMark) {
        
        [self.viewModel.deleguanzhuCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id), @"followuserid":[NSString stringWithFormat:@"%ld",(long)self.viewModel.model.user.id]}];
        
    }else {
        [self.viewModel.addguanzhuCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id), @"followuserid":[NSString stringWithFormat:@"%ld",(long)self.viewModel.model.user.id],@"type":@"1"}];
        
    }
}
//初始化viewModel
- (NewPeopleDetilViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[NewPeopleDetilViewModel alloc] init];
    }
    return _viewModel;
}

- (IBAction)addAction:(UIButton *)sender {
    
    
    
    //是否登录
    if (![UserData UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
    
    if (sender.tag == 10) {
        
        [self isGuanzhuaction];
        
    }else if (sender.tag == 11) {
        //是否登录
        if (![UserData UserLoginState]) {
            //预约cell
            NewLoginViewController *vc = [[NewLoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
        
        [ShopCarList showInView:[UIApplication sharedApplication].keyWindow dic:nil block:^(NSDictionary *dic) {
            
            SurePayViewController *sure = [[SurePayViewController alloc] init];
            sure.hidesBottomBarWhenPushed = YES;
            sure.dic = [[NSMutableDictionary alloc] initWithDictionary:dic];
            [self pushToNextVCWithNextVC:sure];
        }];
        
    }else {
        
        if (self.viewModel.model) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":self.viewModel.model.user.cnName,@"header":[NSString stringWithFormat:@"%@",self.viewModel.model.user.bizCover],@"bizUserId":[NSString stringWithFormat:@"%ld",(long)self.viewModel.model.user.id]}];
            
            [AddShopCar showInView:self.view array:_fuwuxiangArray dic:dic string:self.userId block:^(NSDictionary *dic) {
                NSLog(@"%@",dic);
            }];
        }
        
    }
}


@end
