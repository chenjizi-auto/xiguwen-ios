//
//  AnlieNewDetilTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/24.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieNewDetilTableViewCell.h"
#import "ShangjiaThreeCollectionViewCell.h"
@implementation AnlieNewDetilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaThreeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaThreeCollectionViewCell"];
}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (void)setModel:(Infoanlie *)model{
    _model = model;
    [self.fengmianImage sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.title.text = model.title;
    self.time.text = [NSString stringWithFormat:@"婚礼时间：%@",model.weddingtime];
    self.address.text = [NSString stringWithFormat:@"婚礼地点：%@",model.weddingplace];
    self.price.text = [NSString stringWithFormat:@"¥%ld",model.weddingexpenses];
    self.jianjie.text = model.weddingdescribe;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.photourl];
    [self.collectionAddress reloadData];
}


//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.fuwuArray.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [self.selectItemSubject sendNext:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ShangjiaThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaThreeCollectionViewCell" forIndexPath:indexPath];
    [cell.imagew sd_setImageWithUrl:self.fuwuArray[indexPath.row].photourl placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth ,240);
    
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
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 10;
    
}
@end
