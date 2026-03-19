//
//  ShangjiaIndexTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/19.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaIndexTableViewCell.h"
#import "ShangjiaoneCollectionViewCell.h"

static CGFloat const kShangjiaIndexHorizontalInset = 12.0;
static CGFloat const kShangjiaIndexItemSpacing = 10.0;
static CGFloat const kShangjiaIndexItemHeight = 183.0;

@implementation ShangjiaIndexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.collectionAddress.backgroundColor = [UIColor clearColor];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaoneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaoneCollectionViewCell"];
}
- (void)setModel:(NewShangjiaModel *)model {
    _model = model;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.baojia.baojia];
    NSInteger displayCount = MIN(self.fuwuArray.count, 4);
    NSInteger rows = displayCount == 0 ? 0 : (NSInteger)ceil(displayCount / 2.0);
    self.height.constant = rows == 0 ? 0.0f : rows * kShangjiaIndexItemHeight + MAX(rows - 1, 0) * kShangjiaIndexItemSpacing;
    
    self.baojianumber.text = [NSString stringWithFormat:@"商品报价（%ld）",model.baojia.zongshu];
    [self.collectionAddress reloadData];
    
}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//item个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.fuwuArray.count == 0 ? 0 : 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (self.fuwuArray.count > 4) {
        return 4;
    }else {
        return self.fuwuArray.count;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:self.fuwuArray[indexPath.row]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ShangjiaoneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaoneCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.fuwuArray[indexPath.row];
    
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat totalWidth = CGRectGetWidth(collectionView.bounds) - kShangjiaIndexHorizontalInset * 2 - kShangjiaIndexItemSpacing;
    return CGSizeMake(floor(totalWidth / 2.0), kShangjiaIndexItemHeight);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, kShangjiaIndexHorizontalInset, 0, kShangjiaIndexHorizontalInset);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kShangjiaIndexItemSpacing;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return kShangjiaIndexItemSpacing;
    
}

@end
