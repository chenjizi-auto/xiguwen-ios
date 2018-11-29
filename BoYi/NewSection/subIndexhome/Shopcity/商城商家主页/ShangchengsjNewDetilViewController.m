//
//  ShangchengsjNewDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/2/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengsjNewDetilViewController.h"
#import "ShangchengsjNewDetilViewModel.h"
#import "ShangchengsjNewDetilModel.h"
#import "ShangjiaZhuyeCollectionViewCell.h"
#import "ShangpinNewDetilViewController.h"
#import "NewShangjiaDongtaiModel.h"
#import "MJPhotoBrowser.h"
@interface ShangchengsjNewDetilViewController (){
    NSInteger comprehensive,salesvolume;
    NSString *price;
    NSInteger p1,p2,p3;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShangchengsjNewDetilViewModel *viewModel;
@property (nonatomic,retain) NSMutableArray *photosArray;
@property (strong,nonatomic) ShareNewmodel *sharemodel;
@end

@implementation ShangchengsjNewDetilViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
//
    self.navigationItem.title = @"商家主页";
    [self addPopBackBtn];
    [self cellClick];
    [self setupTableView];
    [self setupCollectionView];
    [self.collection.mj_header beginRefreshing];
    if (isIPhoneX) {
        self.height.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
    }
    self.type = 0;
    [self selemoren];
    for (int i  = 0; i < 5; i++) {
        
        UIView *btnSubView = [self.fatherview viewWithTag:100 + i];
        UIButton *btn = (UIButton *)[btnSubView viewWithTag:200];
        @weakify(self);
        //点击
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self setMarkType:i];
            
        }];
    }
    [self addRightBtnWithTitle:nil image:@"分享的副本"];
    [self shareData];
}
- (void)respondsToRightBtn {
    if (self.sharemodel) {
        [CwShareManager shareWebPageToPlatformWithUrl:self.sharemodel.url
                                                image:self.sharemodel.image
                                                title:self.sharemodel.title
                                                descr:self.sharemodel.descr
                                                   vc:self
                                           completion:^(id data, NSError *error) {
                                               
                                           }];
    }
}
- (void)shareData{
    NSDictionary *dic = @{@"id":@(self.id)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxiangshops"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.sharemodel = [ShareNewmodel mj_objectWithKeyValues:response[@"data"]];
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];
                                           
                                       }];
}

- (IBAction)guanzhu:(UIButton *)sender {
    
    if ([UserDataNew sharedManager].userInfoModel.token.token) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:[NSString stringWithFormat:@"%ld",self.model.user.userid] forKey:@"id"];
        if (self.model.user.follow == 1) {
            [[RequestManager sharedManager] requestUrl:URL_deleGuanzhu
                                                method:POST
                                                loding:@""
                                                   dic:dic
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       self.model.user.follow = 0;
                                                       [self.isguanBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];

                                                   }else{
                                                       
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               }];
            
        }else {
            [[RequestManager sharedManager] requestUrl:URL_ADDUserFollowById
                                                method:POST
                                                loding:@""
                                                   dic:dic
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if ([response[@"code"] integerValue] == 0) {
                                                       self.model.user.follow = 1;
                                                       [self.isguanBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
                                                   }else{
                                                       
                                                       [NavigateManager showMessage:response[@"message"]];
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               }];
        }
    }else {
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
    
}

- (void)setupCollectionView{
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerNib:[UINib nibWithNibName:@"ShangjiaZhuyeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaZhuyeCollectionViewCell"];
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
    ShangjiaZhuyeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaZhuyeCollectionViewCell" forIndexPath:indexPath];
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


#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger index = [x integerValue];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.viewModel.dataArrayDongtai[index].photourl.count; i ++) {
        
            [array addObject:self.viewModel.dataArrayDongtai[index].photourl[i].photourl];
        }
        [self tapImage:array];
    }];
    //全部
    [self.viewModel.indexSubject subscribeNext:^(ShangchengsjNewDetilModel *x) {
        @strongify(self);
    }];
    //热门
    [self.viewModel.hotSubject subscribeNext:^(ShangchengsjNewDetilModel *x) {
        @strongify(self);
    }];
}
#pragma mark - 点击事件
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
#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"ShangchengsjNewDetilTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShangchengsjNewDetilTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ShangjiaNewthreeTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShangjiaNewthreeTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        p1 = 1;
        @strongify(self);
        
        
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        if (comprehensive != 0) {
            [dic setObject:@"1" forKey:@"comprehensive"];
        }
        if (salesvolume != 0) {
            [dic setObject:@"1" forKey:@"salesvolume"];
        }
        if (![price isEqualToString:@""]) {
            [dic setObject:price forKey:@"price"];
        }
        [dic setObject:@(self.id) forKey:@"id"];
        [dic setObject:@(p1) forKey:@"p"];
        [dic setObject:@"10" forKey:@"rows"];
        if (self.type == 0) {
            [self.viewModel.refreshDataCommand execute:dic];
        }
        if (self.type == 1) {
            [self.viewModel.hotDataCommand execute:dic];
        }
        if (self.type == 2) {
            [self.viewModel.indexDataCommand execute:dic];
        }
        
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
//        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.collection.mj_header.isRefreshing];
        
        
        
        if (!self.dataArray) self.dataArray = [NSMutableArray array];
        if (self.collection.mj_header.isRefreshing) [self.dataArray removeAllObjects];
        
        if (self.type == 0) {
            self.model = [ShangchengsjNewDetilModel mj_objectWithKeyValues:x];
            [self.headerimage sd_setImageWithUrl:self.model.user.head placeHolder:[UIImage imageNamed:@"头像"]];
            self.fans.text = [NSString stringWithFormat:@"粉丝 %ld",self.model.user.fans];
            self.name.text = [NSString stringWithFormat:@"¥%@",self.model.user.nickname];
            if (self.model.user.follow == 1) {
                [self.isguanBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
            }else {
                [self.isguanBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];
            }
        }
        [self.dataArray addObjectsFromArray:[Shopshangchengsj mj_objectArrayWithKeyValuesArray:x[@"shop"]]];
        
        //正在下啦
        if (self.collection.mj_header.isRefreshing) {
            p1 ++;
            if (!self.collection.mj_footer) {
                //上啦加载
                self.collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    p1 = 1;
                    if (comprehensive != 0) {
                        [dic setObject:@"1" forKey:@"comprehensive"];
                    }
                    if (salesvolume != 0) {
                        [dic setObject:@"1" forKey:@"salesvolume"];
                    }
                    if (![price isEqualToString:@""]) {
                        [dic setObject:price forKey:@"price"];
                    }
                    [dic setObject:@(self.id) forKey:@"id"];
                    [dic setObject:@(p1) forKey:@"p"];
                    [dic setObject:@"10" forKey:@"rows"];
                    [self.viewModel.refreshDataCommand execute:dic];
                }];
            }
            [self.collection.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 10) {
            
            [self.collection.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.collection.mj_footer.state == MJRefreshStateNoMoreData ? [self.collection.mj_footer resetNoMoreData] : [self.collection.mj_footer endRefreshing];
            
        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.collection reloadData];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.collection.mj_header.isRefreshing) [self.collection.mj_header endRefreshing];
        if (self.collection.mj_footer.isRefreshing) [self.collection.mj_footer endRefreshing];
    }];
    
    
    
    //tale
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        p1 = 1;
        @strongify(self);
        //传入参数 进行刷新
        
        //动态
        if (self.type == 3) {
            [self.viewModel.pinglunDataCommand execute:@{@"id":@(self.id),@"rows":@"1000"}];
        }
        if (self.type == 4) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:@(self.id) forKey:@"id"];
            [dic setValue:@"1000" forKey:@"rows"];
            [self.viewModel.dongtaiDataCommand execute:dic];
        }
    }];
    
    //请求结束
    [self.viewModel.pinglunSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        self.viewModel.dataArrayPingjia = [NSMutableArray array];
        [self.viewModel.dataArrayPingjia addObjectsFromArray:[Shangjiapinglun mj_objectArrayWithKeyValuesArray:x]];
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        [self.table reloadData];
    }];
    [self.viewModel.dongtaiSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        self.viewModel.dataArrayDongtai = [NSMutableArray array];
        [self.viewModel.dataArrayDongtai addObjectsFromArray:[Dongtaiarray mj_objectArrayWithKeyValuesArray:x]];
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        [self.table reloadData];
    }];
    
    //处理请求失败
    [self.viewModel.dongtaiDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    [self.viewModel.pinglunDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (ShangchengsjNewDetilViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShangchengsjNewDetilViewModel alloc] init];
    }
    return _viewModel;
}
- (void)setMarkType:(NSInteger)markType{
    p1 = 1;
    self.type = markType;
    for (int j  = 0; j < 5; j++) {
        
        UIView *btnSubViewwh = [self.fatherview viewWithTag:100 + j];
        UIView *viewwh = (UIView *)[btnSubViewwh viewWithTag:201];
        UIButton *btnwh = (UIButton *)[btnSubViewwh viewWithTag:200];
        
        
        if (markType == j) {
            [btnwh setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            viewwh.hidden = NO;
            
        }else {
            [btnwh setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            viewwh.hidden = YES;
        }
    }
    if (self.type == 0) { //新品
        self.collectionView.hidden = NO;
        [self.collection.mj_header beginRefreshing];
    }else if (self.type == 1) {//热门
        self.collectionView.hidden = NO;
        [self.collection.mj_header beginRefreshing];
    }else if (self.type == 2) {//全部
        self.collectionView.hidden = NO;
        [self.collection.mj_header beginRefreshing];
    }else if (self.type == 3) {//评价
        self.viewModel.type = 3;
        self.collectionView.hidden = YES;
        [self.table.mj_header beginRefreshing];
    }else {//动态
        self.viewModel.type = 4;
        self.collectionView.hidden = YES;
        [self.table.mj_header beginRefreshing];
    }
    [self selemoren];
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
//    [self.collection reloadData];
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
