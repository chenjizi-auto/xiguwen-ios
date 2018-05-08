//
//  CarTuijianTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CarTuijianTableViewCell.h"
#import "TuijianNewCollectionViewCell.h"
@implementation CarTuijianTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hotCollection.delegate = self;
    self.hotCollection.dataSource = self;
    self.hotCollection.scrollEnabled = NO;
    [self.hotCollection registerNib:[UINib nibWithNibName:@"TuijianNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TuijianNewCollectionViewCell"];
}

- (void)configModel:(NSArray<ShopCarTuiJian *> *)modelArray {
    self.dataArray = modelArray;
    self.collectionHeight.constant = 219 * 4;
    [self layoutIfNeeded];
    [self.hotCollection reloadData];
}
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}

#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
    //    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    TuijianNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TuijianNewCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (ScreenWidth - 10)/2;
    CGFloat height = width * 7 / 12 + 90;
    return CGSizeMake(width,height);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 10, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
