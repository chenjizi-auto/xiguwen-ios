//
//  AllTpyeViewController.m
//  BoYi
//
//  Created by heng on 2017/12/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AllTpyeViewController.h"
#import "TypeCollectionViewCell.h"
#import "TypeViewCollectionReusableView.h"
#import "SearchshangjiaListViewController.h"
@interface AllTpyeViewController ()

@end

@implementation AllTpyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 94;
    }
    [self getData];
    self.navigationItem.title = @"全部分类";
    [self addPopBackBtn];
    [self.coection registerNib:[UINib nibWithNibName:@"TypeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TypeCollectionViewCell"];
    [self.coection registerClass:[TypeViewCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TypeViewCollectionReusableView"];
    self.coection.bounces = NO;
    self.coection.showsVerticalScrollIndicator = FALSE;
    self.coection.showsHorizontalScrollIndicator = FALSE;
    
}

-(void)getData{
    NSString *url;
    if (self.isHunqin == 1) {
        url = URL_New_allfenleilist;
    }else {
        url = URL_New_allfenleilistSC;
    }
    [[RequestManager sharedManager] requestUrl:url
                                        method:POST
                                        loding:nil
                                           dic:nil
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               //分类数据处理
                                               self.dataArray = [Alltypearray mj_objectArrayWithKeyValuesArray:response[@"data"]];
                                               [self.coection reloadData];
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           
                                           
                                       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSArray *array = [[NSArray alloc] init];
    array = self.dataArray[section].children;
    return array.count;
    
}
//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth - 32,47);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //从缓存中获取 Headercell
    TypeViewCollectionReusableView *header =nil;
    if (kind == UICollectionElementKindSectionHeader){
        TypeViewCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TypeViewCollectionReusableView" forIndexPath:indexPath];
        
        headerView.titleLabel.text = self.dataArray[indexPath.section].wapname;
        [headerView.image sd_setImageWithUrl:self.dataArray[indexPath.section].wapimg placeHolder:[UIImage imageNamed:@"占位图片"]];
        header = headerView;
    }
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    //重用cell
    TypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeCollectionViewCell" forIndexPath:indexPath];
    ChildrenAllType *model = self.dataArray[indexPath.section].children[indexPath.row];
    if (![[NSString stringWithFormat:@"%@",model.wapname] isBlankString]) {
        cell.name.text = model.wapname;
    }
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ChildrenAllType *model = self.dataArray[indexPath.section].children[indexPath.row];
    
    SearchshangjiaListViewController *anlist = [[SearchshangjiaListViewController alloc] init];
    anlist.children = self.dataArray[indexPath.section].children;
    anlist.typeFenleiguolai = model.id;
    anlist.titlew = model.wapname;
    [self pushToNextVCWithNextVC:anlist];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 32)/ 4,40);
    
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
@end
