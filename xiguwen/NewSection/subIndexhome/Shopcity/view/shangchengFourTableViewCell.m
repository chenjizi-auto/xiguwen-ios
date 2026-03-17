//
//  shangchengFourTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangchengCollectionViewCell.h"
#import "shangchengFourTableViewCell.h"
@implementation shangchengFourTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.collection.delegate = self;
//    self.collection.dataSource = self;
//    [self.collection registerNib:[UINib nibWithNibName:@"ShangchengCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangchengCollectionViewCell"];
}
- (void)setModel:(Youlove *)model{
    _model = model;
    
    [self.imagew sd_setImageWithUrl:model.shopimg placeHolder:[UIImage imageNamed:@"占位图片"]];
    
    
    self.tiele.text = model.shopname;
    self.price.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.dianming.text = model.nickname;
    self.address.text = model.city;
    self.like.text = [NSString stringWithFormat:@"%ld人喜欢",model.follows];
}
#pragma mark - collection

////item个数
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    
//    return self.hotArray.count;
//    
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //重用cell
//    ShangchengCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangchengCollectionViewCell" forIndexPath:indexPath];
//    cell.name.text = @"12312";
//    return cell;
//}
//
////定义每个UICollectionViewCell 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(56,20);
//    
//}
////定义每个Section 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
//}
////每个section中不同的行之间的行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 5;
//}


@end
