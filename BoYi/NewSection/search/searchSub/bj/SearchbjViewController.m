//
//  SearchbjViewController.m
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SearchbjViewController.h"
#import "ShangjiaoneCollectionViewCell.h"
@interface SearchbjViewController (){
    NSInteger comprehensive,salesvolume;
    NSString *price;
}

@end

@implementation SearchbjViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self selemoren];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaoneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaoneCollectionViewCell"];
    
    self.collectionAddress.emptyDataSetDelegate = self;
    self.collectionAddress.emptyDataSetSource   = self;
    [self.collectionAddress reloadData];
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
    [dic setValue:@"fw" forKey:@"stype"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [dic setValue:@"成都市" forKey:@"city"];
    
    [[RequestManager sharedManager] requestUrl:URL_New_searchwu
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.dataBJ = [NSArray array];
                                               self.dataBJ = [Baojiashangjiafen mj_objectArrayWithKeyValuesArray:response[@"data"][@"baojia"]];
                                               [self.collectionAddress reloadData];
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
    
}


//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.dataBJ.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BaojiaDetilViewController *vc = [[BaojiaDetilViewController alloc] init];
    vc.baojiaid = self.dataBJ[indexPath.row].quotationid;
    [self pushToNextVCWithNextVC:vc];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ShangjiaoneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaoneCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataBJ[indexPath.row];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth / 2 - 10,183);
    
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
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 0;
    
}
#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"无数据 空状态";
    
    
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
    return self.dataBJ.count == 0  && self.dataBJ;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
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
