//
//  ShetuanViewController.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShetuanViewController.h"
#import "ShetuanViewModel.h"
#import "ShetuanModel.h"
#import "DopTableViewCell.h"
#import "ShetuanDetilViewController.h"
#import "ShaiXuanAnlie.h"

@interface ShetuanViewController (){
    NSInteger typelist,_moneymax,_moneymin,_comprehensive,_cityid;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShetuanViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *shaixuanTableView;
@property (weak, nonatomic) IBOutlet UIView *shaixianView;
@property (strong,nonatomic) NSMutableArray *dataArray;


@property(nonatomic,assign)NSInteger curPage;
@end

@implementation ShetuanViewController
- (void)viewWillAppear:(BOOL)animated{
    
    if ([[UserData UserDefaults:@"isRefreshing4"] isEqualToString:@"yes"]) {
        [self.table.mj_header beginRefreshing];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self dopview];
    [self setupTableView];
    self.dataArray = [[NSMutableArray alloc] init];
    [self.table.mj_header beginRefreshing];
    self.baifenzhiHeight.constant = (ScreenHeight - 108) * 0.3;
}
- (void)dopview{
    typelist = -1;
    _moneymax = -1;
    _moneymin = -1;
    _comprehensive = -1;
    _type = -1;
    _cityid = -1;
    //侧栏手势
    [self.shaixuanTableView registerNib:[UINib nibWithNibName:@"DopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DopTableViewCell"];
    self.shaixuanTableView.delegate = self;
    self.shaixuanTableView.dataSource = self;

    for (int i  = 0; i < 4; i++) {
        
        UIView *btnSubView = [self.view viewWithTag:100 + i];
        UIButton *btn = (UIButton *)[btnSubView viewWithTag:200];
        @weakify(self);
        //点击
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            for (int j  = 0; j < 4; j++) {
                if (i == j) {
                    
                    UIView *btnSubView = [self.view viewWithTag:100 + j];
                    UILabel *label = (UILabel *)[btnSubView viewWithTag:201];
                    UIImageView *image = (UIImageView *)[btnSubView viewWithTag:202];
                    label.textColor = RGBA(252, 88, 135, 1);
                    if (j == 3) {
                        image.image = [UIImage imageNamed:@"筛选"];
                    }else {
                        image.image = [UIImage imageNamed:@"下拉（未选中）"];
                    }
                    
                }else {
                    UIView *btnSubView = [self.view viewWithTag:100 + j];
                    UILabel *label = (UILabel *)[btnSubView viewWithTag:201];
                    UIImageView *image = (UIImageView *)[btnSubView viewWithTag:202];
                    label.textColor = RGBA(83, 83, 83, 1);
                    if (j == 3) {
                        image.image = [UIImage imageNamed:@"筛选"];
                    }else {
                        image.image = [UIImage imageNamed:@"下拉（选中）"];
                    }
                    
                }
            }
            self.type = (NSInteger)i;
            if (i == 0) {
                self.tabheightview.hidden = NO;
                [self.tablexiala reloadData];
            }else if (i == 1) {
                _comprehensive = 1;
                self.tabheightview.hidden = YES;
                [self.table.mj_header beginRefreshing];
            }else if (i == 2) {
                
                if (self.quyuArray.count > 1) {
                    self.tabheightview.hidden = NO;
                    [self.tablexiala reloadData];
                }
            }else {
                self.tabheightview.hidden = YES;
                if (i == 3) {
                    [ShaiXuanAnlie showInView:[UIApplication sharedApplication].keyWindow block:^(NSDictionary *dic) {
                        NSLog(@"%@",dic);
                        if (![dic[@"zuidiAL"] isBlankString]) {
                            _moneymin = [dic[@"zuidiAL"] integerValue];
                        }else {
                            _moneymin = -1;
                        }
                        if (![dic[@"zuigaoAL"] isBlankString]) {
                            _moneymax = [dic[@"zuigaoAL"] integerValue];
                        }else {
                            _moneymax = -1;
                        }
                        [self.table.mj_header beginRefreshing];
                        
                    }];
                }
            }
        }];
    }
}
#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Shetuan *x) {
        @strongify(self);
        
        ShetuanDetilViewController *vc = [[ShetuanDetilViewController alloc] init];

        vc.id = x.id;
        [self pushToNextVCWithNextVC:vc];

    }];
    [self.viewModel.fenleilistUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        //分类数据处理
        self.quanbuArray = [NSMutableArray array];
        self.quanbuArray = [Fenleiarray mj_objectArrayWithKeyValuesArray:x];
        
        Fenleiarray *modelwu = [[Fenleiarray alloc] init];
        modelwu.occupationid = -1;
        modelwu.proname = @"全部";
        modelwu.wapimg = @"全部";
        [self.quanbuArray insertObject:modelwu atIndex:0];
        
    }];
    [self.viewModel.getquyuUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.quyuArray = [NSMutableArray array];
        [self.quyuArray addObjectsFromArray:[Quyuquarray mj_objectArrayWithKeyValuesArray:x]];
        
        Quyuquarray *modelwu = [[Quyuquarray alloc] init];
        modelwu.id = -1;
        modelwu.name = @"全部区域";
        [self.quyuArray insertObject:modelwu atIndex:0];
        
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShetuanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShetuanTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    //类别和区域
    [self.viewModel.fenleilistDataCommand execute:@{}];
    
    if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
        
        [self.viewModel.getquyuDataCommand execute:@{@"city":[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]]}];
    }else {
        [self.viewModel.getquyuDataCommand execute:@{}];
    }

    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        _curPage = 1;
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
            
            [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
        }
        
        [dic setValue:@(_curPage) forKey:@"p"];
        if (_comprehensive != -1) {
            [dic setValue:@(_comprehensive) forKey:@"comprehensive"];
        }
        if (_moneymin != -1) {
            [dic setValue:@(_moneymin) forKey:@"moneymin"];
        }
        if (_moneymax == 1) {
            [dic setValue:@(_moneymax) forKey:@"moneymax"];
        }

        if (typelist != -1) {
            [dic setValue:@(typelist) forKey:@"type"];
        }
        
        [self.viewModel.refreshDataCommand execute:dic];
        [UserData UserDefaults:@"no" key:@"isRefreshing4"];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    _curPage ++;
                    //传入参数 进行刷新
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                        
                        [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
                    }
                    [dic setValue:@(_curPage) forKey:@"p"];
                    if (_comprehensive != -1) {
                        [dic setValue:@(_comprehensive) forKey:@"comprehensive"];
                    }
                    if (_moneymin != -1) {
                        [dic setValue:@(_moneymin) forKey:@"moneymin"];
                    }
                    if (_moneymax == 1) {
                        [dic setValue:@(_moneymax) forKey:@"moneymax"];
                    }
                    
                    if (typelist != -1) {
                        [dic setValue:@(typelist) forKey:@"type"];
                    }
                    [self.viewModel.refreshDataCommand execute:dic];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
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
- (ShetuanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShetuanViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == 0) {
        return self.quanbuArray.count;
    }else if (self.type == 2){
        return self.quyuArray.count;
    }else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        for (int i = 0; i < self.quanbuArray.count; i ++) {
            self.quanbuArray[i].isSelete = NO;
        }
        self.quanbuArray[indexPath.row].isSelete = YES;
        self.all.text = self.quanbuArray[indexPath.row].proname;
        typelist = self.quanbuArray[indexPath.row].occupationid;
    }if (self.type == 2){
        for (int i = 0; i < self.quyuArray.count; i ++) {
            self.quyuArray[i].isSelete = NO;
        }
        self.quyuArray[indexPath.row].isSelete = YES;
        self.quyu.text = self.quyuArray[indexPath.row].name;
        _cityid = self.quyuArray[indexPath.row].id;
    }
    self.tabheightview.hidden = YES;
    [self.table.mj_header beginRefreshing];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DopTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DopTableViewCell" owner:nil options:nil].firstObject;
    }
    if (self.type == 0) {
        cell.name.text = self.quanbuArray[indexPath.row].proname;
        if (self.quanbuArray[indexPath.row].isSelete) {
            cell.gouxuanImage.hidden = NO;
        }else {
            cell.gouxuanImage.hidden = YES;
        }
    }if (self.type == 2){
        cell.name.text = self.quyuArray[indexPath.row].name;
        if (self.quyuArray[indexPath.row].isSelete) {
            cell.gouxuanImage.hidden = NO;
        }else {
            cell.gouxuanImage.hidden = YES;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
- (IBAction)cnacle:(UIButton *)sender {
    self.shaixianView.hidden = YES;
}

@end
