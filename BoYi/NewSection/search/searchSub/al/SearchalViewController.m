//
//  SearchalViewController.m
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SearchalViewController.h"
#import "AnlieListSearchViewModel.h"
#import "AnlieListSearchModel.h"
#import "ShaiXuanAnlie.h"
#import "DopTableViewCell.h"
#import "AnlieNewDetilViewController.h"
@interface SearchalViewController ()<UITextFieldDelegate>{
    NSInteger _ambient,_cityid,_orderby,_p,_rows,_type,_userid,_ceilingprice,_floorprice;
}
@property(nonatomic,assign)NSInteger curPage;
@property(nonatomic,assign)NSInteger pageSize;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) AnlieListSearchViewModel *viewModel;
@property (nonatomic, strong) NSIndexPath *indexRow;
@end

@implementation SearchalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self dopac];
    [self setupTableView];
    _ambient = - 1;
    _cityid = - 1;
    _orderby = - 1;
    _p = 0;
    _rows = 10;
    _type = - 1;
    _userid = - 1;
    _floorprice = -1;
    _ceilingprice = -1;
    [self geTdata];
}
- (void)geTdata{
    
    //传入参数 进行刷新
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if (_orderby == 1) {
        [dic setValue:@(_orderby) forKey:@"orderby"];
    }
    if (_cityid != -1) {
        [dic setValue:@(_cityid) forKey:@"cityid"];
    }
    if (_ambient != -1) {
        [dic setValue:@(_ambient) forKey:@"ambient"];
    }
    if (_type != -1) {
        [dic setValue:@(_type) forKey:@"type"];
    }
    if (_ceilingprice != -1) {
        [dic setValue:@(_ceilingprice) forKey:@"ceilingprice"];
    }
    if (_floorprice != -1) {
        [dic setValue:@(_floorprice) forKey:@"floorprice"];
    }
    
    if ([UserDataNew sharedManager].userInfoModel.token.token) {
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    }else {
        
    }
    
    [dic setValue:@(100) forKey:@"rows"];
    [dic setValue:self.content forKey:@"cont"];
    [dic setValue:@"al" forKey:@"stype"];
    [dic setValue:@"成都市" forKey:@"city"];
    
    [[RequestManager sharedManager] requestUrl:URL_New_searchwu
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.dataAL = [NSArray array];
                                               self.dataAL = [Anlielistsearcharray mj_objectArrayWithKeyValuesArray:response[@"data"][@"anli"]];
                                               self.viewModel.dataArray = [NSMutableArray arrayWithArray:self.dataAL];
                                               [self.table reloadData];
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
    
}
- (void)dopac{
    
    for (int i  = 0; i < 4; i++) {
        
        UIView *btnSubView = [self.view viewWithTag:100 + i];
        UIButton *btn = (UIButton *)[btnSubView viewWithTag:200];
        @weakify(self);
        //点击
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self getBtnTag:i];
            for (int j  = 0; j < 4; j++) {
                if (i == j) {
                    
                    UIView *btnSubViewother = [self.view viewWithTag:100 + j];
                    UILabel *label = (UILabel *)[btnSubViewother viewWithTag:201];
                    UIImageView *image = (UIImageView *)[btnSubViewother viewWithTag:202];
                    label.textColor = RGBA(252, 88, 135, 1);
                    if (j == 3) {
                        image.image = [UIImage imageNamed:@"筛选"];
                    }else {
                        image.image = [UIImage imageNamed:@"下拉（未选中）"];
                    }
                    
                }else {
                    UIView *btnSubViewother = [self.view viewWithTag:100 + j];
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
        self.typeHuan = 1;
        self.zhegaiView.hidden = NO;
        self.tablesaixuanHeight.constant = self.leixingArray.count * 40 + 1;
        [self.leibieAndHuanjinTable reloadData];
    }else if (integer == 1){
        self.typeHuan = 2;
        self.zhegaiView.hidden = NO;
        self.tablesaixuanHeight.constant = self.huanjinArray.count * 40 + 1;
        [self.leibieAndHuanjinTable reloadData];
    }else if (integer == 2){
        self.typeHuan = 3;
        self.zhegaiView.hidden = YES;
        _orderby = 1;
        [self geTdata];
    }else {
        self.typeHuan = 4;
        self.zhegaiView.hidden = YES;
        [ShaiXuanAnlie showInView:[UIApplication sharedApplication].keyWindow block:^(NSDictionary *dic) {
            NSLog(@"%@",dic);
            if (![dic[@"zuidiAL"] isBlankString]) {
                _floorprice = [dic[@"zuidiAL"] integerValue];
            }else {
                _floorprice = -1;
            }
            if (![dic[@"zuigaoAL"] isBlankString]) {
                _ceilingprice = [dic[@"zuigaoAL"] integerValue];
            }else {
                _ceilingprice = -1;
            }
            [self geTdata];
            
        }];
    }
}


#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Anlielistsearcharray *x) {
        @strongify(self);
        AnlieNewDetilViewController *anlie = [[AnlieNewDetilViewController alloc] init];
        anlie.anlieID = x.id;
        [self pushToNextVCWithNextVC:anlie];
    }];
    [self.viewModel.addguanUISubject subscribeNext:^(id  _Nullable x) {
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.dataArray[self.indexRow.row].follow = 1;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }
    }];
    [self.viewModel.deleteguanzhuUISubject subscribeNext:^(id  _Nullable x) {

        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.dataArray[self.indexRow.row].follow = 0;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }
    }];
    [self.viewModel.loginSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"AnlieListSearchTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnlieListSearchTableViewCell"];
    //    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    
    self.leibieAndHuanjinTable.delegate             = self;
    self.leibieAndHuanjinTable.dataSource           = self;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    [self.viewModel.huanjinDataCommand execute:@{}];
    [self.viewModel.leixingDataCommand execute:@{}];
   
    //环境结束
    [self.viewModel.huanjinUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        self.huanjinArray = [Leixingandhuanjin mj_objectArrayWithKeyValuesArray:x];
        Leixingandhuanjin *model = [[Leixingandhuanjin alloc] init];
        model.title = @"环境";
        model.isSelete = YES;
        model.id = -1;
        if (self.huanjinArray.count > 0) {
            [self.huanjinArray insertObject:model atIndex:0];
        }
        
    }];
    //类型
    [self.viewModel.leixingUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        self.leixingArray = [Leixingandhuanjin mj_objectArrayWithKeyValuesArray:x];
        Leixingandhuanjin *model = [[Leixingandhuanjin alloc] init];
        model.title = @"全部";
        model.isSelete = YES;
        model.id = -1;
        if (self.leixingArray.count > 0) {
            [self.leixingArray insertObject:model atIndex:0];
        }
    }];
    //请求结束
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (AnlieListSearchViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AnlieListSearchViewModel alloc] init];
    }
    return _viewModel;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}



#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.typeHuan == 1) {
        return self.leixingArray.count;
    }else if (self.typeHuan == 2){
        return self.huanjinArray.count;
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
    if (self.typeHuan == 1) {
        for (int i = 0; i < self.leixingArray.count; i ++) {
            self.leixingArray[i].isSelete = NO;
        }
        self.leixingArray[indexPath.row].isSelete = YES;
        self.typeName.text = self.leixingArray[indexPath.row].title;
        _type = self.leixingArray[indexPath.row].id;
    }if (self.typeHuan == 2){
        for (int i = 0; i < self.huanjinArray.count; i ++) {
            self.huanjinArray[i].isSelete = NO;
        }
        self.huanjinArray[indexPath.row].isSelete = YES;
        self.huanjinName.text = self.huanjinArray[indexPath.row].title;
        _ambient = self.leixingArray[indexPath.row].id;
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
    if (self.typeHuan == 1) {
        cell.name.text = self.leixingArray[indexPath.row].title;
        if (self.leixingArray[indexPath.row].isSelete) {
            cell.gouxuanImage.hidden = NO;
        }else {
            cell.gouxuanImage.hidden = YES;
        }
    }if (self.typeHuan == 2){
        cell.name.text = self.huanjinArray[indexPath.row].title;
        if (self.huanjinArray[indexPath.row].isSelete) {
            cell.gouxuanImage.hidden = NO;
        }else {
            cell.gouxuanImage.hidden = YES;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

@end
