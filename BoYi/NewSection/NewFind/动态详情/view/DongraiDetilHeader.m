//
//  DongraiDetilHeader.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "DongraiDetilHeader.h"
#import "DianziQingjianCollectionViewCell.h"
@implementation DongraiDetilHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.scrollEnabled = NO;
    [self.collection registerNib:[UINib nibWithNibName:@"DianziQingjianCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell"];
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}
- (RACSubject *)gotoNextVc1 {
    if (!_gotoNextVc1) {
        _gotoNextVc1 = [RACSubject subject];
    }
    return _gotoNextVc1;
}
- (RACSubject *)clickImageSubject {
    if (!_clickImageSubject) {
        _clickImageSubject = [RACSubject subject];
    }
    return _clickImageSubject;
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        
    }else if (sender.tag == 1) {
        self.pinglunNumber.textColor = MAINCOLOR;
        self.dianzanNumber.textColor = RGBA(137, 137, 137, 1);
        self.view1.hidden = NO;
        self.view2.hidden = YES;
    }else {
        self.pinglunNumber.textColor = RGBA(137, 137, 137, 1);
        self.dianzanNumber.textColor = MAINCOLOR;
        self.view1.hidden = YES;
        self.view2.hidden = NO;
    }
    [self.gotoNextVc sendNext:@(sender.tag)];
}
- (IBAction)guanzhu:(UIButton *)sender {
    [self.gotoNextVc1 sendNext:nil];
}


- (void)setModel:(DongtaiDetilModel *)model{
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    if (model.follow == 1) {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
    }else {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];
    }
    self.time.text = model.create_ti;
    self.jianjie.text = model.content;

    self.pinglunNumber.text = [NSString stringWithFormat:@"评论 %ld",model.commentnum];
    self.dianzanNumber.text = [NSString stringWithFormat:@"赞 %ld",model.zan];
    
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
    CGFloat width = (ScreenWidth - 60.0) / 3.0 + 10;
    self.height.constant =  width * zhangshu;
    
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotourldongtaiD *model = self.hotArray[indexPath.row];
    //重用cell
    DianziQingjianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell" forIndexPath:indexPath];
    [cell.image sd_setImageWithUrl:model.photourl placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.clickImageSubject sendNext:indexPath];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (ScreenWidth - 60.0) / 3.0;
    return CGSizeMake(width,width);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 10, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
@end
