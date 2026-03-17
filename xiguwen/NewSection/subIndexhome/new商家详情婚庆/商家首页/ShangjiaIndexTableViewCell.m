//
//  ShangjiaIndexTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/19.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaIndexTableViewCell.h"
#import "ShangjiaoneCollectionViewCell.h"
@implementation ShangjiaIndexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaoneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaoneCollectionViewCell"];
}
- (void)setModel:(NewShangjiaModel *)model {
    _model = model;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.baojia.baojia];
    if (self.fuwuArray.count > 0 && self.fuwuArray.count < 3) {
        self.height.constant = 183;
    }
    if (self.fuwuArray.count > 2) {
        self.height.constant = 183 * 2;
    }
    
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
    return CGSizeMake(ScreenWidth / 2 - 5,183);
    
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

