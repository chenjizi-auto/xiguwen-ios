//
//  DongtaiNewViewTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/19.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "DongtaiNewViewTableViewCell.h"
#import "QuantuCollectionViewCell.h"
@implementation DongtaiNewViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerNib:[UINib nibWithNibName:@"QuantuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"QuantuCollectionViewCell"];
}
- (void)setModel:(Dongtaiarray *)model {
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [[NSString stringWithFormat:@"%@",model.nickname] isBlankString] ? @"姓名" : model.nickname;
    self.time.text = model.create_ti;
    self.centnet.text = model.content;
    self.zhiwei.text = @"主持人未空";
    self.tuandui.text = [NSString stringWithFormat:@"%@",model.theteam];
    
    self.liulan.text = [NSString stringWithFormat:@"%ld",model.pv];
    self.pinlun.text = [NSString stringWithFormat:@"%ld",model.commentnum];
    self.dianzan.text = [NSString stringWithFormat:@"%ld",model.zan];
    self.dianzanImage.image = [UIImage imageNamed:model.dianzan == 1 ? @"点赞":@"未点赞"];
    if (model.photourl.count == 0) {
        self.height.constant = 1;
    }else if (model.photourl.count > 0 && model.photourl.count < 4) {
        self.height.constant = 110;
    }else if (model.photourl.count > 3 && model.photourl.count < 7) {
        self.height.constant = 220;
    }else {
        self.height.constant = 330;
    }
    self.fuwuArray = [NSMutableArray arrayWithArray:model.photourl];
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
    [self.selectItemSubject sendNext:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    QuantuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuantuCollectionViewCell" forIndexPath:indexPath];
    [cell.imagew sd_setImageWithUrl:self.fuwuArray[indexPath.row].photourl placeHolder:[UIImage imageNamed:@"占位图片"]];
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
