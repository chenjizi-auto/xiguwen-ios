//
//  BaojiaDetilTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/23.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "BaojiaDetilTwoTableViewCell.h"
#import "BaojiaNewCollectionViewCell.h"
@implementation BaojiaDetilTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"BaojiaNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BaojiaNewCollectionViewCell"];
}
- (void)setModel:(BaojiaDetilModel *)model {
    _model = model;
    self.title.text = model.baojia.content;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.baojia.imglist];
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
    BaojiaNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaojiaNewCollectionViewCell" forIndexPath:indexPath];
    //    cell.city.text = self.fuwuArray[indexPath.row];
    [cell.iamgew sd_setImageWithUrl:self.fuwuArray[indexPath.row] placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth,250);
    
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
    return 0;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
