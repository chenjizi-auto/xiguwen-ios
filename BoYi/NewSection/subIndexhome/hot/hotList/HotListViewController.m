//
//  HotListViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HotListViewController.h"
#import "HotListviewModel.h"
#import "ShaiXuanHot.h"
#import "HotModel.h"
#import "NewShangjiaViewController.h"
#import "AnlieNewDetilViewController.h"
#import "ShangpinNewDetilViewController.h"
#import "BaojiaDetilViewController.h"
#import "BannerWebViewController.h"
#import "fenLeiModel.h"
#import "ShangchengsjNewDetilViewController.h"
#import "SearchNewViewController.h"
@interface HotListViewController (){
    NSInteger p;
    NSInteger _ceilingprice,//最高价
    //    _cityid,//当前城市
    _college,//是否学院认证1是 2不是
    _comprehensive,//综合排序 值1
    _countyid,//区域id查询
    _floorprice,//最低价
    _isshopvip,//否会员商家1是2否
    _typezhiye,//全部（职业id）
    _p,//默认第一页1
    _platform,//是否平台认证1是 2不是
    _rows,//默认10条
    _sincerity,//是否诚信认证1是 2不是
    _team,//商家类型，1个人，2团队
    _types;//1今日推荐2本周人气3本月人气4本周热门5本月热门
    
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HotListviewModel *viewModel;
@property(nonatomic,strong) ShaiXuanHot *shaixuanView;
@property(nonatomic,assign)NSInteger curPage;
@property (strong,nonatomic) ShareNewmodel *sharemodel;
@end

@implementation HotListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title;
    if (self.typeswu == 1) {
        title = @"今日推荐";
    }else if (self.typeswu == 2) {
        title = @"本周人气";
    }else if (self.typeswu == 3) {
        title = @"本月人气";
    }else if (self.typeswu == 4) {
        title = @"本周热门";
    }else {
        title = @"本月热门";
    }
    _types = self.typeswu;
    self.navigationItem.title = title;
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    [self setupTableViewxiala];
    [self setupBannerView];
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
- (void)shareData{
    NSDictionary *dic = @{@"type":@(self.typeswu)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxiangremen"]
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
- (void)setupBannerView {
    
    _ceilingprice = -1;//最高价
    _college = -1;//是否学院认证1是 2不是
    _comprehensive = -1;//综合排序 值1
    _countyid = -1;//区域id查询
    _floorprice = -1;//最低价
    _isshopvip = -1;//否会员商家1是2否
    _typezhiye = -1;//全部（职业id）
    _platform = -1,//是否平台认证1是 2不是
    _sincerity = -1,//是否诚信认证1是 2不是
    _team = -1;//商家类型，1个人，2团队
    
}
- (IBAction)action:(UIButton *)sender {
    [ShaiXuanHot showInView:[UIApplication sharedApplication].keyWindow block:^(NSDictionary *dic) {
        
        
        
        if ([dic[@"chengxin"] isEqualToString:@"yes"]) {
            _sincerity = 1;
        }else {
            _sincerity = -1;
        }
        if ([dic[@"ishuiyuan"] isEqualToString:@"yes"]) {
            _isshopvip = 1;
        }else {
            _isshopvip = -1;
        }
        if ([dic[@"isgeren"] isEqualToString:@"yes"]) {
            _team = 1;
        }else {
            _team = -1;
        }
        if ([dic[@"pingtai"] isEqualToString:@"yes"]) {
            _platform = 1;
        }else {
            _platform = -1;
        }
        if ([dic[@"xueyuan"] isEqualToString:@"yes"]) {
            _college = 1;
        }else {
            _college = -1;
        }
        if (![dic[@"zuigao"] isBlankString]) {
            _ceilingprice = [dic[@"zuigao"] integerValue];
        }else {
            _ceilingprice = -1;
        }
        if (![dic[@"zuidi"] isBlankString]) {
            _floorprice = [dic[@"zuidi"] integerValue];
        }else {
            _floorprice = -1;
        }
        [self.table.mj_header beginRefreshing];
    }];
}


- (void)setupTableViewxiala{
    [self.tablexiala registerNib:[UINib nibWithNibName:@"DopTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"DopTableViewCell"];
    self.tablexiala.delegate             = self;
    self.tablexiala.dataSource           = self;
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
            }
            
        }];
    }
}

#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Remensjhot *x) {
        @strongify(self);
        if (x.usertype == 1) {//商城
            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
            vc.id = x.userid;
            [self pushToNextVCWithNextVC:vc];
        }else {//婚庆
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = x.userid;
            [self pushToNextVCWithNextVC:vc];
        }
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
        modelwu.name = @"全部";
        [self.quyuArray insertObject:modelwu atIndex:0];
        
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"HotTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HotTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HotContentTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HotContentTableViewCell"];
    
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
        
        [dic setValue:@(_curPage) forKey:@"p"];
        if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
            
            [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
        }
        if (_ceilingprice != -1) {
            [dic setValue:@(_ceilingprice) forKey:@"ceilingprice"];
        }
 
        if (_college != -1) {
            [dic setValue:@(_college) forKey:@"college"];
        }
        if (_comprehensive == 1) {
            [dic setValue:@(_comprehensive) forKey:@"comprehensive"];
        }
        
        if (_countyid != -1) {
            [dic setValue:@(_countyid) forKey:@"countyid"];
        }
        if (_floorprice != -1) {
            [dic setValue:@(_floorprice) forKey:@"floorprice"];
        }
        if (_isshopvip != -1) {
            [dic setValue:@(_isshopvip) forKey:@"isshopvip"];
        }
        if (_typezhiye != -1) {
            [dic setValue:@(_typezhiye) forKey:@"type"];
        }
        [dic setValue:@(_types) forKey:@"types"];
        
        if (_platform != -1) {
            [dic setValue:@(_platform) forKey:@"platform"];
        }
        if (_sincerity != -1) {
            [dic setValue:@(_sincerity) forKey:@"sincerity"];
        }
        if (_team != -1) {
            [dic setValue:@(_team) forKey:@"team"];
        }
        
        [self.viewModel.refreshDataCommand execute:dic];
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        HotModel *model = [[HotModel alloc] init];
        
        model = [HotModel mj_objectWithKeyValues:x];
        self.viewModel.model = model;
    
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    _curPage ++;
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:@(_curPage) forKey:@"p"];
                    if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                        
                        [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
                    }
                    
                    if (_ceilingprice != -1) {
                        [dic setValue:@(_ceilingprice) forKey:@"ceilingprice"];
                    }
                    
                    if (_college != -1) {
                        [dic setValue:@(_college) forKey:@"college"];
                    }
                    if (_comprehensive == 1) {
                        [dic setValue:@(_comprehensive) forKey:@"comprehensive"];
                    }
                    
                    if (_countyid != -1) {
                        [dic setValue:@(_countyid) forKey:@"countyid"];
                    }
                    if (_floorprice != -1) {
                        [dic setValue:@(_floorprice) forKey:@"floorprice"];
                    }
                    if (_isshopvip != -1) {
                        [dic setValue:@(_isshopvip) forKey:@"isshopvip"];
                    }
                    if (_typezhiye != -1) {
                        [dic setValue:@(_typezhiye) forKey:@"type"];
                    }
                    [dic setValue:@(_types) forKey:@"types"];
                    
                    if (_platform != -1) {
                        [dic setValue:@(_platform) forKey:@"platform"];
                    }
                    if (_sincerity != -1) {
                        [dic setValue:@(_sincerity) forKey:@"sincerity"];
                    }
                    if (_team != -1) {
                        [dic setValue:@(_team) forKey:@"team"];
                    }
                    
                    [self.viewModel.refreshDataCommand execute:dic];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        NSMutableArray *array = x[@"remensj"];
        if (array.count < 10) {
            
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
- (HotListviewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HotListviewModel alloc] init];
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
        _typezhiye = self.quanbuArray[indexPath.row].occupationid;
    }if (self.type == 2){
        for (int i = 0; i < self.quyuArray.count; i ++) {
            self.quyuArray[i].isSelete = NO;
        }
        self.quyuArray[indexPath.row].isSelete = YES;
        self.quyu.text = self.quyuArray[indexPath.row].name;
        _countyid = self.quyuArray[indexPath.row].id;
    }
    self.tabheightview.hidden = YES;
    [self.table.mj_header beginRefreshing];
}

- (IBAction)cancle:(UIButton *)sender {
    self.tabheightview.hidden = YES;
}

- (IBAction)search:(IB_DESIGN_Button *)sender {
    SearchNewViewController *vc = [[SearchNewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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


@end
