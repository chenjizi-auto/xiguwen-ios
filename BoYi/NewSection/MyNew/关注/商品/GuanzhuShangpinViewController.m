//
//  GuanzhuShangpinViewController.m
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanzhuShangpinViewController.h"
#import "GuanzhuShangpinCellCollectionViewCell.h"
#import "ShangpinNewDetilViewController.h"
@interface GuanzhuShangpinViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation GuanzhuShangpinViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerNib:[UINib nibWithNibName:@"GuanzhuShangpinCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GuanzhuShangpinCellCollectionViewCell"];
    [self getData];
    
}
- (void)getData{
    [[RequestManager sharedManager] requestUrl:URL_New_myguanzhu
                                        method:POST
                                        loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
												 @"type":@"4",
												 @"rows":@(100)}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.dataArray = [[NSMutableArray alloc] init];
                                        [self.dataArray addObjectsFromArray:[ShangpingGuanzhuModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"shangping"]]];
                                               [self.collection reloadData];
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           

                                           
                                       }];
}

#pragma mark - 点击事件

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    GuanzhuShangpinCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuanzhuShangpinCellCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
	ShangpingGuanzhuModel *model = self.dataArray[indexPath.row];
	vc.shangpinID = model.shopid;
	[self pushToNextVCWithNextVC:vc];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 20)/2,183);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}




@end
