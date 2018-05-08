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


- (void)awakeFromNib {
    [super awakeFromNib];
    _collection.delegate = self;
    _collection.dataSource = self;
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collection registerNib:[UINib nibWithNibName:@"MapCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MapCollectionViewCell"];
}
- (void)refreshData:(NSMutableArray *)array{
    self.array = array;
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
    
    return CGSizeMake((ScreenWidth - 16 - 20 - 40) / 3,34);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}



@end
