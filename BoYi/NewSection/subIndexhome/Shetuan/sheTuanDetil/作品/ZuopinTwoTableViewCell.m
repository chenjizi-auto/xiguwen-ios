//
//  ZuopinTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ZuopinTwoTableViewCell.h"
#import "ZuopinNewCollectionViewCell.h"
@implementation ZuopinTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.Collection.delegate = self;
    self.Collection.dataSource = self;
    [self.Collection registerNib:[UINib nibWithNibName:@"ZuopinNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZuopinNewCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(shetuanZuppinModel *)model{
    _model = model;
    self.hotArray = [NSMutableArray arrayWithArray:model.chengyuan];
    [self.Collection reloadData];

}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ZuopinNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZuopinNewCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.hotArray[indexPath.row];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:@(self.hotArray[indexPath.row].id)];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 10)/2,220);
    
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
