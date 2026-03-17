//
//  HunqinQuanTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinQuanTableViewCell.h"
#import "DianziQingjianCollectionViewCell.h"
@implementation HunqinQuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerNib:[UINib nibWithNibName:@"DianziQingjianCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell"];
}
- (void)setModel:(Hunqinnewarray *)model {
    _model = model;
    [self.headrImage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    if (model.follow == 1) {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
    }else {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];
    }
    self.time.text = model.create_ti;
    self.jianjie.text = model.content;

    self.jianjie.text = model.content;
    self.liulanNumber.text = [NSString stringWithFormat:@"%ld",model.pv];
    self.pinglunNumber.text = [NSString stringWithFormat:@"%ld",model.commentnum];
    self.dianzanNumber.text = [NSString stringWithFormat:@"%ld",model.zan];
    
    self.hotArray =  [NSMutableArray arrayWithArray: model.photourl];
    
    NSInteger zhangshu;
    if (self.hotArray.count == 0) {
        zhangshu = 0;
    }else if (self.hotArray.count > 0 && self.hotArray.count < 4) {
        zhangshu = 1;
    }else if (self.hotArray.count > 3 && self.hotArray.count < 7) {
        zhangshu = 2;
    }else {
        zhangshu = 3;
    }
    self.height.constant =  110 * zhangshu;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    PhotourlFaxian *model = self.hotArray[indexPath.row];
    //重用cell
    DianziQingjianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell" forIndexPath:indexPath];
    [cell.image sd_setImageWithUrl:model.photourl placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.clickImageSubject sendNext:@""];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 60)/3,110);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 10, 8);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}



- (RACSubject *)clickImageSubject {
    if (!_clickImageSubject) {
        _clickImageSubject = [RACSubject subject];
    }
    return _clickImageSubject;
}
@end
