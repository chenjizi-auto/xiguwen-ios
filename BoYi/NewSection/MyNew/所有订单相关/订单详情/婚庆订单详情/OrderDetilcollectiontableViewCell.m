//
//  OrderDetilcollectiontableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OrderDetilcollectiontableViewCell.h"

@implementation OrderDetilcollectiontableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerNib:[UINib nibWithNibName:@"GuanzhuShangpinCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GuanzhuShangpinCellCollectionViewCell"];
}
#pragma mark - 点击事件
- (void)setModel:(OrderDetilModelNew *)model{
    _model = model;
    [self.collection reloadData];
}
- (void)setModelsc:(OrderDetilModelSC *)modelsc{
    _modelsc = modelsc;
    [self.collection reloadData];
}
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.modelsc) {
        return self.modelsc.youlike.count;
    }else {
        return self.model.youlike.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    GuanzhuShangpinCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuanzhuShangpinCellCollectionViewCell" forIndexPath:indexPath];
    if (self.modelsc) {
        if (self.modelsc.youlike[indexPath.row].shopimg.count > 0) {
            [cell.imagew sd_setImageWithUrl:self.modelsc.youlike[indexPath.row].shopimg[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
        }
        cell.name.text = self.modelsc.youlike[indexPath.row].shopname;
        cell.price.text = [NSString stringWithFormat:@"%@起",self.modelsc.youlike[indexPath.row].price];
        cell.yishounumber.text = [NSString stringWithFormat:@"已售 %ld",self.modelsc.youlike[indexPath.row].num];
        return cell;
    }else {
        if (self.model.youlike[indexPath.row].imglist.count > 0) {
            [cell.imagew sd_setImageWithUrl:self.model.youlike[indexPath.row].imglist[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
        }
        cell.name.text = self.model.youlike[indexPath.row].name;
        cell.price.text = [NSString stringWithFormat:@"%@起",self.model.youlike[indexPath.row].price];
        cell.yishounumber.text = [NSString stringWithFormat:@"已售 %ld",self.model.youlike[indexPath.row].num];
        return cell;
    }
    
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.modelsc) {
        [self.selectItemSubject sendNext:@(self.modelsc.youlike[indexPath.row].shopid)];
    }else {
        [self.selectItemSubject sendNext:@(self.model.youlike[indexPath.row].quotationid)];
    }
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 20)/2,183);
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
