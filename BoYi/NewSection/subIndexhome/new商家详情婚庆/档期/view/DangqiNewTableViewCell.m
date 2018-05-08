//
//  DangqiNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/19.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "DangqiNewTableViewCell.h"
#import "DangqinewCollectionViewCell.h"
@implementation DangqiNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"DangqinewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DangqinewCollectionViewCell"];
  
}
- (void)setModel:(Dangqinnewarray *)model{
    _model = model;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.dangqi];
    [self.collectionAddress reloadData];
    
}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.fuwuArray.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    DangqinewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DangqinewCollectionViewCell" forIndexPath:indexPath];
//    cell.day.text = [[NSString stringWithFormat:@"%@日",self.fuwuArray[indexPath.row].date] substringFromIndex:8];
    cell.day.text = [NSString stringWithFormat:@"%@",self.fuwuArray[indexPath.row].date];
    cell.shangOrxia.text = self.fuwuArray[indexPath.row].timeslot;
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 32 - 30) /7 ,45);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 10, 5);//分别为上、左、下、右
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
