//
//  NewTwoTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewTwoTableViewCell.h"
#import "MapCollectionViewCell.h"
@implementation NewTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"MapCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MapCollectionViewCell"];
    self.collectionAddress.showsVerticalScrollIndicator = FALSE;
    self.collectionAddress.showsHorizontalScrollIndicator = FALSE;
    self.fuwuArray = [NSMutableArray array];
}

- (void)setFuwuArray:(NSMutableArray *)fuwuArray{
    
    _fuwuArray = fuwuArray;
    [self.collectionAddress reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fuwuArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    MapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MapCollectionViewCell" forIndexPath:indexPath];
    cell.city.text = self.fuwuArray[indexPath.row];
    
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (ScreenWidth == 320) {
        
        return CGSizeMake(80,30);
        
    }else if (ScreenWidth == 375) {
        
        return CGSizeMake(90,30);
        
    }else {
        return CGSizeMake(100,30);
    }
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


@end
