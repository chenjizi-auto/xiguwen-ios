//
//  SearchsjViewController.m
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SearchsjViewController.h"
#import "SearchshangjiaListViewModel.h"
#import "AnlieListModel.h"
#import "CHadangsubViewController.h"
#import "AnlieListCollectionViewCell.h"
#import "ShaiXuanHot.h"
#import "NewShangjiaViewController.h"
#import "DopTableViewCell.h"
#import "ShaiXuanAnlie.h"
#import "quyuModel.h"
@interface SearchsjViewController (){
    NSInteger _ceilingprice,//最高价
    _cityid,//当前城市
    _college,//是否学院认证1是 2不是
    _comprehensive,//综合排序 值1
    _countyid,//区域id查询
    _floorprice,//最低价
    _isshopvip,//否会员商家1是2否
    _occupationid,//全部（职业id）
    _p,//默认第一页1
    _platform,//是否平台认证1是 2不是
    _rows,//默认10条
    _sincerity,//是否诚信认证1是 2不是
    _team;//商家类型，1个人，2团队
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong,nonatomic) SearchshangjiaListViewModel *viewModel;
@property(nonatomic,strong) ShaiXuanHot *shaixuanView;
@property(nonatomic,assign)NSInteger curPage;
@property (strong,nonatomic)NSMutableArray *fuwuArray;//全部分类
@end

@implementation SearchsjViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dopac];
    [self cellClick];
    [self setupTableView];
    [self geTdata];
    
}
- (void)geTdata{
    
    //传入参数 进行刷新
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:@(100) forKey:@"rows"];
    
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
    
    if (_occupationid != -1) {
        [dic setValue:@(_occupationid) forKey:@"occupationid"];
    }
    if (_platform != -1) {
        [dic setValue:@(_platform) forKey:@"platform"];
    }
    if (_sincerity != -1) {
        [dic setValue:@(_sincerity) forKey:@"sincerity"];
    }
    if (_team != -1) {
        [dic setValue:@(_team) forKey:@"team"];
    }
    [dic setValue:self.content forKey:@"cont"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@"sj" forKey:@"stype"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    
    if ([self.scope isEqualToString:@"同城"]) {
        [dic setValue:self.currentCityName forKey:@"city"];
        [dic setValue:@(1) forKey:@"types"];
    }
    
    [[RequestManager sharedManager] requestUrl:URL_New_searchwu
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.dataSJ = [NSArray array];
                                               self.dataSJ = [Shangjiatuanduilist mj_objectArrayWithKeyValuesArray:response[@"data"][@"shangjia"]];
                                               self.viewModel.dataArray = [NSMutableArray arrayWithArray:self.dataSJ];
                                               [self.table reloadData];
//                                               if ([type isEqualToString:@"al"]) {
//                                                   self.dataAL = [NSArray array];
//                                                   self.dataAL = [Anlielistsearcharray mj_objectArrayWithKeyValuesArray:response[@"data"][@"anli"]];
//                                               }
//                                               if ([type isEqualToString:@"fw"]) {
//                                                   self.dataBJ = [NSArray array];
//                                                   self.dataBJ = [Baojiashangjiafen mj_objectArrayWithKeyValuesArray:response[@"data"][@"baojia"]];
//                                                   
//                                                   
//                                               }
//                                               if ([type isEqualToString:@"sp"]) {
//                                                   self.dataSP = [NSArray array];
//                                               }
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
    
}


- (void)dopac{
    
    _ceilingprice = -1;//最高价
    _cityid = -1;//当前城市
    _college = -1;//是否学院认证1是 2不是
    _comprehensive = -1;//综合排序 值1
    _countyid = -1;//区域id查询
    _floorprice = -1;//最低价
    _isshopvip = -1;//否会员商家1是2否
    _occupationid = -1;//全部（职业id）
    _platform = -1,//是否平台认证1是 2不是
    _sincerity = -1,//是否诚信认证1是 2不是
    _team = -1;//商家类型，1个人，2团队
    if (self.typeFenleiguolai) {
        _occupationid  = self.typeFenleiguolai;
    }
    
    
    
    UIView *faubView = [self.view viewWithTag:1000];
    for (int i  = 0; i < 3; i++) {
        
        UIView *btnSubView = [faubView viewWithTag:100 + i];
        UIButton *btn = (UIButton *)[btnSubView viewWithTag:200];
        @weakify(self);
        //点击
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self getBtnTag:i];
            for (int j  = 0; j < 3; j++) {
                if (i == j) {
                    
                    UIView *faubViewother = [self.view viewWithTag:1000];
                    UIView *btnSubViewother = [faubViewother viewWithTag:100 + j];
                    UILabel *label = (UILabel *)[btnSubViewother viewWithTag:201];
                    UIImageView *image = (UIImageView *)[btnSubViewother viewWithTag:202];
                    label.textColor = RGBA(252, 88, 135, 1);
                    if (j == 3) {
                        image.image = [UIImage imageNamed:@"筛选"];
                    }else {
                        image.image = [UIImage imageNamed:@"下拉（未选中）"];
                    }
                    
                }else {
                    UIView *faubViewother = [self.view viewWithTag:1000];
                    UIView *btnSubViewother = [faubViewother viewWithTag:100 + j];
                    UILabel *label = (UILabel *)[btnSubViewother viewWithTag:201];
                    UIImageView *image = (UIImageView *)[btnSubViewother viewWithTag:202];
                    label.textColor = RGBA(83, 83, 83, 1);
                    if (j == 3) {
                        image.image = [UIImage imageNamed:@"筛选"];
                    }else {
                        image.image = [UIImage imageNamed:@"下拉（选中）"];
                    }
                    
                }
            }
        }];
    }
    
}
- (void)getBtnTag:(NSInteger)integer{
    if (integer == 0) {
        self.typeQuan = 1;
        self.zhegaiView.hidden = NO;
        int i = 0;
        if (isIPhoneX) {
            i = 168;
        }else {
            i = 148;
        }
        if (self.quanbuArray.count * 40 + 1 > ScreenHeight - i) {
            self.tablesaixuanHeight.constant = ScreenHeight - i;
        }else {
            self.tablesaixuanHeight.constant = self.quanbuArray.count * 40 + 1;
        }
        
        [self.leibieAndHuanjinTable reloadData];
    }else if (integer == 1){
        self.typeQuan = 3;
        self.zhegaiView.hidden = YES;
        _comprehensive = 1;
        [self.table.mj_header beginRefreshing];
    }else {
        if (self.quyuArray.count > 1) {
            self.typeQuan = 2;
            self.zhegaiView.hidden = NO;
            self.tablesaixuanHeight.constant = self.quyuArray.count * 40 + 1;
            [self.leibieAndHuanjinTable reloadData];
        }
    }
}

- (IBAction)shaixuanAC:(UIButton *)sender {
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
        [self geTdata];
    }];
}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Shangjiatuanduilist *x) {
        @strongify(self);
        
        NewShangjiaViewController *newshangjia = [[NewShangjiaViewController alloc] init];
        newshangjia.shopid = x.userid;
        [self pushToNextVCWithNextVC:newshangjia];
    }];
    [self.viewModel.getquyuUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.quyuArray = [NSMutableArray array];
        [self.quyuArray addObjectsFromArray:[Quyuquarray mj_objectArrayWithKeyValuesArray:x]];
        
        Quyuquarray *model = [[Quyuquarray alloc] init];
        model.id = -1;
        model.name = @"全部";
        [self.quyuArray insertObject:model atIndex:0];
    }];
    
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    [self.viewModel.fenleilistDataCommand execute:@{}];
    [self.table registerNib:[UINib nibWithNibName:@"AnlieListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnlieListTableViewCell"];
    //    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    self.leibieAndHuanjinTable.delegate             = self;
    self.leibieAndHuanjinTable.dataSource           = self;
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
        [self.viewModel.getquyuDataCommand execute:@{@"city":[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]]}];
    }else {
        [self.viewModel.getquyuDataCommand execute:@{}];
    }
    
    [self.viewModel.fenleilistUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        //分类数据处理
        self.fuwuArray = [NSMutableArray array];
        self.fuwuArray = [Fenleiarray mj_objectArrayWithKeyValuesArray:x];
        Fenleiarray *modelwu = [[Fenleiarray alloc] init];
        modelwu.occupationid = -1;
        modelwu.proname = @"全部";
        modelwu.wapimg = @"全部";
        
        [self.fuwuArray insertObject:modelwu atIndex:0];
        self.quanbuArray = self.fuwuArray;
    }];
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        self.dataArray = [NSMutableArray array];
        self.dataArray = self.viewModel.dataArray;

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

#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.typeQuan == 1) {
        return self.quanbuArray.count;
    }else if (self.typeQuan == 2){
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


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (self.typeQuan == 1) {
        for (int i = 0; i < self.quanbuArray.count; i ++) {
            self.quanbuArray[i].isSelete = NO;
        }
        self.quanbuArray[indexPath.row].isSelete = YES;
        self.typeName.text = self.quanbuArray[indexPath.row].proname;
        _occupationid = self.quanbuArray[indexPath.row].occupationid;
    }if (self.typeQuan == 2){
        for (int i = 0; i < self.quyuArray.count; i ++) {
            self.quyuArray[i].isSelete = NO;
        }
        self.quyuArray[indexPath.row].isSelete = YES;
        self.quyuName.text = self.quyuArray[indexPath.row].name;
        _countyid = self.quyuArray[indexPath.row].id;
    }
    self.zhegaiView.hidden = YES;
    [self geTdata];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DopTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DopTableViewCell" owner:nil options:nil].firstObject;
    }
    if (self.typeQuan == 1) {
        cell.name.text = self.quanbuArray[indexPath.row].proname;
        if (self.quanbuArray[indexPath.row].isSelete) {
            cell.gouxuanImage.hidden = NO;
        }else {
            cell.gouxuanImage.hidden = YES;
        }
    }if (self.typeQuan == 2){
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

//初始化viewModel
- (SearchshangjiaListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SearchshangjiaListViewModel alloc] init];
    }
    return _viewModel;
}

@end
