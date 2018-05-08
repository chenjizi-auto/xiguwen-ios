//
//  ShangjianewTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjianewTwoTableViewCell.h"
#import "ShangjiaTwoCollectionViewCell.h"
@implementation ShangjianewTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaTwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaTwoCollectionViewCell"];
}
- (void)setModel:(NewShangjiaModel *)model {
    _model = model;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.zuoping.zuopin];
    if (self.fuwuArray.count > 0 && self.fuwuArray.count < 3) {
        self.height.constant = 216;
    }
    if (self.fuwuArray.count > 3) {
        self.height.constant = 432;
    }
    
    self.zuopinumber.text = [NSString stringWithFormat:@"作品案例（%ld）",model.zuoping.zongshu];
    self.pingjiaNumber.text = [NSString stringWithFormat:@"用户评价（%ld）",model.zuoping.zongshu];
    [self.collectionAddress reloadData];
    
}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//item个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.fuwuArray.count == 0 ? 0 : 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    if (self.fuwuArray.count > 4) {
        return 4;
    }else {
        return self.fuwuArray.count;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:self.fuwuArray[indexPath.row]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row > self.fuwuArray.count - 1) {
    //        return nil;
    //    }
    //重用cell
    ShangjiaTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaTwoCollectionViewCell" forIndexPath:indexPath];
  
    Zuopinnewfen *model = self.fuwuArray[indexPath.row];
    if ([model.type isEqualToString:@"sp"]) {
        [cell.imagew sd_setImageWithUrl:model.cover placeHolder:[UIImage imageNamed:@"占位图片"]];
        cell.name.text = model.title;
        cell.jianjie.text = @"";
    }else if ([model.type isEqualToString:@"al"]) {
        [cell.imagew sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
        cell.name.text = model.title;
        cell.jianjie.text = model.weddingdescribe;
    }else {
        [cell.imagew sd_setImageWithUrl:model.cover placeHolder:[UIImage imageNamed:@"占位图片"]];
        cell.name.text = model.name;
        cell.jianjie.text = model.synopsis;
    }
    cell.price.text = [NSString stringWithFormat:@"¥ %ld",model.weddingexpenses];
    cell.yishounumber.text = [NSString stringWithFormat:@"%ld",model.clicked];
    
    
    
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth / 2 - 5,216);
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
