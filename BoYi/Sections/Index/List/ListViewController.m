//
//  ListViewController.m
//  BoYi
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewModel.h"
#import "SaiXuanView.h"
#import "NewPeopleDetilViewController.h"

#define BlockCOLOR RGBA(0, 0, 0, 1)
@interface ListViewController (){
    NSString *_role_type_id, *_order, *_wedding, *_price_type, *_area,*_channelId,*_cn_name;
    
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ListViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *wordsOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UILabel *wordsTwo;
@property (weak, nonatomic) IBOutlet UIImageView *iamgeTwo;
@property (weak, nonatomic) IBOutlet UILabel *wordsThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;
@property (weak, nonatomic) IBOutlet UILabel *wordsFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageFour;

@property (strong, nonatomic)NSMutableArray *array;

@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)NSInteger totalPage;
@end

@implementation ListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    self.navigationItem.title = self.titleName;
    
    [self type];
    
    [self addRightBtnWithTitle:@"完成" image:@""];
    
    [self addPopBackBtn];
    
    [self setupTableView];
    
    
}

- (void)type{
    _role_type_id = @"";
    _order = @"";
    _wedding = @"";
    _price_type = @"";
    NSString *city = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
    _area = city;
    _channelId = @"";
    _cn_name = @"";
    if ([self.titleName isEqualToString:@"策划师"]) {
        self.isRows = NO;
        _role_type_id = @"11";
        self.viewModel.isWorkLook = NO;
    }else if ([self.titleName isEqualToString:@"摄影师"]){
        self.isRows = NO;
        _role_type_id = @"12";
        self.viewModel.isWorkLook = NO;
    }else if ([self.titleName isEqualToString:@"摄像师"]){
        self.isRows = NO;
        _role_type_id = @"13";
        self.viewModel.isWorkLook = NO;
    }else if ([self.titleName isEqualToString:@"主持人"]){
        self.isRows = NO;
        _role_type_id = @"14";
        self.viewModel.isWorkLook = NO;
    }else if ([self.titleName isEqualToString:@"化妆师"]){
        self.isRows = NO;
        _role_type_id = @"15";
        self.viewModel.isWorkLook = NO;
    }else if ([self.titleName isEqualToString:@"婚纱摄影"]){//
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"23";
    }else if ([self.titleName isEqualToString:@"酒店预订"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"35";
    }else if ([self.titleName isEqualToString:@"特色演艺"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"17,18,19,20,21,22";
    }else if ([self.titleName isEqualToString:@"婚车租赁"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"37";
    }else if ([self.titleName isEqualToString:@"婚礼管家"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"7";
    }else if ([self.titleName isEqualToString:@"珠宝首饰"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"36";
    }else if ([self.titleName isEqualToString:@"婚纱礼服"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"26";
    }else if ([self.titleName isEqualToString:@"婚礼用品"]){
        self.isRows = YES;
        _channelId = @"33";
        self.viewModel.isWorkLook = YES;
    }else if ([self.titleName isEqualToString:@"婚庆布置"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"1";
    }else if ([self.titleName isEqualToString:@"MV微电影"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"28,30";
    }else if ([self.titleName isEqualToString:@"舞台音响"]){
        self.isRows = YES;
        self.viewModel.isWorkLook = YES;
        _channelId = @"3,4";
    }
    else {
        _cn_name = self.titleName;
        self.viewModel.isWorkLook = YES;
    }
}

#pragma mark - 点击事件
- (IBAction)seleAction:(UIButton *)sender {
    if (sender.tag == 1000) {
        if (sender.selected) {

            _imageOne.image = [UIImage imageNamed:@"图层 1"];
            _iamgeTwo.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _imageThree.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _order = @"biz_price_desc";
            
        }else {
            _imageOne.image = [UIImage imageNamed:@"图层 0-1"];
            _iamgeTwo.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _imageThree.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _order = @"biz_price";
        }
        [self.table.mj_header beginRefreshing];
        
    }else if (sender.tag == 1001) {
        if (sender.selected) {
            _imageOne.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _iamgeTwo.image = [UIImage imageNamed:@"图层 1"];
            _imageThree.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
           
            _order = @"biz_view_count_desc";
        }else {
            _imageOne.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _iamgeTwo.image = [UIImage imageNamed:@"图层 0-1"];
            _imageThree.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            
            _order = @"biz_view_count";
        }
        [self.table.mj_header beginRefreshing];
    }else if (sender.tag == 1002) {
        if (sender.selected) {
            _imageOne.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _iamgeTwo.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _imageThree.image = [UIImage imageNamed:@"图层 1"];
            _order = @"biz_star_desc";
           
        }else {
            _imageOne.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _iamgeTwo.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
            _imageThree.image = [UIImage imageNamed:@"图层 0-1"];
            _order = @"biz_star";
            
        }
        [self.table.mj_header beginRefreshing];
    }else {
        _imageOne.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
        _iamgeTwo.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
        _imageThree.image = [UIImage imageNamed:@"形状-2-拷贝-list"];
        [self btnChangeFour];
        
        
    }
    sender.selected = !sender.selected;
}

- (void)btnChangeFour{
     __weak typeof(self) weakSelf = self;
    _wedding = @"";
    _price_type = @"";
    
    for (int i = 0; i < self.array.count; i ++) {
        weakSelf.array[i][@"isSele"] = @"0";
    }
 
    [SaiXuanView showInView:[UIApplication sharedApplication].keyWindow  array:weakSelf.array block:^(NSDictionary *dic) {
     
        NSLog(@"%@",dic);
        if (![dic[@"address"] isEqualToString:@""]) {
            _area = dic[@"address"];
        }
        if (![dic[@"time"] isEqualToString:@""]) {
            _wedding = dic[@"time"];
        }
        if (![dic[@"price"] isEqualToString:@""]) {
            _price_type = dic[@"price"];
        }
        
    }];
    
}
//完成
- (void)respondsToRightBtn {
    
    [self.table.mj_header beginRefreshing];
    
}


#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ListTableViewCell"];

    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.rowHeight = 140;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    @weakify(self);
    
    
    NSString *city = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
    
    [self.viewModel.refreshDataCommandQY execute:@{@"city":city}];
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        _currentPage = 1;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
         
        if (self.isRows) {
            [dic setValue:@"10" forKey:@"pageNum"];
            [dic setValue:_area forKey:@"area"];
            [dic setValue:_role_type_id forKey:@"role_type_id"];
            [dic setValue:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"curPage"];
            
            
            if (![_price_type isEqualToString:@""]) {
                [dic setValue:_price_type forKey:@"price_type"];
            }
            if (![_wedding isEqualToString:@""]) {
                [dic setValue:_wedding forKey:@"wedding"];
            }
            if (![_order isEqualToString:@""]) {
                [dic setValue:_order forKey:@"order"];
            }
            if (![_channelId isEqualToString:@""]) {
                [dic setValue:_channelId forKey:@"channelId"];
            }
            if (![_cn_name isEqualToString:@""]) {
                [dic setValue:_cn_name forKey:@"cn_name"];
            }
            
        }else {
            [dic setValue:@"10" forKey:@"pageNum"];
            [dic setValue:_area forKey:@"area"];
            [dic setValue:_role_type_id forKey:@"role_type_id"];
            [dic setValue:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"page"];
            
            
            if (![_price_type isEqualToString:@""]) {
                [dic setValue:_price_type forKey:@"price_type"];
            }
            if (![_wedding isEqualToString:@""]) {
                [dic setValue:_wedding forKey:@"wedding"];
            }
            if (![_order isEqualToString:@""]) {
                [dic setValue:_order forKey:@"order"];
            }
            if (![_cn_name isEqualToString:@""]) {
                [dic setValue:_cn_name forKey:@"cn_name"];
            }
        }

        
        
        
        [self.viewModel.refreshDataCommand execute:dic];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        self.viewModel.isRows = self.isRows;
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    _currentPage ++;
                    //传入参数 进行刷新
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    
                    if (self.isRows) {
                        [dic setValue:@"10" forKey:@"pageNum"];
                        [dic setValue:_area forKey:@"area"];
                        [dic setValue:_role_type_id forKey:@"role_type_id"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"curPage"];
                        
                        
                        if (![_price_type isEqualToString:@""]) {
                            [dic setValue:_price_type forKey:@"price_type"];
                        }
                        if (![_wedding isEqualToString:@""]) {
                            [dic setValue:_wedding forKey:@"wedding"];
                        }
                        if (![_order isEqualToString:@""]) {
                            [dic setValue:_order forKey:@"order"];
                        }
                        if (![_channelId isEqualToString:@""]) {
                            [dic setValue:_channelId forKey:@"channelId"];
                        }
                        if (![_cn_name isEqualToString:@""]) {
                            [dic setValue:_cn_name forKey:@"cn_name"];
                        }
                        
                    }else {
                        [dic setValue:@"10" forKey:@"pageNum"];
                        [dic setValue:_area forKey:@"area"];
                        [dic setValue:_role_type_id forKey:@"role_type_id"];
                        [dic setValue:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"page"];
                        
                        
                        if (![_price_type isEqualToString:@""]) {
                            [dic setValue:_price_type forKey:@"price_type"];
                        }
                        if (![_wedding isEqualToString:@""]) {
                            [dic setValue:_wedding forKey:@"wedding"];
                        }
                        if (![_order isEqualToString:@""]) {
                            [dic setValue:_order forKey:@"order"];
                        }
                        if (![_cn_name isEqualToString:@""]) {
                            [dic setValue:_cn_name forKey:@"cn_name"];
                        }
                    }

                    [self.viewModel.refreshDataCommand execute:dic];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        NSMutableArray *array = [NSMutableArray alloc];
        if (self.isRows) {
         
            array = x[@"r"][@"rows"];
        }else {
            array = x[@"r"][@"UserList"];
        }
        
        
        if (array.count < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //点击cell
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        NewPeopleDetilViewController *people = [[NewPeopleDetilViewController alloc] init];
        Userlist *model = x;
        people.userId = NSStringFormatter(model.id);
        
        people.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:people];
        
        
    }];
    //点击cell
    [self.viewModel.refreshCityQYSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        [self.array removeAllObjects];
        NSMutableArray *array = x[@"r"];
        for (NSDictionary *dic in array) {
            
            NSMutableDictionary *dicInt = [NSMutableDictionary dictionaryWithDictionary:@{@"area":dic[@"area"],@"isSele":@"0"}];
            [self.array addObject:dicInt];
            
        }
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
    [self.viewModel.refreshDataCommandQY.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.isRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
    }];
    
    [self.table.mj_header beginRefreshing];
}

//初始化viewModel
- (ListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ListViewModel alloc] init];
    }
    return _viewModel;
}
//- (void)viewDidDisappear:(BOOL)animated{
//    self.viewModel = nil;
//}
- (void)dealloc{
    NSLog(@"!@#");
}

@end
