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

static CGFloat const kRecommendationSideInset = 12.0;
static CGFloat const kRecommendationSpacing = 12.0;

- (CGFloat)recommendationItemWidth {
    return floor((ScreenWidth - kRecommendationSideInset * 2.0 - kRecommendationSpacing) / 2.0);
}

- (CGFloat)recommendationItemHeight {
    CGFloat width = [self recommendationItemWidth];
    return width * 7.0 / 12.0 + 90.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.hotCollection.delegate = self;
    self.hotCollection.dataSource = self;
    self.hotCollection.scrollEnabled = NO;
    self.hotCollection.backgroundColor = [UIColor clearColor];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.hotCollection.collectionViewLayout;
    layout.minimumLineSpacing = kRecommendationSpacing;
    layout.minimumInteritemSpacing = kRecommendationSpacing;
    layout.sectionInset = UIEdgeInsetsMake(0.0, kRecommendationSideInset, 0.0, kRecommendationSideInset);
    [self.hotCollection registerNib:[UINib nibWithNibName:@"TuijianNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TuijianNewCollectionViewCell"];
}

- (void)configModel:(NSArray<ShopCarTuiJian *> *)modelArray {
    self.dataArray = modelArray;
    NSInteger rowCount = MAX((NSInteger)((modelArray.count + 1) / 2), 1);
    CGFloat itemHeight = [self recommendationItemHeight];
    self.collectionHeight.constant = rowCount * itemHeight + MAX(rowCount - 1, 0) * kRecommendationSpacing;
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
    return self.dataArray.count;
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
    CGFloat width = [self recommendationItemWidth];
    CGFloat height = [self recommendationItemHeight];
    return CGSizeMake(width,height);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0, kRecommendationSideInset, 0.0, kRecommendationSideInset);
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kRecommendationSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kRecommendationSpacing;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
