//
//  shangpinOneTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/4/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "shangpinOneTableViewCell.h"
#import "ShangjiaThreeCollectionViewCell.h"

@implementation shangpinOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaThreeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaThreeCollectionViewCell"];
}
#pragma mark - collection

- (void)setModel:(shangpinnewModel *)model{
    _model = model;

    [self.collectionAddress reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.model) {
        return 1;
    }else {
        return 0;
    }
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.model.shangpin.shopimg.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [self.selectItemSubject sendNext:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ShangjiaThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaThreeCollectionViewCell" forIndexPath:indexPath];
//    [cell.imagew sd_setImageWithUrl:self.model.shangpin.shopimg[indexPath.row] placeHolder:[UIImage imageNamed:@"占位图片"]];
    /*---- 新增部分 -----*/
    cell.imagew.frame = self.model.shangpin.zl_imgviews[indexPath.row].frame;
    cell.imagew.image = self.model.shangpin.zl_imgviews[indexPath.row].image;
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth ,self.model.shangpin.zl_imgviews[indexPath.row].frame.size.height);
    
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
