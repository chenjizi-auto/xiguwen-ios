//
//  shangpinTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/4/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "shangpinTwoTableViewCell.h"
#import "SPneCollectionViewCell.h"
@implementation shangpinTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"SPneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SPneCollectionViewCell"];
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (void)setModel:(shangpinnewModel *)model{
    _model = model;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.model.tebietuijian.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:self.model.tebietuijian[indexPath.row]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    SPneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPneCollectionViewCell" forIndexPath:indexPath];
    ;
    [cell.imagew sd_setImageWithUrl:self.model.tebietuijian[indexPath.row].shopimg[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    cell.name.text = self.model.tebietuijian[indexPath.row].shopname;
    cell.price.text = [NSString stringWithFormat:@" %@起  ",self.model.tebietuijian[indexPath.row].price];
    cell.yishounumber.text = [NSString stringWithFormat:@"%ld  ",self.model.tebietuijian[indexPath.row].num];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth / 2) - 5,180);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 5;
    
}
@end
