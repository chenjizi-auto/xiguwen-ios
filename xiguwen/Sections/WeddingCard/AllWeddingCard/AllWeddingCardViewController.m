//
//  AllWeddingCardViewController.m
//  BoYi
//
//  Created by Chen on 2017/9/3.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AllWeddingCardViewController.h"
#import "AllWeddingCardViewModel.h"
#import "ShowWeddingCardViewController.h"

@interface AllWeddingCardViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) AllWeddingCardViewModel *viewModel;

@end

@implementation AllWeddingCardViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"新建喜帖";
    [self addPopBackBtn];
    
//    [self setupTableView];
    [self addCrossCollectionView];
    [self cellClick];
    [self.collectionView.mj_header beginRefreshing];
    
}


#pragma mark - 点击事件

- (void)cellClick {
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(AllWeddingCardModel *x) {
        @strongify(self);
        ShowWeddingCardViewController *vc = [[ShowWeddingCardViewController alloc] init];
        vc.cardId = x.id;
//        vc.url    = x.url;
        [self pushToNextVCWithNextVC:vc];
    }];
}

#pragma mark - public api


#pragma mark - private api


- (void)addCrossCollectionView {
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"AllWeddingCardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AllWeddingCardCollectionViewCell"];
    self.collectionView.delegate = self.viewModel;
    self.collectionView.dataSource = self.viewModel;
    self.collectionView.emptyDataSetSource = self.viewModel;
    self.collectionView.emptyDataSetDelegate = self.viewModel;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat width = (ScreenWidth - 80) / 3;
    CGFloat height = width * 3 / 2;
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    
    CGFloat oneX = 20;
    layout.sectionInset = UIEdgeInsetsMake(oneX, oneX, 0, oneX);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //    self.collectionView.contentSize = CGSizeMake(ScreenWidth - 100, 100);
    //    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    @weakify(self);
    
    //下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.collectionView.mj_header.isRefreshing];
        
        //正在下啦
        if (self.collectionView.mj_header.isRefreshing) {
            
            if (!self.collectionView.mj_footer) {
                //上啦加载
                self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    [self.viewModel.refreshDataCommand execute:@{}];
                }];
            }
            [self.collectionView.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 10) {
            
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.collectionView.mj_footer.state == MJRefreshStateNoMoreData ? [self.collectionView.mj_footer resetNoMoreData] : [self.collectionView.mj_footer endRefreshing];
            
        }
        //刷新视图
        [self.collectionView reloadData];
        
    }];
    
    //异常处理
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        
        if (self.collectionView.mj_header.isRefreshing) [self.collectionView.mj_header endRefreshing];
        if (self.collectionView.mj_footer.isRefreshing) [self.collectionView.mj_footer endRefreshing];
    }];

}

//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"AllWeddingCardTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AllWeddingCardTableViewCell"];
    //[self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    
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
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    [self.viewModel.refreshDataCommand execute:@{}];
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
}

//初始化viewModel
- (AllWeddingCardViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AllWeddingCardViewModel alloc] init];
    }
    return _viewModel;
}


@end
