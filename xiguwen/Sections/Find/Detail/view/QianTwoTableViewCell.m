//
//  QianTwoTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "QianTwoTableViewCell.h"

@implementation QianTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _collection.delegate = self;
    _collection.dataSource = self;
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collection registerNib:[UINib nibWithNibName:@"ZuoPinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZuoPinCollectionViewCell"];
}

- (void)setDataArrayTP:(NSMutableArray<Rows *> *)dataArrayTP{
    _dataArrayTP = dataArrayTP;
    [self.collection reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArrayTP.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    ZuoPinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZuoPinCollectionViewCell" forIndexPath:indexPath];
    
    cell.model = self.dataArrayTP[indexPath.row];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //    [self.selectItemSubject sendNext:self.model.children[indexPath.row]];
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenWidth,180);

    
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

@end
