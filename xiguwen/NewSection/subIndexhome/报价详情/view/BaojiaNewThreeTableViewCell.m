//
//  BaojiaNewThreeTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/23.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "BaojiaNewThreeTableViewCell.h"
#import "ShangjiaoneCollectionViewCell.h"
@implementation BaojiaNewThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaoneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaoneCollectionViewCell"];
}
- (void)setModel:(BaojiaDetilModel *)model {
    _model = model;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.youlike];
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
    [self.selectItemSubject sendNext:self.fuwuArray[indexPath.row]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShangjiaoneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaoneCollectionViewCell" forIndexPath:indexPath];
    Youlikebaojia *model = self.fuwuArray[indexPath.row];
    if (model.imglist.count > 0) {
        [cell.imagew sd_setImageWithUrl:model.imglist[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    }
    cell.name.text = model.name;
    cell.price.text = [NSString stringWithFormat:@"%@起",model.price];
    cell.yishounumber.text = [NSString stringWithFormat:@"已售 %ld",model.num];
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
