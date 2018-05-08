//
//  ShangjiaNewthreeTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShangjiaNewthreeTableViewCell.h"
#import "ShangjiaThreeCollectionViewCell.h"
@implementation ShangjiaNewthreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaThreeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaThreeCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Shangjiapinglun *)model{
    _model = model;
    
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = model.nickname;
    self.time.text = model.created_at;
    self.content.text = model.content;
    self.huifu.text = model.replay_content;
    self.star.value = model.order_score;
    self.star.tintColor = RGBA(255, 191, 86, 1);
    self.fenshu.text = [NSString stringWithFormat:@"%@分",S_Integer(model.order_score)];
    if (model.pictures.count == 0) {
        self.height.constant = 1;
    }else if (model.pictures.count > 0 && model.pictures.count < 4) {
        self.height.constant = 110;
    }else if (model.pictures.count > 3 && model.pictures.count < 7) {
        self.height.constant = 220;
    }else {
        self.height.constant = 330;
    }
    self.fuwuArray = [NSMutableArray arrayWithArray:model.pictures];
    [self.collection reloadData];
}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.fuwuArray.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectItemSubject sendNext:self.fuwuArray];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row > self.fuwuArray.count - 1) {
    //        return nil;
    //    }
    //重用cell
    ShangjiaThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaThreeCollectionViewCell" forIndexPath:indexPath];
    [cell.imagew sd_setImageWithUrl:self.fuwuArray[indexPath.row] placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 32) / 3 - 5,109);
    
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
