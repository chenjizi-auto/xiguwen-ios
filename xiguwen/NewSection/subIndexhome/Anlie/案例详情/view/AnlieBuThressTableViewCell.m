//
//  AnlieBuThressTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AnlieBuThressTableViewCell.h"
#import "ShangjiaThreeCollectionViewCell.h"
@implementation AnlieBuThressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.coection.delegate = self;
    self.coection.dataSource = self;
    [self.coection registerNib:[UINib nibWithNibName:@"ShangjiaThreeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaThreeCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Pinglunanlie *)model{
    _model = model;
    self.name.text = model.name;
    [self.headerimage sd_setImageWithUrl:model.touxiang placeHolder:[UIImage imageNamed:@"头像"]];
    self.time.text = model.ssj;
    self.fenshu.text = [NSString stringWithFormat:@"%ld分",model.pingfen];
    self.starview.value = model.pingfen;
    self.jianjie.text = model.comment;
    self.fuwuArray = [NSMutableArray arrayWithArray:model.commphoto];
    
    NSInteger zhangshu;
    if (self.fuwuArray.count == 0) {
        zhangshu = 0;
    }else if (self.fuwuArray.count > 0 && self.fuwuArray.count < 4) {
        zhangshu = 1;
    }else if (self.fuwuArray.count > 3 && self.fuwuArray.count < 7) {
        zhangshu = 2;
    }else {
        zhangshu = 3;
    }
    
    if (zhangshu == 0) {
        self.height.constant = 0;
    }else if (zhangshu == 1){
        self.height.constant = 100;
    }else {
        self.height.constant = 200;
    }
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.fuwuArray.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [self.selectItemSubject sendNext:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ShangjiaThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaThreeCollectionViewCell" forIndexPath:indexPath];
    [cell.imagew sd_setImageWithUrl:self.fuwuArray[indexPath.row] placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 32) / 3 - 5 ,100);
    
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
