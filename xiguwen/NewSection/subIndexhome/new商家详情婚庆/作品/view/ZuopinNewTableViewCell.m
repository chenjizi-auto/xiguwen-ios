//
//  ZuopinNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/20.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "ZuopinNewTableViewCell.h"
#import "ShangjiaTwoCollectionViewCell.h"
@implementation ZuopinNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaTwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaTwoCollectionViewCell"];
}
- (void)setFuwuArray:(NSMutableArray *)fuwuArray{
    _fuwuArray = [NSMutableArray array];
    _fuwuArray = fuwuArray;
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
    
    
    return _fuwuArray.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:_fuwuArray[indexPath.row]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    ShangjiaTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaTwoCollectionViewCell" forIndexPath:indexPath];
//    {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"ShangjiaTwoCollectionViewCell" owner:nil options:nil].firstObject;
//    }
    Zuopinnewfen *model = self.fuwuArray[indexPath.row];
    if ([model.type isEqualToString:@"sp"]) {
        cell.bofangImage.hidden = NO;
        [cell.imagew sd_setImageWithUrl:model.cover placeHolder:[UIImage imageNamed:@"占位图片"]];
        cell.name.text = model.title;
        cell.jianjie.text = @"";
    }else if ([model.type isEqualToString:@"al"]) {
        cell.bofangImage.hidden = YES;
        [cell.imagew sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
        cell.name.text = model.title;
        cell.jianjie.text = model.weddingdescribe;
    }else {
        cell.bofangImage.hidden = YES;
        [cell.imagew sd_setImageWithUrl:model.cover placeHolder:[UIImage imageNamed:@"占位图片"]];
        cell.name.text = model.name;
        cell.jianjie.text = model.synopsis;
    }
    cell.price.text = [NSString stringWithFormat:@"¥ %ld",model.weddingexpenses];
    cell.yishounumber.text = [NSString stringWithFormat:@"%ld",model.clicked];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth / 2 - 5,216);
    
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
