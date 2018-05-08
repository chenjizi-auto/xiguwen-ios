//
//  DianziQingjianHomeViewController.m
//  BoYi
//
//  Created by heng on 2017/12/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "DianziQingjianHomeViewController.h"
#import "DianziQingjianCollectionViewCell.h"
#import "XuanzheqingjianSubViewController.h"
#import "BingkeSub.h"
#import "MyInvitationCardModel.h"
#import "QingjianHomeViewController.h"

@interface DianziQingjianHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (weak, nonatomic) IBOutlet UIImageView *zhufuImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation DianziQingjianHomeViewController

- (NSMutableArray *)dataArray {
	if (!_dataArray) {
		_dataArray = [[NSMutableArray alloc] init];
	}
	return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    [self getdata];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"电子请柬";
    [self addPopBackBtn];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"DianziQingjianCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell"];
    [self getMoBanType];
	
	// 添加点击事件
	[self.zhufuImageView setUserInteractionEnabled:YES];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zhufu:)];
	[self.zhufuImageView addGestureRecognizer:tap];
	
}
- (void)getMoBanType{

    [[RequestManager sharedManager] requestUrl:URL_New_MobanType
                                        method:POST
                                        loding:@""
                                           dic:nil
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               NSArray *array = [NSMutableArray array];
                                               array = response[@"data"];
                                               [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"MobanType"];
                                               
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       }];
}
- (void)getdata{
	WeakSelf(self);
    NSDictionary *dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    [[RequestManager sharedManager] requestUrl:URL_New_wozhizuoqingjian
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
											   [weakSelf.dataArray removeAllObjects];
                                               [weakSelf.dataArray addObjectsFromArray:[MyInvitationCardModel mj_objectArrayWithKeyValuesArray:response[@"data"]]];
                                               if (weakSelf.dataArray.count == 0) {
                                                   weakSelf.isNUll.hidden = NO;
                                               }else {
                                                   weakSelf.isNUll.hidden = YES;
                                               }
                                               [self.collectionAddress reloadData];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       }];
}
- (IBAction)popac:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zhufu:(UITapGestureRecognizer *)sender {
	BingkeSub *vc = [[BingkeSub alloc] init];
	vc.titleColorSelected = MAINCOLOR;
	vc.menuViewStyle = WMMenuViewStyleLine;
	vc.automaticallyCalculatesItemWidths = YES;
	vc.progressWidth = 10;
	vc.progressViewIsNaughty = YES;
	vc.showOnNavigationBar = NO;
	vc.type = 0;
	vc.hidesBottomBarWhenPushed = YES;
	[self pushToNextVCWithNextVC:vc];
}


- (IBAction)bingke:(UITapGestureRecognizer *)sender {
    BingkeSub *vc = [[BingkeSub alloc] init];
    vc.titleColorSelected = MAINCOLOR;
    vc.menuViewStyle = WMMenuViewStyleLine;
    vc.automaticallyCalculatesItemWidths = YES;
    vc.progressWidth = 10;
    vc.progressViewIsNaughty = YES;
    vc.showOnNavigationBar = NO;
    vc.type = 1;
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextVCWithNextVC:vc];
}


- (IBAction)xuanAC:(UIButton *)sender {
    XuanzheqingjianSubViewController *vc = [[XuanzheqingjianSubViewController alloc] init];
    vc.titleColorSelected = MAINCOLOR;
    vc.menuViewStyle = WMMenuViewStyleLine;
    vc.automaticallyCalculatesItemWidths = YES;
    vc.progressWidth = 10;
    vc.progressViewIsNaughty = YES;
    vc.showOnNavigationBar = NO;
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextVCWithNextVC:vc];
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
	// 跳转我的请柬请柬主页
	QingjianHomeViewController *win = [[QingjianHomeViewController alloc] init];
	win.model = self.dataArray[indexPath.row];
	[self pushToNextVCWithNextVC:win];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    //重用cell
    DianziQingjianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell" forIndexPath:indexPath];
	MyInvitationCardModel *model = self.dataArray[indexPath.row];
    [cell.image sd_setImageWithUrl:model.cover];
	
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
    return 5;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 5;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGPoint point = scrollView.contentOffset;
	
//	if (self.headerHeight.constant > 64 && self.headerHeight.constant < 150) {
//		self.headerHeight.constant = 150 - point.y;
	if (point.y >= 0 && point.y <= 200-64) {
		self.topHeight.constant = -point.y;
	}
//	}
}


@end


