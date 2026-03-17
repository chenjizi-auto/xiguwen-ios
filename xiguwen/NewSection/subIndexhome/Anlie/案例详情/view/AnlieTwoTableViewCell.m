//
//  AnlieTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/27.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieTwoTableViewCell.h"
#import "ShangjiaFourCollectionViewCell.h"

@implementation AnlieTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"ShangjiaFourCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShangjiaFourCollectionViewCell"];
}
#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (void)setModel:(AnlieNewDetilModel *)model{
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.user.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [[NSString stringWithFormat:@"%@",model.user.nickname] isBlankString] ? @"姓名" : model.user.nickname;
    self.pinlunshu.text = [NSString stringWithFormat:@"%ld",model.user.evaluate];
    self.haopinlv.text = [NSString stringWithFormat:@"%ld",model.user.goodscore];
    self.fensishu.text = [NSString stringWithFormat:@"%ld",model.user.fans];
    self.fuwuArray = [NSMutableArray arrayWithArray:model.team];
    
    
    // 诚信 平台 学院
    if (model.user.shiming) {
        self.renzhengImage1.hidden = NO;
        self.renzhengImage1.image = [UIImage imageNamed:@"实名认证1"];
    }else {
        self.renzhengImage1.hidden = YES;
    }
    if (model.user.platform == 1) {
        self.renzhengImage2.hidden = NO;
        self.renzhengImage2.image = [UIImage imageNamed:@"平台认证1"];
    }else {
        self.renzhengImage2.hidden = YES;
    }
    if (model.user.sincerity) {
        self.renzhengImage3.hidden = NO;
        self.renzhengImage3.image = [UIImage imageNamed:@"诚信认证1"];
    }else {
        self.renzhengImage3.hidden = YES;
    }
   
    if (model.user.xueyuan == 6) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh6"];
    }else if (model.user.xueyuan == 7) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh7"];
    }else if (model.user.xueyuan == 8) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh8"];
    }else if (model.user.xueyuan == 9) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh9"];
    }else if (model.user.xueyuan == 10) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh10"];
    }else if (model.user.xueyuan == 11) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh11"];
    }else if (model.user.xueyuan == 12) {
        self.renzhengImage4.image = [UIImage imageNamed:@"wh12"];
    }else if (model.user.xueyuan == 13) {
        self.renzhengImage4.image = [UIImage imageNamed:@"1星"];
    }else if (model.user.xueyuan == 14) {
        self.renzhengImage4.image = [UIImage imageNamed:@"2星"];
    }else if (model.user.xueyuan == 15) {
        self.renzhengImage4.image = [UIImage imageNamed:@"3星"];
    }else if (model.user.xueyuan == 16) {
        self.renzhengImage4.image = [UIImage imageNamed:@"4星"];
    }else if (model.user.xueyuan == 17) {
        self.renzhengImage4.image = [UIImage imageNamed:@"5星"];
    }else if (model.user.xueyuan == 18) {
        self.renzhengImage4.image = [UIImage imageNamed:@"6星"];
    }else if (model.user.xueyuan == 19) {
        self.renzhengImage4.image = [UIImage imageNamed:@"7星"];
    }else {
        self.renzhengImage4.hidden = YES;
    }
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
    ShangjiaFourCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangjiaFourCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.fuwuArray[indexPath.row];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth / 3 - 5,143);
    
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
