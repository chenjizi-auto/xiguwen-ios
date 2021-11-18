//
//  FindViewController.m
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FindViewController.h"
#import "FindViewModel.h"
#import <DOPDropDownMenu.h>
#import "CityViewController.h"
#import "typeModel.h"
#import "FindDetailViewController.h"
#import "ShopCarList.h"
#import "SurePayViewController.h"

@interface FindViewController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource>{
    NSString *_userInfoBvoCity, *_caseType, *_caseEnvironment, *_caseDetail;
}

@property(nonatomic,assign)NSInteger curPage;
@property(nonatomic,assign)NSInteger pageSize;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) FindViewModel *viewModel;
@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (nonatomic, weak) DOPDropDownMenu *menuB;

@property (nonatomic, strong) NSArray *jiageArray;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *huanjinArray;
@property (nonatomic, strong) NSIndexPath *indexRow;

@end

@implementation FindViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    self.city.text = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
    _userInfoBvoCity = self.city.text;
    if (self.table) {
        [self.table.mj_header beginRefreshing];
    }

}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        [self.viewModel.searchDataCommand execute:@{@"exampleName":textField.text}];
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.isXheirht.constant = 52;
    }
    [self setupTableView];
    
    [self cellClick];
    
    [self dop];
    
    [self type];
    self.searchText.returnKeyType = UIReturnKeySearch;
    self.searchText.delegate = self;
    
    [self.viewModel.refreshUISubjectAL subscribeNext:^(id  _Nullable x) {
        
        NSMutableArray *array = [NSMutableArray array];
        self.typeArray = [NSMutableArray array];
        array = [Esarray mj_objectArrayWithKeyValuesArray:x[@"r"]];
        
        for (int i = 0; i < array.count; i ++) {
            Esarray *model = array[i];
            [self.typeArray addObject:model.name];
        }
        [self.typeArray insertObject:@"类型" atIndex:0];
        self.classifys = self.typeArray;
        [_menu reloadData];
    }];
    [self.viewModel.refreshUISubjectALTYPE subscribeNext:^(id  _Nullable x) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        self.huanjinArray = [NSMutableArray array];
        
        array = [Esarray mj_objectArrayWithKeyValuesArray:x[@"r"]];
        
        for (int i = 0; i < array.count; i ++) {
            Esarray *model = array[i];
            [self.huanjinArray addObject:model.name];
        }
        [self.huanjinArray insertObject:@"环境" atIndex:0];
        
        self.sorts = self.huanjinArray;
        [_menu reloadData];
        
    }];
    
    [self.viewModel.searchUISubject subscribeNext:^(id  _Nullable x) {
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:YES];
        [self.table reloadData];
    }];
}
- (void)type{
    
    _caseType = @"";
    _caseEnvironment = @"";
    _caseDetail = @"";



}
- (void)dop{

    // 数据
    [self.viewModel.refreshDataCommandAL execute:@{@"type":@"1"}];
    
    [self.viewModel.refreshDataCommandALTYPE execute:@{@"type":@"2"}];
    
    self.classifys = @[@"类型"];
    _jiageArray = @[@"价格",@"5000以下",@"5000-10000",@"10000-20000",@"20000-30000",@"30000-50000"];
    self.areas = _jiageArray;
    self.sorts = @[@"环境"];
    
    // 添加下拉菜单
    int height = 64;
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        height = 84;
    }
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, height) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    menu.indicatorColor = MAINCOLOR;
    menu.textSelectedColor = MAINCOLOR;
    if (ScreenWidth == 320) {
         menu.fontSize = 13;
    }

    [self.view addSubview:menu];
    _menu = menu;
    
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
}

- (void)menuReloadData
{
    self.classifys = @[@"类型",@"价格",@"环境"];
    [_menu reloadData];
}

#pragma mark - 点击事件

- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.addguanUISubject subscribeNext:^(id  _Nullable x) {
        
        
        if (x[@"r"]) {
            if ([x[@"code"] integerValue] == 200) {
//                [NavigateManager showMessage:@"已关注"];
//                [self.table.mj_header beginRefreshing];
                self.viewModel.dataArray[self.indexRow.row].follow = YES;
                [self.table reloadData];
            }
            
        }
        
    }];
    [self.viewModel.deleteguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if (x[@"r"]) {
            if ([x[@"status"] integerValue] == 200) {
//                [NavigateManager showMessage:@"已取消关注"];
//                [self.table.mj_header beginRefreshing];
                self.viewModel.dataArray[self.indexRow.row].follow = NO;
                [self.table reloadData];
            }
            
        }
        
    }];
    
    
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
     
        @strongify(self);
        [self.view endEditing:YES];
        FindDetailViewController *find = [[FindDetailViewController alloc] init];
        find.hidesBottomBarWhenPushed = YES;
        Rows *model = x;
        find.idString = [NSString stringWithFormat:@"%ld",(long)model.id];
        [self pushToNextVCWithNextVC:find];
    }];
    
    [self.viewModel.guanBtnUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        _indexRow = x;
        Rows *model = self.viewModel.dataArray[_indexRow.row];
        if (![UserData UserLoginState]) {
            //预约cell
            NewLoginViewController *vc = [[NewLoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
        
        if (model.follow) {
            [self.viewModel.deleguanzhuCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id), @"followuserid":[NSString stringWithFormat:@"%ld",(long)model.id]}];
            
            
            
        }else {
            [self.viewModel.addguanzhuCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id), @"followuserid":[NSString stringWithFormat:@"%ld",(long)model.id],@"type":@"2"}];
        }
    }];
}


#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"FindTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FindTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.rowHeight = 250;
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        _curPage = 1;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if ([UserData UserLoginState]) {
            
            [dic setValue:@([UserData sharedManager].userInfoModel.id) forKey:@"userInfoBvo.id"];
        }
        
        
        [dic setValue:@"10" forKey:@"pageSize"];
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)_curPage] forKey:@"curPage"];
        
        if (![_userInfoBvoCity isEqualToString:@""]) {
            [dic setValue:_userInfoBvoCity forKey:@"userInfoBvo.city"];
        }
        if (![_caseType isEqualToString:@""]) {
            [dic setValue:_caseType forKey:@"caseType"];
        }
        if (![_caseEnvironment isEqualToString:@""]) {
            [dic setValue:_caseEnvironment forKey:@"caseEnvironment"];
        }
        if (![_caseDetail isEqualToString:@""]) {
            [dic setValue:_caseDetail forKey:@"caseDetail"];
        }

        [self.viewModel.refreshDataCommand execute:dic];

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
                    //传入参数 进行刷新
                    _curPage ++;
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:@"10" forKey:@"pageSize"];
                    [dic setValue:[NSString stringWithFormat:@"%ld",(long)_curPage] forKey:@"curPage"];
                    if (![_userInfoBvoCity isEqualToString:@""]) {
                        [dic setValue:_userInfoBvoCity forKey:@"userInfoBvo.city"];
                    }
                    if (![_caseType isEqualToString:@""]) {
                        [dic setValue:_caseType forKey:@"caseType"];
                    }
                    if (![_caseEnvironment isEqualToString:@""]) {
                        [dic setValue:_caseEnvironment forKey:@"caseEnvironment"];
                    }
                    if (![_caseDetail isEqualToString:@""]) {
                        [dic setValue:_caseDetail forKey:@"caseDetail"];
                    }
                    [self.viewModel.refreshDataCommand execute:dic];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        NSMutableArray *array = x[@"r"][@"rows"];
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
- (FindViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FindViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark - 代理


- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}


- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column < 2) {
//        return [@(arc4random()%1000) stringValue];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return [@(arc4random()%1000) stringValue];
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{


    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{

    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
//        NSLog(@"点击了 %ld - %ld - %ld",indexPath.column,indexPath.row,indexPath.item);
        if (indexPath.row == 0) {
            _caseType = @"";
            
        }else {
            
            _caseType = _typeArray[indexPath.row];
        
        }
    }else if (indexPath.column == 1) {
        
        if (indexPath.row == 0) {
            _caseDetail = @"";
            
        }else {
            _caseDetail = _jiageArray[indexPath.row];
            
        }
        
    }else {
        if (indexPath.row == 0) {
            _caseEnvironment = @"";
            
        }else {
            _caseEnvironment = _huanjinArray[indexPath.row];
            
        }
    }
    [self.table.mj_header beginRefreshing];
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
@end
