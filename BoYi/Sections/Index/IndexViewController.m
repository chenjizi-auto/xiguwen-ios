//
//  IndexViewController.m
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexViewModel.h"
#import "commonTool.h"
#import "TypeBtnView.h"
#import "SDCycleScrollView.h"
#import "BannerWebViewController.h"
#import "NewPeopleDetilViewController.h"
#import "CityViewController.h"
#import "ScheduleViewController.h"
#import "ShopCarList.h"
#import "GGListViewController.h"
#import "ListViewController.h"
#import "SurePayViewController.h"
#import "LaunchPageView.h"
@interface IndexViewController ()<SDCycleScrollViewDelegate,UITextFieldDelegate>{
    NSString *_cityStr;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IndexViewModel *viewModel;
@property (strong, nonatomic) SDCycleScrollView *adView;
@property (strong, nonatomic) NSMutableArray *photos;

@property (assign, nonatomic) int mark;

@end

@implementation IndexViewController

- (void)viewWillAppear:(BOOL)animated {
    self.searchText.delegate = self;
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    self.city.text = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
    

    
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.isxheght.constant = 52;
        self.viewheight.constant = 84;
    }
    [self markbtn];
    
    self.mark = 0;
    
    [self setupTableView];
    
    [self setupBannerView];
    
    [self actionBlack];
    self.searchText.delegate = self;
    self.searchText.returnKeyType = UIReturnKeySearch;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length > 0) {
        
        [textField resignFirstResponder];
        
        ListViewController *list = [ListViewController new];
        list.hidesBottomBarWhenPushed = YES;
        
        list.titleName = textField.text;
        
        [self pushToNextVCWithNextVC:list];
    }
    
    return YES;
}

- (void)markbtn{
    [UserData UserDefaults:@"1" key:@"index_one"];
    [UserData UserDefaults:@"1" key:@"index_two"];
    [UserData UserDefaults:@"1" key:@"index_three"];
    [UserData UserDefaults:@"1" key:@"index_four"];
    [UserData UserDefaults:@"1" key:@"index_five"];
}


- (void)actionBlack{
    @weakify(self);
    
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        Children *model;
        model = x;
       
        if (![NSStringFormatter(model.entityId) isBlankString]) {//详情1
            
            NewPeopleDetilViewController *people = [[NewPeopleDetilViewController alloc] init];
            people.userId = model.entityId;
            people.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:people];

        }else{
            //富
            BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
            bannerweb.hidesBottomBarWhenPushed = YES;
            bannerweb.urlString = NSStringFormatter(model.descn);
            bannerweb.name= NSStringFormatter(model.name);
            [self pushToNextVCWithNextVC:bannerweb];
        }
        
    }];
    
    //zhong
    [self.viewModel.gotoZhongSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        NSIndexPath *path = x;
        if (path.row == 1) {
            
        }else if (path.row == 2) {
            
        }else if (path.row == 3) {
            
        }else{
            
        }
        [self.table reloadData];
    }];
    //han
    [self.viewModel.gotoHanSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        NSIndexPath *path = x;
        
        [self.table reloadData];
    }];
    //hua
    [self.viewModel.gotoHuaSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        NSIndexPath *path = x;
        
        [self.table reloadData];
    }];
    //more
    [self.viewModel.gotoMoreSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        NSIndexPath *path = x;
        NSString *title = @"";
        if (path.row == 0) {
            title = @"策划师";
        }else if (path.row == 1) {
            title = @"主持人";
        }else if (path.row == 2) {
            title = @"摄影师";
        }else if (path.row == 3) {
            title = @"摄像师";
        }else{
            title = @"化妆师";
        }
        
        ListViewController *list = [ListViewController new];
        list.hidesBottomBarWhenPushed = YES;
        
        list.titleName = title;
        
        [self pushToNextVCWithNextVC:list];
    }];
    
}

#pragma mark - view
- (void)setupBannerView {
    @weakify(self);
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 440)];
    header.backgroundColor = [UIColor whiteColor];
    self.adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 170) delegate:self placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.adView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.adView.currentPageDotColor = MAINCOLOR; // 自定义分页控件小圆标颜色
    self.adView.pageDotColor = [UIColor whiteColor];
    self.adView.autoScrollTimeInterval = 5.0;
    self.adView.showPageControl = YES;
    

    TypeBtnView *type = [[NSBundle mainBundle]loadNibNamed:@"TypeBtnView" owner:nil options:nil].firstObject;
    type.frame = CGRectMake(0, 190, ScreenWidth, 250);
    [type.gotoNextVc subscribeNext:^(id  _Nullable x) {
    
        @strongify(self);
        
        NSString *title = @"";

        switch ([x integerValue]) {
            case 0:
                title = @"策划师";
                break;
            case 1:
                title = @"主持人";
                break;
            case 2:
                title = @"摄像师";
                break;
            case 3:
                title = @"摄影师";
                break;
            case 4:
                title = @"化妆师";
                break;
            case 5:

                title = @"婚纱摄影";
                break;
            case 6:
                title = @"酒店预订";
                break;
            case 7:
                title = @"珠宝首饰";
                break;
            case 8:
                title = @"婚车租赁";

                break;
            case 9:
                title = @"婚礼管家";

                break;
            case 10:
                title = @"婚庆布置";

                break;
            case 11:
                title = @"婚纱礼服";

                break;
            case 12:
                title = @"灯光舞台";

                break;
            case 13:
                title = @"特色演艺";

                break;
            case 14:
                title = @"MV微电影";

                break;
            case 15:
                title = @"婚礼用品";
                
                break;
            default:
                break;
        }
        
        ListViewController *list = [ListViewController new];
        list.hidesBottomBarWhenPushed = YES;
        
        list.titleName = title;
        
        [self pushToNextVCWithNextVC:list];
    }];
    [header addSubview:self.adView];
    [header addSubview:type];
    self.table.tableHeaderView = header;
   
}

#pragma mark - 点击事件
//banner 点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self.view endEditing:YES];
    if (self.photos.count > 0) {
        
        IndexModel *model = self.photos[index];
        if (![NSStringFormatter(model.ad.entityId) isBlankString]) {//详情1

            NewPeopleDetilViewController *people = [[NewPeopleDetilViewController alloc] init];
            people.userId = model.ad.entityId;
            people.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:people];
            
            return;
        }
        
        if (model.children.count > 0) {
            GGListViewController *list = [[GGListViewController alloc] init];
            list.hidesBottomBarWhenPushed = YES;
            list.parentId = [NSString stringWithFormat:@"%ld",model.ad.id];
            list.titleName = model.ad.name;
            [self pushToNextVCWithNextVC:list];
            return;
        }
        if ([NSStringFormatter(model.ad.url) isEqualToString:@"#"]) {//内部
            NSLog(@"%@",model.ad.url);
            
            BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
            bannerweb.hidesBottomBarWhenPushed = YES;
            bannerweb.urlString = NSStringFormatter(model.ad.descn);
            bannerweb.name= NSStringFormatter(model.ad.name);
            [self pushToNextVCWithNextVC:bannerweb];
        }

    }
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    [self.table registerNib:[UINib nibWithNibName:@"IndexTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"IndexTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        
        self.city.text = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:nil];
    
        
        [self.viewModel.refreshDataCommandCH execute:@{@"city":self.city.text}];
        
        [self.viewModel.refreshDataCommandZC execute:@{@"city":self.city.text}];
        
        [self.viewModel.refreshDataCommandSY execute:@{@"city":self.city.text}];
        
        [self.viewModel.refreshDataCommandSX execute:@{@"city":self.city.text}];
        
        [self.viewModel.refreshDataCommandHZ execute:@{@"city":self.city.text}];
        
        
        [UserData UserDefaults:@"no" key:@"isRefreshing"];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        self.photos = [NSMutableArray arrayWithArray:[IndexModel mj_objectArrayWithKeyValuesArray:x[@"r"]]];
        [self configDataForHeaderCode:self.photos];
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            [self.table.mj_header endRefreshing];
        }
        
    }];
    [self.table.mj_header beginRefreshing];
    
    //ch
    [self.viewModel.refreshUISubjectCH subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        [self.viewModel ConvertingToObjectCH:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.table reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    //zc
    [self.viewModel.refreshUISubjectZC subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        [self.viewModel ConvertingToObjectZC:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.table reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    //sy
    [self.viewModel.refreshUISubjectSY subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        [self.viewModel ConvertingToObjectSY:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.table reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    //sx
    [self.viewModel.refreshUISubjectSX subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        [self.viewModel ConvertingToObjectSX:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.table reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    //hz
    [self.viewModel.refreshUISubjectHZ subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        [self.viewModel ConvertingToObjectHZ:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        [self.table reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
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
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommandCH.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommandZC.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommandSY.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommandSX.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommandHZ.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];

}
- (void)configDataForHeaderCode:(NSMutableArray *)array{
    NSMutableArray *ay = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        
        IndexModel *model = array[i];
        [ay addObject: String(ImageHomeURL,model.ad.imgUrl)];
        
    }
    self.adView.imageURLStringsGroup = ay;
}
//初始化viewModel
- (IndexViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[IndexViewModel alloc] init];
    }
    return _viewModel;
}

//定位和shop
- (IBAction)cityAndShopcar:(UIButton *)sender {
    
    if (sender.tag == 10) {
        
        CityViewController *map = [[CityViewController alloc] init];
        map.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:map];
        
    }else {
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
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}
@end
