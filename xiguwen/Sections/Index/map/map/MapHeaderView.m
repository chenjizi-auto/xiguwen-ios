//
//  MapHeaderView.m
//  BoYi
//
//  Created by apple on 2017/8/17.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MapHeaderView.h"
#import "MapCollectionViewCell.h"
#import "NewmapModel.h"
@implementation MapHeaderView

- (CGFloat)cw_collectionHorizontalInset {
    return 5.0;
}

- (CGFloat)cw_collectionItemSpacing {
    return 10.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _collection.delegate = self;
    _collection.dataSource = self;
    self.collection.translatesAutoresizingMaskIntoConstraints = YES;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collection.collectionViewLayout;
    if ([layout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        layout.sectionInset = UIEdgeInsetsMake(5, [self cw_collectionHorizontalInset], 5, [self cw_collectionHorizontalInset]);
        layout.minimumInteritemSpacing = [self cw_collectionItemSpacing];
        layout.minimumLineSpacing = [self cw_collectionItemSpacing];
        if (@available(iOS 11.0, *)) {
            layout.sectionInsetReference = UICollectionViewFlowLayoutSectionInsetFromContentInset;
        }
    }
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collection registerNib:[UINib nibWithNibName:@"MapCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MapCollectionViewCell"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat collectionTop = 48.0;
    CGFloat collectionBottom = 10.0;
    self.collection.frame = CGRectMake(13.0,
                                       collectionTop,
                                       CGRectGetWidth(self.bounds) - 26.0,
                                       MAX(CGRectGetHeight(self.bounds) - collectionTop - collectionBottom, 0));
    [self.collection.collectionViewLayout invalidateLayout];
}

- (void)refreshData:(NSMutableArray *)array{
    self.array = array;
    [self.collection.collectionViewLayout invalidateLayout];
    [_collection reloadData];
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    MapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MapCollectionViewCell" forIndexPath:indexPath];
    NewmapModel *model = self.array[indexPath.row];
    cell.city.text = model.name;
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    [self.gotoNextVc sendNext:self.array[indexPath.row]];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat columns = 3.0;
    CGFloat horizontalInset = [self cw_collectionHorizontalInset];
    CGFloat spacing = [self cw_collectionItemSpacing];
    CGFloat availableWidth = CGRectGetWidth(collectionView.bounds) - horizontalInset * 2.0 - spacing * (columns - 1.0);
    CGFloat itemWidth = floor(availableWidth / columns);
    return CGSizeMake(MAX(itemWidth, 0), 34.0);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat horizontalInset = [self cw_collectionHorizontalInset];
    return UIEdgeInsetsMake(5, horizontalInset, 5, horizontalInset);//分别为上、左、下、右
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self cw_collectionItemSpacing];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self cw_collectionItemSpacing];
}


@end
