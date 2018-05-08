//
//  DongtaiTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/13.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "DongtaiTableViewCell.h"
#import "DongtaiCollectionViewCell.h"
@implementation DongtaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hotCollection.delegate = self;
    self.hotCollection.dataSource = self;
    [self.hotCollection registerNib:[UINib nibWithNibName:@"DongtaiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DongtaiCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Dynamiclist *)model{
    _model = model;
    [self.headrimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [NSString stringWithFormat:@"%@",model.nickname];
//    self.zhiwei.text = [NSString stringWithFormat:@"%@",model.type];
    self.time.text = model.create_ti;
    self.content.text = [NSString stringWithFormat:@"%@",model.content];
    [self.liulanBtn setTitle:S_Integer(model.pv) forState:UIControlStateNormal];
    [self.pinglunBtn setTitle:S_Integer(model.pls) forState:UIControlStateNormal];
    [self.dianzanBtn setTitle:S_Integer(model.zan) forState:UIControlStateNormal];
    [self.isGunazhuBTn setImage:[UIImage imageNamed:model.follow == 1 ? @"取消关注" :@"加关注"] forState:UIControlStateNormal];
    self.hotArray = [NSMutableArray arrayWithArray:model.pics];
    [self.hotCollection reloadData];
}
#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    DongtaiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DongtaiCollectionViewCell" forIndexPath:indexPath];
    [cell.image sd_setImageWithUrl:self.hotArray[indexPath.row].photourl placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 60)/3,110);
    
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
@end
