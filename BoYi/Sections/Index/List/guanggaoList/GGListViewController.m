//
//  GGListViewController.m
//  BoYi
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "GGListViewController.h"
#import "GGListCollectionViewCell.h"
#import "BannerWebViewController.h"
#import "NewPeopleDetilViewController.h"
@interface GGListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation GGListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleName;
    [self addPopBackBtn];
    
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.emptyDataSetDelegate = self;
    _collection.emptyDataSetSource   = self;
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collection registerNib:[UINib nibWithNibName:@"GGListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GGListCollectionViewCell"];
    [self getdata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getdata{
    [[RequestManager sharedManager] requestUrl:URL_sanjiGG
                                        method:POST
                                        loding:@""
                                           dic:@{@"parentId":self.parentId}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([NSStringFormatter(response[@"status"]) integerValue] == 200 ) {
                                               self.dataArray = [[NSMutableArray alloc] init];
                                               [self.dataArray addObjectsFromArray:[EsarrayqweQWR mj_objectArrayWithKeyValuesArray:response[@"r"]]];
                                               
                                               [self.collection reloadData];
                                           }
                                           [NavigateManager hiddenLoadingMessage];

                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager hiddenLoadingMessage];
                                           
                                       }];
}


//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    GGListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GGListCollectionViewCell" forIndexPath:indexPath];
    EsarrayqweQWR *model = self.dataArray[indexPath.row];
    cell.name.text = model.name;
    [cell.image sd_setImageWithURL:URL(String(ImageHomeURL,model.imgUrl))];
    
    
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EsarrayqweQWR *model = self.dataArray[indexPath.row];
    
    if (![NSStringFormatter(model.entityId) isBlankString]) {//详情1
        
        NewPeopleDetilViewController *people = [[NewPeopleDetilViewController alloc] init];
        people.userId = model.entityId;
        [self pushToNextVCWithNextVC:people];
        
        return;
    }
    if ([NSStringFormatter(model.url) isEqualToString:@"#"]) {//内部
       
        BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
        bannerweb.hidesBottomBarWhenPushed = YES;
        bannerweb.urlString = NSStringFormatter(model.descn);
        bannerweb.name= NSStringFormatter(model.name);
        [self pushToNextVCWithNextVC:bannerweb];
    }
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   return CGSizeMake((ScreenWidth - 30 - 40)/ 2 , 170);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"暂无广告";
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = RGBA(202, 202, 202, 1);
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return IMAGE_NAME(@"无数据 空状态");
}





- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -49.0;
}

//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -49.0;
//}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.dataArray.count == 0  && self.dataArray;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}
@end
