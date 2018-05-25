//
//  AnlieListViewController.m
//  BoYi
//
//  Created by heng on 2017/12/18.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieListViewController.h"
#import "AnlieListViewModel.h"
#import "AnlieListModel.h"
#import "CHadangsubViewController.h"
#import "AnlieListCollectionViewCell.h"
#import "ShaiXuanHot.h"
#import "NewShangjiaViewController.h"
#import "DopTableViewCell.h"
#import "ShaiXuanAnlie.h"
#import "quyuModel.h"

@interface AnlieListViewController (){
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
    
    NSString *_keyword;//关键字
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) AnlieListViewModel *viewModel;
@property(nonatomic,strong) ShaiXuanHot *shaixuanView;
@property(nonatomic,assign)NSInteger curPage;
@property (strong,nonatomic)NSMutableArray *fuwuArray;//全部分类

@end

@implementation AnlieListViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (isIPhoneX) {
        self.height.constant = 84;
    }
    self.typeName.text = self.titlew;
    [self dopac];
    [self cellClick];
    [self setupTableView];
    [self setupCollectionView];
    if (self.typeSearch == 1) {
        self.viewModel.dataArray = [NSMutableArray arrayWithArray:self.dataSJ];
        [self.table reloadData];
        [self.collectionView reloadData];
    }else {
        [self.table.mj_header beginRefreshing];
    }
    self.guanjianziText.delegate = self;
    self.guanjianziText.returnKeyType = UIReturnKeySearch;//变为搜索按钮

    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,10,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.guanjianziText.leftView = leftView;
    self.guanjianziText.leftViewMode = UITextFieldViewModeAlways;
    self.guanjianziText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.baifenzhiHeight.constant = (ScreenHeight - 108) * 0.3;
    self.guanjianziText.inputAccessoryView = [self addToolbar];
    
}
- (void)setupCollectionView{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"AnlieListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AnlieListCollectionViewCell"];
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
    _keyword = @"";
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
        if ([dic[@"ishuiyuan"] isEqualToString:@"1"]) {
            _isshopvip = 1;
        }else if ([dic[@"ishuiyuan"] isEqualToString:@"2"]) {
            _isshopvip = 2;
        }else {
            _isshopvip = -1;
        }
        if ([dic[@"isgeren"] isEqualToString:@"1"]) {
            _team = 1;
        }else if ([dic[@"isgeren"] isEqualToString:@"2"]) {
            _team = 2;
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
- (IBAction)changeTypeAC:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.table.hidden = YES;
        self.collectionView.hidden = NO;
    }else {
        self.table.hidden = NO;
        self.collectionView.hidden = YES;
    }
}


- (IBAction)changeType:(UIButton *)sender {//商家
    if (sender.tag == 0) {
        [self.shangjiaBtn setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
        self.shangjiaView.hidden = NO;
        [self.tuanduiBtn setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
        self.tuanduiView.hidden = YES;
        _team = 1;
    }else {//团队
        [self.tuanduiBtn setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
        self.tuanduiView.hidden = NO;
        [self.shangjiaBtn setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
        self.shangjiaView.hidden = YES;
        _team = 2;
    }
    [self.table.mj_header beginRefreshing];
}
- (IBAction)backAC:(UIButton *)sender {
    [self popViewConDelay];
}
- (IBAction)lookAC:(UIButton *)sender {
    CHadangsubViewController *vc = [[CHadangsubViewController alloc] init];
    vc.titleColorSelected = MAINCOLOR;
    vc.menuViewStyle = WMMenuViewStyleLine;
    vc.automaticallyCalculatesItemWidths = YES;
    vc.progressWidth = 40;
    
    vc.progressViewIsNaughty = YES;
    vc.showOnNavigationBar = NO;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击事件

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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length != 0) {
        _keyword = textField.text;
        [self.table.mj_header beginRefreshing];
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
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
    
    [self.viewModel.fenleilistDataCommand execute:@{}];
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
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        _curPage = 1;
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if ([_keyword isEqualToString:@""]) {
            [dic setValue:@(_curPage) forKey:@"p"];
            
            if (_ceilingprice != -1) {
                [dic setValue:@(_ceilingprice) forKey:@"ceilingprice"];
            }
           
            if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                
                [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
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
        }else {
            [dic setValue:_keyword forKey:@"keyword"];
        }
        
        [self.viewModel.refreshDataCommand execute:dic];
        _keyword = @"";
        self.guanjianziText.text = @"";
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        self.dataArray = [NSMutableArray array];
        self.dataArray = self.viewModel.dataArray;
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    _curPage ++;
                    //传入参数 进行刷新
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    
                    [dic setValue:@(_curPage) forKey:@"p"];
                    
                    if (_ceilingprice != -1) {
                        [dic setValue:@(_ceilingprice) forKey:@"ceilingprice"];
                    }
                    if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                        
                        [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
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
        [self.collectionView reloadData];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (AnlieListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AnlieListViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    AnlieListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnlieListCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NewShangjiaViewController *newshangjia = [[NewShangjiaViewController alloc] init];
    newshangjia.shopid = self.dataArray[indexPath.row].userid;
    [self pushToNextVCWithNextVC:newshangjia];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 10)/2,275);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 5, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 5;
    
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
    [self.table.mj_header beginRefreshing];
    
}

- (IBAction)cnacle:(UIButton *)sender {
    self.zhegaiView.hidden = YES;
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
@end
