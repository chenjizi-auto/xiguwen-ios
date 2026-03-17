//
//  SearchscViewController.m
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SearchscViewController.h"
#import "ShangChengListNewViewModel.h"
#import "ShangChengListnCollectionViewCell.h"
#import "ShangChengListNewModel.h"
@interface SearchscViewController (){
    NSInteger comprehensive,salesvolume;
    NSString *price;
    NSInteger p;
}
@property (strong,nonatomic) NSMutableArray <Shopnew *>*dataArray;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShangChengListNewViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@end

@implementation SearchscViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self cellClick];
    [self selemoren];
    [self setupTableView];
    [self setupCollectionView];
    [self geTdata];

}
- (void)geTdata{
    
    //传入参数 进行刷新
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:@(100) forKey:@"rows"];
    
    if (comprehensive != 0) {
        [dic setObject:@"1" forKey:@"comprehensive"];
    }
    if (salesvolume != 0) {
        [dic setObject:@"1" forKey:@"salesvolume"];
    }
    if (![price isEqualToString:@""]) {
        [dic setObject:price forKey:@"price"];
    }
    
    
    [dic setValue:self.content forKey:@"cont"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@"sp" forKey:@"stype"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [dic setValue:@"成都市" forKey:@"city"];
    
    [[RequestManager sharedManager] requestUrl:URL_New_searchwu
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.dataArray = [NSMutableArray array];
                                               self.dataArray = [Shopnew mj_objectArrayWithKeyValuesArray:response[@"data"][@"shop"]];
                                               [self.collection reloadData];
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
    
}

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
    }];
}
#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShangChengListNewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShangChengListNewTableViewCell"];
    //    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
//    self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        @strongify(self);
        //传入参数 进行刷新
//        p = 1;
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//
//        if (comprehensive != 0) {
//            [dic setObject:@"1" forKey:@"comprehensive"];
//        }
//        if (salesvolume != 0) {
//            [dic setObject:@"1" forKey:@"salesvolume"];
//        }
//        if (![price isEqualToString:@""]) {
//            [dic setObject:price forKey:@"price"];
//        }
//        [dic setObject:@(self.id) forKey:@"id"];
//        [dic setObject:@(p) forKey:@"p"];
//        [dic setObject:@"10" forKey:@"rows"];
//
//
//        [self.viewModel.refreshDataCommand execute:dic];
//    }];
    //请求结束
//    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
//
//        @strongify(self);
//
//        if (!self.dataArray) self.dataArray = [NSMutableArray array];
//        if (self.collection.mj_header.isRefreshing) [self.dataArray removeAllObjects];
//
//        [self.dataArray addObjectsFromArray:[Shopnew mj_objectArrayWithKeyValuesArray:x[@"shop"]]];
        //正在下啦
//        if (self.collection.mj_header.isRefreshing) {
//
//            if (!self.collection.mj_footer) {
//                //上啦加载
//                self.collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    p ++;
//                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//
//                    if (comprehensive != 0) {
//                        [dic setObject:@"1" forKey:@"comprehensive"];
//                    }
//                    if (salesvolume != 0) {
//                        [dic setObject:@"1" forKey:@"salesvolume"];
//                    }
//                    if (![price isEqualToString:@""]) {
//                        [dic setObject:price forKey:@"price"];
//                    }
//                    [dic setObject:@(self.id) forKey:@"id"];
//                    [dic setObject:@(p) forKey:@"p"];
//                    [dic setObject:@"10" forKey:@"rows"];
//
//                    [self.viewModel.refreshDataCommand execute:dic];
//                }];
//            }
//            [self.collection.mj_header endRefreshing];
//        }
        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//            [self.collection.mj_footer endRefreshingWithNoMoreData];
//        } else {
//
//            self.collection.mj_footer.state == MJRefreshStateNoMoreData ? [self.collection.mj_footer resetNoMoreData] : [self.collection.mj_footer endRefreshing];
//        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
//        [self.collection reloadData];
//    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.collection.mj_header.isRefreshing) [self.collection.mj_header endRefreshing];
        if (self.collection.mj_footer.isRefreshing) [self.collection.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (ShangChengListNewViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShangChengListNewViewModel alloc] init];
    }
    return _viewModel;
}
- (void)setupCollectionView{
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerNib:[UINib nibWithNibName:@"ShangChengListnCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangChengListnCollectionViewCell"];
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
    ShangChengListnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangChengListnCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
    vc.shangpinID = self.dataArray[indexPath.row].shopid;
    [self pushToNextVCWithNextVC:vc];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 10)/2,245);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (IBAction)actionall:(UIButton *)sender {
    if (sender.tag == 0) {//综合
        [self seleZonghe];
    }else if (sender.tag == 1) {//销量
        [self selexiaoliang];
    }else {//价格
        if (sender.selected) {
            [self seleGaojiage];
        }else {
            [self seleDijiage];
        }
        sender.selected = !sender.selected;
    }
    [self geTdata];
}
- (void)selemoren{
    comprehensive = 0;
    price = @"";
    salesvolume = 0;
    self.jiageImage.hidden = YES;
    [self.zhongheBTn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.xiaoliangBtn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.jiageBTn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
}
- (void)seleZonghe{
    comprehensive = 1;
    price = @"";
    salesvolume = 0;
    self.jiageImage.hidden = YES;
    [self.zhongheBTn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.xiaoliangBtn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.jiageBTn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
}
- (void)selexiaoliang{
    comprehensive = 0;
    price = @"";
    salesvolume = 1;
    self.jiageImage.hidden = YES;
    [self.zhongheBTn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.xiaoliangBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.jiageBTn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
}
- (void)seleGaojiage{
    comprehensive = 0;
    price = @"desc";
    salesvolume = 0;
    self.jiageImage.hidden = NO;
    self.jiageImage.image = [UIImage imageNamed:@"价格从低到高"];
    [self.zhongheBTn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.xiaoliangBtn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.jiageBTn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
}
- (void)seleDijiage{
    comprehensive = 0;
    price = @"asc";
    salesvolume = 0;
    self.jiageImage.hidden = NO;
    self.jiageImage.image = [UIImage imageNamed:@"价格从高到低"];
    [self.zhongheBTn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.xiaoliangBtn setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.jiageBTn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
}

@end
