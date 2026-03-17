//
//  XuanzheMobanViewController.m
//  BoYi
//
//  Created by heng on 2017/12/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "XuanzheMobanViewController.h"
#import "DianziQingjianCollectionViewCell.h"
#import "ZhiZuoViewController.h"
#import "InvitationTempModel.h"

@interface XuanzheMobanViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property(nonatomic,assign)NSInteger curPage;

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation XuanzheMobanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"DianziQingjianCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell"];
    
    //下拉刷新
    @weakify(self);
    self.collectionAddress.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        _curPage = 1;
        [self getData];
        [self.collectionAddress.mj_header endRefreshing];
    }];
    if (self.collectionAddress.mj_header.isRefreshing) {
        if (!self.collectionAddress.mj_footer) {
            //上啦加载
            
            self.collectionAddress.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                //传入参数 进行刷新
                _curPage ++;
                [self getData];
            }];
        }
    }
    [self.collectionAddress.mj_header beginRefreshing];
}

- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    
    if (!self.dataArray) self.dataArray = [NSMutableArray array];
    if (isHeaderRefersh) [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:[InvitationTempModel mj_objectArrayWithKeyValuesArray:object[@"data"]]];
    
}
- (void)getData{
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = @{@"p":@(_curPage),@"leibieid":@(self.statusFlag)};
	WeakSelf(self);
    [[RequestManager sharedManager] requestUrl:URL_New_MobanList
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               //数据处理
                                               [weakSelf ConvertingToObject:response isHeaderRefersh:weakSelf.collectionAddress.mj_header.isRefreshing];
                                               NSArray *array = [NSArray array];
                                               array = response[@"data"];
                                               if (array.count < 10) {
                                                   
                                                   [self.collectionAddress.mj_footer endRefreshingWithNoMoreData];
                                               } else {
                                                   
                                                   self.collectionAddress.mj_footer.state == MJRefreshStateNoMoreData ? [self.collectionAddress.mj_footer resetNoMoreData] : [self.collectionAddress.mj_footer endRefreshing];
                                                   
                                               }
                                               
                                               [self.collectionAddress reloadData];
                                           }else{
                                               [self.collectionAddress.mj_header endRefreshing];
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [self.collectionAddress.mj_header endRefreshing];
                                       }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.dataArray.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZhiZuoViewController *zhizuo = [[ZhiZuoViewController alloc] init];
    zhizuo.tempModel = self.dataArray[indexPath.row];
    [self pushToNextVCWithNextVC:zhizuo];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DianziQingjianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell" forIndexPath:indexPath];
    InvitationTempModel *model = self.dataArray[indexPath.row];
    [cell.image sd_setImageWithUrl:model.cover placeHolder:[UIImage imageNamed:@"占位图片"]];
	cell.layer.masksToBounds = NO;
	cell.layer.contentsScale = [UIScreen mainScreen].scale;
	cell.layer.shadowOpacity = 0.3f;
	cell.layer.shadowRadius = 4.0f;
	cell.layer.shadowOffset = CGSizeMake(0,0);
	cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth/20*9 ,ScreenHeight/5*2);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 5;
    
}

@end
