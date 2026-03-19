//
//  AnlieBuThressTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AnlieBuThressTableViewCell.h"
#import "ShangjiaThreeCollectionViewCell.h"

static const NSInteger kAnlieCommentGridColumnCount = 3;
static const CGFloat kAnlieCommentGridSpacing = 12.0f;
static const CGFloat kAnlieCommentGridVerticalInset = 10.0f;

@implementation AnlieBuThressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.coection.delegate = self;
    self.coection.dataSource = self;
    self.coection.scrollEnabled = NO;
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

    NSInteger rows = [self gridRowCount];
    if (rows == 0) {
        self.height.constant = 0;
    }else {
        self.height.constant = [self collectionContentHeight];
    }
    [self.coection reloadData];
}

- (NSInteger)gridRowCount {
    if (self.fuwuArray.count == 0) {
        return 0;
    }
    return (NSInteger)ceil(self.fuwuArray.count / (CGFloat)kAnlieCommentGridColumnCount);
}

- (CGFloat)gridItemWidthForCollectionView:(UICollectionView *)collectionView {
    CGFloat availableWidth = CGRectGetWidth(collectionView.bounds) - (kAnlieCommentGridColumnCount - 1) * kAnlieCommentGridSpacing;
    return floor(availableWidth / kAnlieCommentGridColumnCount);
}

- (CGFloat)collectionContentHeight {
    NSInteger rows = [self gridRowCount];
    if (rows == 0) {
        return 0.0f;
    }
    CGFloat itemWidth = [self gridItemWidthForCollectionView:self.coection];
    return kAnlieCommentGridVerticalInset + rows * itemWidth + (rows - 1) * kAnlieCommentGridSpacing + kAnlieCommentGridVerticalInset;
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
    cell.imagew.layer.borderWidth = 1.0f;
    cell.imagew.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = [self gridItemWidthForCollectionView:collectionView];
    return CGSizeMake(itemWidth, itemWidth);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kAnlieCommentGridVerticalInset, 0, kAnlieCommentGridVerticalInset, 0);
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kAnlieCommentGridSpacing;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return kAnlieCommentGridSpacing;
    
}
@end
