//
//  HunqinQuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinQuanViewController.h"
#import "HunqinQuanViewModel.h"
#import "HunqinQuanModel.h"
#import "DongtaiDetilViewController.h"
#import "fenLeiModel.h"
#import "DopTableViewCell.h"
#import "CXHunqingquanTableViewCell.h"
#import "MJPhotoBrowser.h"
#import "WriteDongtaiViewController.h"

static NSString *CXHunqingquanTableViewCellIndentifier = @"CXHunqingquanTableViewCellIndentifier";
@interface HunqinQuanViewController (){
    NSInteger follow,p,type;
    NSString *hot,*newest;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HunqinQuanViewModel *viewModel;
@property (nonatomic ,strong) NSMutableArray *Data;

@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation HunqinQuanViewController

- (NSArray *)imageArray {
	if (!_imageArray) {
		_imageArray = [[NSArray alloc] init];
	}
	return _imageArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    follow = 0;
    type = -1;
    hot = @"";
    newest = @"";
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}
- (IBAction)actionall:(UIButton *)sender {
    if (sender.tag == 0) {//全部
        [self selemoren];
    }else if (sender.tag == 1) {//最新
        if (sender.selected) {
            [self seleZuixinGao];
        }else {
            [self seleZuixinDi];
        }
        sender.selected = !sender.selected;
    }else if (sender.tag == 2){//热门
        if (sender.selected) {
            [self seleRemenGao];
        }else {
            [self seleRemenDi];
        }
        sender.selected = !sender.selected;
    }else {
        [self seleguanzhu];
    }
    [self.table.mj_header beginRefreshing];
}
- (void)selemoren{
    follow = 0;
    hot = @"";//desc asc
    newest = @"";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = NO;
}
- (void)seleguanzhu{
    follow = 1;
    hot = @"";//desc asc
    newest = @"";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}
- (void)seleZuixinGao{
    follow = 0;
    hot = @"";//desc asc
    newest = @"desc";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = NO;
    self.zuixinImage.image = [UIImage imageNamed:@"价格从高到低"];
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}
- (void)seleZuixinDi{
    follow = 0;
    hot = @"";//desc asc
    newest = @"asc";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = NO;
    self.zuixinImage.image = [UIImage imageNamed:@"价格从低到高"];
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}
- (void)seleRemenGao{
    follow = 0;
    hot = @"";//desc asc
    newest = @"desc";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.image = [UIImage imageNamed:@"价格从高到低"];
    self.remenImage.hidden = NO;
    [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}
- (void)seleRemenDi{
    follow = 0;
    hot = @"";//desc asc
    newest = @"asc";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.image = [UIImage imageNamed:@"价格从低到高"];
    self.remenImage.hidden = NO;
    [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}

#pragma mark - 点击事件
- (IBAction)writeDongtai:(id)sender {
    
    WriteDongtaiViewController *vc = [[WriteDongtaiViewController alloc] init];
    [self pushToNextVCWithNextVC:vc];
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Hunqinnewarray *x) {
        @strongify(self);
        DongtaiDetilViewController *dongtai = [[DongtaiDetilViewController alloc] init];
        dongtai.id = x.id;
        dongtai.superModel = x;
        
        [self pushToNextVCWithNextVC:dongtai];
        @weakify(self);
        [dongtai.refreshDataSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.table reloadData];
        }];
    }];
    [self.viewModel.fenleilistUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        _Data = [x mutableCopy];
        //分类数据处理
        self.quanbuArray = [NSMutableArray array];
        self.quanbuArray = [Fenleiarray mj_objectArrayWithKeyValuesArray:x];
        Fenleiarray *model = [[Fenleiarray alloc] init];
        model.proname = @"全部";
        model.isSelete = YES;
        model.occupationid = -1;
        NSLog(@"-=-%@",model.wapimg);
        if (self.quanbuArray.count > 0) {
            [self.quanbuArray insertObject:model atIndex:0];
        }
        
        
        [self.tablexiala reloadData];
    }];
//    [self.viewModel.refreshdateSubject subscribeNext:^(Hunqinnewarray *x) {
//        @strongify(self);
//        [self.table.mj_header beginRefreshing];
//    }];
    //评论
    [self.viewModel.pinglunseleUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger i = [x integerValue];
        [HuifuiPL showInView:self.view setid:i block:^(NSString *date) {
            [self.table.mj_header beginRefreshing];
        }];
    }];
    
    [self.viewModel.dianzanSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.table reloadData];
    }];
    [self.viewModel.refreshdateSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.table reloadData];
    }];
}

#pragma mark - public api

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    [self.tablexiala registerNib:[UINib nibWithNibName:@"DopTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"DopTableViewCell"];
    self.tablexiala.delegate             = self;
    self.tablexiala.dataSource           = self;
    [self.table registerNib:[UINib nibWithNibName:@"HunqinQuanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunqinQuanTableViewCell"];
    [self.table registerClass:[CXHunqingquanTableViewCell class] forCellReuseIdentifier:CXHunqingquanTableViewCellIndentifier];
    //    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    [self.viewModel.fenleilistDataCommand execute:@{}];
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        p = 1;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (follow != 0) {
            [dic setObject:@(follow) forKey:@"follow"];
        }
        if (![hot isEqualToString:@""]) {
            [dic setObject:hot forKey:@"hot"];
        }
        if (![newest isEqualToString:@""]) {
            [dic setObject:newest forKey:@"newest"];
        }
        if (type != -1 ) {
            [dic setObject:@(type) forKey:@"type"];
        }
        
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setObject:@(p) forKey:@"p"];
        
        
        
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
                p ++;
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    if (follow != 0) {
                        [dic setObject:@(follow) forKey:@"follow"];
                    }
                    if (![hot isEqualToString:@""]) {
                        [dic setObject:hot forKey:@"hot"];
                    }
                    if (![newest isEqualToString:@""]) {
                        [dic setObject:newest forKey:@"newest"];
                    }
                    if (type != -1) {
                        [dic setObject:@(type) forKey:@"type"];
                    }
                    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                    [dic setObject:@(p) forKey:@"p"];
                    
                    
                    
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
- (HunqinQuanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HunqinQuanViewModel alloc] init];
		WeakSelf(self);
		[_viewModel setOnSelectedImage:^(NSArray *array, NSInteger index) {
//			weakSelf.imageArray = array;
            [weakSelf tapImage:array];
		}];
        [_viewModel setOnSelectedHeader:^(NSInteger index) {
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = index;
            [weakSelf pushToNextVCWithNextVC:vc];
        }];
    }
    return _viewModel;
}
#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.quanbuArray.count;
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
    for (int i = 0; i < self.quanbuArray.count; i ++) {
        self.quanbuArray[i].isSelete = NO;
    }
    self.quanbuArray[indexPath.row].isSelete = YES;
    [self.allBTN setTitle:self.quanbuArray[indexPath.row].proname forState:UIControlStateNormal];
    if ([self.quanbuArray[indexPath.row].proname isEqualToString:@"全部"]) {
        type = -1;
        
    }else {
        type = self.quanbuArray[indexPath.row].occupationid;
    }
    
    
    self.tabheightview.hidden = YES;
    [self.tablexiala reloadData];
    [self.table.mj_header beginRefreshing];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    DopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DopTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DopTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.name.text = self.quanbuArray[indexPath.row].proname;
    if (self.quanbuArray[indexPath.row].isSelete) {
        cell.gouxuanImage.hidden = NO;
    }else {
        cell.gouxuanImage.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
//	self.imageArray = self.quanbuArray[indexPath.row].;
//	[cell set];
	
	
    return  cell;
    //    CXHunqingquanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CXHunqingquanTableViewCellIndentifier];
    //    [cell imagesLoadwithData:@[] withDes:@""];
    //    return cell;
}
- (void)tapImage:(NSArray *)urls
{
    NSInteger count = urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        
        // 替换为中等尺寸图片
        NSString *url = urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = nil;//self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;//tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
@end

