//
//  BoyiShiPinTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "BoyiShiPinTableViewCell.h"
#import "BoyiShiPinCollectionViewCell.h"
@implementation BoyiShiPinTableViewCell


- (void)setModel:(BoyiShiPinModel *)model {
    _model = model;
}



- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.hotCollection.delegate = self;
    self.hotCollection.dataSource = self;
    [self.hotCollection registerNib:[UINib nibWithNibName:@"BoyiShiPinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BoyiShiPinCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
    //    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    BoyiShiPinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoyiShiPinCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:@(indexPath.row)];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 16) / 2 - 5,173);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 5);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
@end
