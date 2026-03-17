//
//  BoyiShiPinViewController.m
//  BoYi
//
//  Created by heng on 2018/1/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "BoyiShiPinViewController.h"
#import "BoyiShiPinViewModel.h"
#import "BoyiShiPinModel.h"
#import "BoyiShiPingType.h"
#import "BoyiShiPingCellViewsModel.h"
#import "BoyiShiPinCollectionViewCell.h"
#import "BoyiShipinHeaderView.h"
#import "BOyiShiPinMoreViewController.h"
#import "BoyiShiPinDetailsViewController.h"
@interface BoyiShiPinViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic)BoyiShiPingCellViewsModel *viewModel;

@property(nonatomic,strong)BoyiShiPingType * typeView;

@property(nonatomic,strong)UICollectionView * collect;
@end

@implementation BoyiShiPinViewController
{
    @private
    NSMutableArray<BoyiShiPinModel*> *tuijian;
    NSMutableArray<BoyiShiPinModel*> *zuire;
    NSMutableArray<BoyiShiPinModel*> *zuixin;
    NSMutableArray<BoyShiPingTypeMode*> *typeArray;
    
    /**
     * 请求的参数
     */
    NSInteger  type;//视频类别 id
    NSString *name;//视频名称
    NSInteger isvipsee;//是否是vip查看 1 是 0 不是
    NSInteger dispaly;//是否显示1 显示 0 不显示
    
    BOOL isfresh;//判断是否是刷新
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"";
    name = @"";
    isfresh = YES;
    [self request:nil];
    
    __weak typeof(self)weakSelf = self;
    [self.viewModel.subject subscribeNext:^(id  _Nullable x) {
        [weakSelf handleData:x];
    }];
}

-(void)request:(NSDictionary*)dic{
    [self.viewModel.command execute:dic];
    
    [_collect.mj_header endRefreshing];
    [_collect.mj_footer endRefreshing];
}

-(void)handleData:(id)data{
    
      [({if(!tuijian) tuijian = [[NSMutableArray alloc] init];
          if (isfresh) [tuijian removeAllObjects];
        tuijian;
    }) addObjectsFromArray:[BoyiShiPinModel mj_objectArrayWithKeyValuesArray:data[@"tuijian"]]];

    [({if(!zuire) zuire = [[NSMutableArray alloc] init];
         if (isfresh) [zuire removeAllObjects];
        zuire;
    }) addObjectsFromArray:[BoyiShiPinModel mj_objectArrayWithKeyValuesArray:data[@"zuire"]]];
    
    [({if(!zuixin) zuixin = [[NSMutableArray alloc] init];
        if (isfresh) [zuixin removeAllObjects];
        zuixin;
    }) addObjectsFromArray:[BoyiShiPinModel mj_objectArrayWithKeyValuesArray:data[@"zuixin"]]];
    
    if (!typeArray) {
        typeArray =  [BoyShiPingTypeMode mj_objectArrayWithKeyValuesArray:data[@"type"]];
        self.typeView.frame = CGRectMake(0, 0,self.view.bounds.size.width, 28*(typeArray.count/4+1)+16*(typeArray.count/4+2)+ 50);
        type = typeArray.firstObject.id;
        [self.typeView SHIpingTypeNumber:typeArray];
        
        [self collect];
    }
    [_collect reloadData];
}


- (BoyiShiPingType *)typeView{
    if (!_typeView) {
        _typeView = [[BoyiShiPingType alloc]init];
        [self.view addSubview:_typeView];
      __weak typeof(self)weakSelf = self;
        /**
         * 类别选择事件
         */
        _typeView.Mblock = ^(UIButton *btn) {
            type = btn.tag - 1000;
            isfresh = YES;
            [weakSelf request:@{@"p":@(0),@"type":@(type),@"name":name}];
        };
        
        /**
         * 搜索事件
         */
        _typeView.searchBlock = ^(NSString *text) {
            name = text;
            isfresh = YES;
             [weakSelf request:@{@"p":@(0),@"type":@(type),@"name":name}];
        };
    }
    return _typeView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_typeView CanBegcomFouce];
}

//初始化viewModel
- (BoyiShiPingCellViewsModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BoyiShiPingCellViewsModel alloc] init];
    }
    return _viewModel;
}


#pragma ---------------  UICollectionView -------------------
- (UICollectionView *)collect{
    if (!_collect) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((ScreenWidth - 15)/2.0, (ScreenWidth - 15)/2.0);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_typeView.frame), self.view.frame.size.width, self.view.frame.size.height-_typeView.frame.size.height) collectionViewLayout:layout];
        _collect.backgroundColor = [UIColor whiteColor];
        _collect.dataSource = self;
        _collect.delegate = self;
        [_collect registerNib:[UINib nibWithNibName:@"BoyiShiPinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

        [_collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        
        [_collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        
        __weak typeof(self)weakSelf = self;
       __block NSInteger p = 0;
        
        _collect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            p = 0;
            name = @"";
            [weakSelf request:@{@"p":@(p),@"type":@(type),@"name":name}];
            isfresh = YES;
        }];
        
        _collect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf request:@{@"p":@(p),@"type":@(type),@"name":name}];
            p++;
            isfresh = NO;
        }];
        [self.view addSubview:_collect];
    }
    return _collect;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
    switch (section) {
        case 0:
            return  tuijian.count;
            break;
        case 1:
            return  zuire.count;
            break;
        case 2:
            return  zuixin.count;
            break;
        default:
            break;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BoyiShiPinCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BoyiShiPinCollectionViewCell" owner:self options:nil].lastObject;
    }
    [cell data:indexPath.section==0?tuijian[indexPath.row]:indexPath.section==1?zuire[indexPath.row]:zuixin[indexPath.row]];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        
        for(UIView * view in head.subviews){
            [view removeFromSuperview];
        }
        BoyiShipinHeaderView * vi = [[NSBundle mainBundle] loadNibNamed:@"BoyiShipinHeaderView" owner:self options:nil].lastObject;
        vi.frame = CGRectMake(0, 0, vi.frame.size.width,  vi.frame.size.height);
        [vi headText:indexPath];
        __weak typeof(self) weakSelf = self;
        /**
         * 更多的点击事件
         */
        vi.Mblock = ^(NSString *text) {
            BOyiShiPinMoreViewController * vc = [[BOyiShiPinMoreViewController alloc]init];
            vc.titletex = text;
            vc.type = type;
            vc.musicOrVideo = VIDEO;
            [((UIViewController*)weakSelf.objc).navigationController pushViewController:vc animated:YES];
        };
        [head addSubview:vi];

        return head;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = RGBA(236, 236, 236, 1);
        return footer;
    }
    
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){ScreenWidth,44};
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){ScreenWidth,section!=2?10:0};
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BoyiShiPinDetailsViewController*vc = [[BoyiShiPinDetailsViewController alloc]init];
    vc.model=indexPath.section==0?tuijian[indexPath.row]:indexPath.section==1?zuixin[indexPath.row]:zuire[indexPath.row];
    [((UIViewController*)self.objc).navigationController pushViewController:vc animated:YES];
}
@end
