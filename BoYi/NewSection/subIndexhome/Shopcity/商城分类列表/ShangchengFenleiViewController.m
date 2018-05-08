//
//  ShangchengFenleiViewController.m
//  BoYi
//
//  Created by heng on 2018/2/28.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengFenleiViewController.h"
#import "ShangchengFenleiViewModel.h"
#import "ShangchengFenleiModel.h"
#import "ScfenCollectionViewCell.h"
#import "SearchNewViewController.h"
#import "ShangChengListNewViewController.h"

@interface ShangchengFenleiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShangchengFenleiViewModel *viewModel;
@property (strong,nonatomic) NSMutableArray <ChildrenshangChengfl *>*dataArray;
@end

@implementation ShangchengFenleiViewController

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
        self.hegiht.constant = 84;
    }
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerNib:[UINib nibWithNibName:@"ScfenCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ScfenCollectionViewCell"];
}
- (IBAction)alltion:(UIButton *)sender {
    if (sender.tag == 1) {
        [self popViewConDelay];
    }else {
        SearchNewViewController *vc = [[SearchNewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Shangchengfenlei *x) {
        @strongify(self);
        
        for (int i = 0; i < self.viewModel.dataArray.count; i++ ) {
            if (self.viewModel.dataArray[i].isselete) {
                self.dataArray = [NSMutableArray arrayWithArray:self.viewModel.dataArray[i].children];
                break;
            }
        }
        [self.collection reloadData];
    }];
    
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        //        [NavigateManager showMessage:@"操作成功"];
        //        [self.table.mj_header beginRefreshing];
//    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShangchengFenleiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShangchengFenleiTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        self.viewModel.dataArray[0].isselete = YES;
        for (int i = 0; i < self.viewModel.dataArray.count; i++ ) {
            if (self.viewModel.dataArray[i].isselete) {
                self.dataArray = [NSMutableArray arrayWithArray:self.viewModel.dataArray[i].children];
                break;
            }
        }
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
//                }];
//            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//
//        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        [self.collection reloadData];
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (ShangchengFenleiViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShangchengFenleiViewModel alloc] init];
    }
    return _viewModel;
}


//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ScfenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScfenCollectionViewCell" forIndexPath:indexPath];
    ChildrenshangChengfl *model = [[ChildrenshangChengfl alloc] init];
    model = self.dataArray[indexPath.row];
    cell.name.text = model.wapname;
    [cell.imagew sd_setImageWithUrl:model.wapimg placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShangChengListNewViewController *vc = [[ShangChengListNewViewController alloc] init];
    ChildrenshangChengfl *model = [[ChildrenshangChengfl alloc] init];
    model = self.dataArray[indexPath.row];
    vc.id = model.id;
    [self pushToNextVCWithNextVC:vc];
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 100)/3 - 5,88);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0 );//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 0;
    
}
@end
