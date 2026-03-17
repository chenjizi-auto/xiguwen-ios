//
//  WeddingCardViewController.m
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "WeddingCardViewController.h"
#import "WeddingCardViewModel.h"
#import "ShowWeddingCardViewController.h"
#import "SurePayViewController.h"
#import "ShopCarList.h"

@interface WeddingCardViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) WeddingCardViewModel *viewModel;

@end

@implementation WeddingCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([UserData UserLoginState]) {
        [self.viewModel.refreshDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id)}];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"喜帖";
    [self addRightBtnWithTitle:@"" image:@"购物车"];
//    [self setupTableView];
    [self addCrossCollectionView];
    
}
- (void)respondsToRightBtn{
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

#pragma mark - 点击事件

- (IBAction)createNew:(id)sender {
    
    [self pushToNextvcWithNextVCTitle:@"AllWeddingCardViewController"];
    
}


#pragma mark - public api
#pragma mark - 横屏滚动
- (void)addCrossCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:@"WeddingCardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WeddingCardCollectionViewCell"];
    self.collectionView.delegate = self.viewModel;
    self.collectionView.dataSource = self.viewModel;
    self.collectionView.emptyDataSetSource = self.viewModel;
    self.collectionView.emptyDataSetDelegate = self.viewModel;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(ScreenWidth - 60, ScreenHeight / 3);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    CGFloat oneX = 30;
    layout.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    //    self.collectionView.contentSize = CGSizeMake(ScreenWidth - 100, 100);
    //    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    @weakify(self);
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:YES];
        [self.collectionView reloadData];
        
    }];
    
    
    [self.viewModel.selectItemSubject subscribeNext:^(WeddingCardModel *x) {
        @strongify(self);
        
        ShowWeddingCardViewController *vc = [[ShowWeddingCardViewController alloc] init];
        vc.model = x;
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
    }];
}


//初始化viewModel
- (WeddingCardViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WeddingCardViewModel alloc] init];
    }
    return _viewModel;
}


@end
