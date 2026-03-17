//
//  NewFiveTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewFiveTableViewCell.h"

@implementation NewFiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.zuopinCollection.delegate = self;
    self.zuopinCollection.dataSource = self;
    [self.zuopinCollection registerNib:[UINib nibWithNibName:@"ZuoPinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZuoPinCollectionViewCell"];
    self.zuopinCollection.showsVerticalScrollIndicator = FALSE;
    self.zuopinCollection.showsHorizontalScrollIndicator = FALSE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(peopleDetailModel *)model{
    _model = model;
    [self.zuopinCollection reloadData];
}
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.exampleList.count;;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ZuoPinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZuoPinCollectionViewCell" forIndexPath:indexPath];
    
    [cell.image sd_setImageWithUrl:ImageAppendURL(self.model.exampleList[indexPath.row].imgUrl) placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
    
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    [self.selectItemSubject sendNext:self.model.exampleList[indexPath.row]];
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 30) / 2,130);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}



@end
