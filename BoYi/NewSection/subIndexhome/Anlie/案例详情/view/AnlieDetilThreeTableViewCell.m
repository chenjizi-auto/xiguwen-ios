//
//  AnlieDetilThreeTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/27.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieDetilThreeTableViewCell.h"
#import "ShangjiaTwoCollectionViewCell.h"
@implementation AnlieDetilThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaTwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaTwoCollectionViewCell"];
}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (void)setModel:(AnlieNewDetilModel *)model{
    _model = model;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.gdanli];
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.fuwuArray.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:self.fuwuArray[indexPath.row]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    //重用cell
    ShangjiaTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaTwoCollectionViewCell" forIndexPath:indexPath];
    [cell.imagew sd_setImageWithUrl:self.fuwuArray[indexPath.row].weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
    cell.name.text = self.fuwuArray[indexPath.row].title;
    cell.price.text = [NSString stringWithFormat:@"¥ %ld",self.fuwuArray[indexPath.row].weddingexpenses];
    cell.yishounumber.text = [NSString stringWithFormat:@"浏览量 %ld",self.fuwuArray[indexPath.row].clicked];
    if (![[NSString stringWithFormat:@"浏览量 %@",self.fuwuArray[indexPath.row].weddingdescribe] isBlankString]) {
        cell.jianjie.text = [NSString stringWithFormat:@"浏览量 %@",self.fuwuArray[indexPath.row].weddingdescribe];
    }
    
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth / 2) - 5,220);
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
